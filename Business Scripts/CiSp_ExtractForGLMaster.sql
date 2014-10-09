set ansi_nulls off;
go  
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_ExtractForGLMaster', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_ExtractForGLMaster;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_ExtractForGLMaster]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_ExtractForGLMaster] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_ExtractForGLMaster] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_ExtractForGLMaster] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_ExtractForGLMaster
(		
		@pCompany_Id		smallint
    ,	@pPrice				decimal(21,6) 
	,	@rGross_Total		decimal(21,6) output
	,	@rTotal_Fees		decimal(21,6)  output
	,	@rNet_order			decimal(21,6)  output 
	,   @pOrder_Date        DateTime 
    ,   @pParam1	        nvarchar(50)
   	,	@pDebug				tinyint 
	,	@rSqlError			int output
	,	@rErrorText			nvarchar(1000) output
 )
 with encryption
AS
	/*  
        Author	    : Lanre Makinde
        Create date : Oct  2010
        Description : Review Stock Order
		Version     : 3
		
	:-------:-----------History-----:---------------------------------------------------------------------------: 
	:  Ver  :Date      :Name        :Notes                                                                      :
	:-------:-----------------------:---------------------------------------------------------------------------: 
	:   2   :June 2012 :L. Makinde  :  Added parameters Order date, Cscs Acct No, All_None, Order Type          :
	:       :          :            :  to the procedure so validateion cane be done                             :
	:       :          :            :                                                                           :	    	    
	:   3   :July 2012 :L, Makinde  : Extended the procdure to handle Simulation of the Stock Order             :	    	    
	:       :          :            :                                                                           :	    	    
	:       :          :            :                                                                           :	    	    
	:-------:-----------------------:---------------------------------------------------------------------------: 
	
			
	*/
	    set nocount on;

		Declare @sPrintDebug	varchar(120)
		,		@ReturnCode		int
		,		@Rowcount		int 
		,		@Action			nvarchar(20)   /* Increase , Decrease */
		,		@Gross_Fees		decimal(21,6)
		,		@Fee_Tax		decimal(21,6)
		,		@Calc_Id		int
		,		@Available_Funds		decimal(21,6)
		,		@Units_Available		bigint
		,		@Pending_Cross_Deals	bigint
		,		@pUnits_On_Lien			bigint
		,		@pPending_Sell_Order	bigint

			if @pDebug > 0 
				Print 'Starting CiSp_ExtractForGLMaster......... - ' 
				
			--
			--  initialiase variables
			--
				
			select  @rGross_Total    = 0 
				,	@rTotal_Fees     = 0
				,	@rNet_order      = 0
				,	@Rowcount       = 0
				,   @rErrorText     = ''
				,   @pAll_None       = ISNULL(@pAll_None,0)
				,   @pDebug         = ISNULL(@pDebug,0)
 			--
			-- validate value of @pMandate   
			--
			if ( @pMandate not in ('Buy','Sell'))
			begin
				select @rErrorText = 'CiSp_ExtractForGLMaster....: Invalid Mandate --> ' + isnull(@pMandate,'Null') + ' '
				if @pDebug > 0
					print @rErrorText

				 return -236600
			end	
			--
			-- validate qty ordered
			--
			select @pUnits_Ordered = isnull(@pUnits_Ordered , 0)
			--
			--
			if ( @pUnits_Ordered <= 0  ) 
			begin
				select @rErrorText = 'CiSp_ExtractForGLMaster....: Invalid Order value. --> (' + @pUnits_Ordered + ')'
				
				if @pDebug > 0
					print @rErrorText

				 return -236601
			end	
			--
			-- validate value of No of Transaction units 
			--
			if ( @pPrice  <= 0  ) or (@pPrice is null)
			begin
				select @rErrorText = 'CiSp_ExtractForGLMaster....: Invalid price quote --> (' + @pPrice + ')'
				
				if @pDebug > 0
					print @rErrorText

				 return -236603
			end				

			--
			-- validate Client_Id   
			--
			exec @ReturnCode = Ctsp_Validations @pCompany_Id, 'Client_Id',@pClient_ID,@pDebug , @rSqlError output	, @rErrorText output
			if @ReturnCode <> 0
				return @ReturnCode	
			--
			-- validate Stock_Code
			--
			exec @ReturnCode = Ctsp_Validations @pCompany_Id, 'Stock_Code',@pStock_Code,@pDebug , @rSqlError output	, @rErrorText output
			if @ReturnCode <> 0
					return @ReturnCode		
					
			if (@pParam1 = 'WhatIf')
			Begin
			        begin try
		                exec @ReturnCode =  Ctsp_WhatIfReviewStkOrders 
		                                        @pCompany_Id			
						                    ,	@pClient_ID	 		
						                    ,	@pMandate			
						                    ,	@pStock_Code		
						                    ,	@pUnits_Ordered		
						                    ,	@pOrder_Type		
						                    ,	@pPrice			   
						                    ,	@rGross_Total   output
						                    ,	@rTotal_Fees    output	
						                    ,	@rNet_order	    output

	                                        ,   @pOrder_Date   
	                                        ,   @pCsCs_AcctNo  
	                                        ,	@pAll_None     
                                            ,   @pParam1	   
                    						    
						                    ,	@pDebug				
						                    ,	@rSqlError      output	
						                    ,	@rErrorText     output
				     end try		                    
				     Begin catch
				            set @rErrorText = ERROR_MESSAGE()
				            set @rSqlError  = ERROR_NUMBER()
				     end catch

                    if (@ReturnCode	!= 0) or (@rSqlError != 0)
                    begin
                        select @rErrorText = 'CiSp_ExtractForGLMaster.....: Error processing order simulation ' + @rErrorText  
                        
                        if @ReturnCode	!= 0
                            return @ReturnCode
                        else
                            return @rSqlError    
                    
                    end
                    else
                        return 0	-- If no error then break.  This is  a simulation
			end
            --			
            --  validate  cscs acct o
			--
		    if (@pCsCs_AcctNo is null) 
		    or 
		    (@pCsCs_AcctNo not in ( select CsCs_AcctNo
		                           from Client_CsCs_Accts
		                           where Company_Id = @pCompany_Id
		                           and Client_ID    = @pClient_ID  
		                           and Status       = 'Active'           
		                           )
            )
		    begin
			    select @rErrorText = 'CiSp_ExtractForGLMaster....: Invalid client CsCs Acct no. --> (' + isnull(@pCsCs_AcctNo,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				
			--
			-- Executue Buy Order
			--
			if (@pMandate = 'Buy')
			begin
					--
					-- Calculate Gross Order Total
					--
					select @rGross_Total = @pUnits_Ordered * @pPrice
					--
					--  calculate Order Fees
					--
					--  ('Sell-Order-Fees','Buy-Order-Fees','Cross-Deal-Fees')	 
					if @pDebug > 0
						print '******** Start Processing Group Fees in CiSp_ExtractForGLMaster (Buy) ..............'  

					exec  @ReturnCode = Ctsp_CalcGroupFees	
					                    @pCompany_Id 
					               ,    'Buy-Order-Fees'	
					               ,    @rGross_Total  
					               ,	@Gross_Fees  output 
					               ,    @Fee_Tax  output	
					               ,    @rTotal_Fees  output
					               ,    @Calc_Id  output
					               ,	Null				
					               ,    @pDebug  			
					               ,    @rSqlError  output 	
					               ,    @rErrorText  output  

					if (@ReturnCode!= 0 ) or  (@rSqlError != 0)
					begin
						select @rErrorText = 'CiSp_ExtractForGLMaster.....: Error calculating order fees ' + @rErrorText  
													
						if @pDebug > 0
							print @rErrorText

						 return @ReturnCode
					end		
								
					if @pDebug > 0
						print '******** End  Processing Group Fees in CiSp_ExtractForGLMaster (Buy) ..............'  
					--
					-- Calculate Net order
					--
					Select @rNet_order = @rGross_Total + @rTotal_Fees
					--
					-- Get Client Available Funds 
					--
					select @Available_Funds = rAvailable_Funds 
					from dbo.CtFn_LookupClientDetails (@pCompany_Id)
					where rClient_ID =  @pClient_ID    
					
					if @pDebug > 0
						print '******** End  Getting Client Available Bal  CiSp_ExtractForGLMaster (Buy) ..............'  
												
					--
					-- Check if there is sufficient funds for trade
					--			
					If (@Available_Funds - @rNet_order ) < 0
					Begin
							select @rErrorText = 'CiSp_ExtractForGLMaster....: Insufficient balance to execute transactin Available Funds --> ' 
												+ isnull(cast(@Available_Funds as nvarchar(50)),'Null') + ', Net Order --> '
												+ isnull(cast(@rNet_order as nvarchar(50)),'Null') + ' '											
												
							if @pDebug > 0
								print @rErrorText
							return -236604
				   end
					if @pDebug > 0
						print '******** End  Checking Available Bal  CiSp_ExtractForGLMaster (Buy) ..............'  
			end  -- End Buy Operation
			--
			-- Executue Sell Order
			--
			else if (@pMandate = 'Sell')
			begin
					-- current available unit
					SELECT     @Units_Available = Product_Total - (units_On_Lien +  Pending_Cross_Deals + Pending_Sell_Order) 
					,		   @Pending_Cross_Deals = Pending_Cross_Deals
					,		   @pUnits_On_Lien  = units_On_Lien
					,		   @pPending_Sell_Order  = Pending_Sell_Order
					FROM     dbo.Client_Portfolio
					WHERE    (Company_Id =  @pCompany_id) 
					AND		 (Client_ID = @pClient_id)
					and		 Product_Code = @pStock_Code
					
					select @rSqlError =  @@ERROR, @RowCount = @@ROWCOUNT

					if (@rSqlError != 0 ) or (@RowCount != 1)
					begin
						select @rErrorText = 'CiSp_ExtractForGLMaster....:Error retriving client portofilio details  '
						
						if @pDebug > 0
							print @rErrorText

						 return -236605
					end				
			
							--
				    -- Any increase in pending or deductable should not dcrease the available nit to less than 0 
				    --
				    if (@Units_Available - @pUnits_Ordered) < 0
				    begin
					    select @rErrorText = 'CiSp_ExtractForGLMaster....: Insufficient units in portfolio to complete order. Units Ordered --> ' 
					    + cast(@pUnits_Ordered as varchar(15))+ ', Units Available -- >  ' 
					    + cast(@Units_Available as varchar(10))+ ' '
    					
					    if @pDebug > 0
						    print @rErrorText

					     return -236606
				    end	
			        --
				    -- Revalidate Portfolio
				    -- cannot sell an item that is not in portfolio
				    --
				    if not exists  (select 1 from Client_Portfolio
				                    where Company_Id = @pCompany_Id
				                    and Client_ID = @pClient_ID
				                    and Product_Code =  @pStock_Code
				                    )
				    begin 
					    select @rErrorText = 'CiSp_ExtractForGLMaster....: Client does not have ' 
					                         +isnull(@pStock_Code,'Null' ) + ' in portfilio '

					    if @pDebug > 0
						    print @rErrorText

					     return -236607	
				    end
					--
					-- Calculate Gross Order Total
					--
					select @rGross_Total = @pUnits_Ordered * @pPrice
					--
					--  calculate Order Fees
					--
					--  ('Sell-Order-Fees','Buy-Order-Fees','Cross-Deal-Fees')	 

					exec  @ReturnCode = Ctsp_CalcGroupFees	
					                    @pCompany_Id 
					               ,    'Sell-Order-Fees'	
					               ,    @rGross_Total  
					               ,	@Gross_Fees  output 
					               ,    @Fee_Tax  output	
					               ,    @rTotal_Fees  output
					               ,    @Calc_Id  output
					               ,	Null				
					               ,    @pDebug  			
					               ,    @rSqlError  output 	
					               ,    @rErrorText  output  

					if (@ReturnCode!= 0 ) or  (@rSqlError != 0)
					begin
						select @rErrorText = 'CiSp_ExtractForGLMaster.....: Error calculating order fees ' + @rErrorText  
	
						if @pDebug  > 0   
							print @rErrorText

						 return @ReturnCode	
					end			
					--
					-- Calculate Net order
					--
					Select @rNet_order = @rGross_Total + @rTotal_Fees
					
					--
					-- Purge Work Table created in Ctsp_CalcGroupFees
					--					
					BEGIN TRY
							delete from [Gb_Wrk_Group_Fees]
							where  Company_Id = @pCompany_Id
							and Calc_Id = @Calc_Id
					END TRY
					BEGIN CATCH
						set @rErrorText = ERROR_MESSAGE()
						select @rSqlError = ERROR_NUMBER() ;					
					END CATCH;	
					
					if (@rSqlError != 0)
					begin
						select @rErrorText = 'CiSp_ExtractForGLMaster....: Error maintaining system table. Contact Administrator --> ' + @rErrorText  
	
						if @pDebug  > 0   
							print @rErrorText

						 return -236608
					end						
			end	 -- end Sell Order	
			
			if @pDebug > 0
				print ' Deleting Gb_Wrk_Group_Fees ...........'			
			--
			-- Purge Work Table created in Ctsp_CalcGroupFees
			--					
			BEGIN TRY

							
					delete from [Gb_Wrk_Group_Fees] with (rowlock)
					where  Company_Id = @pCompany_Id
					and Calc_Id = @Calc_Id
			END TRY
			BEGIN CATCH
				set @rErrorText = ERROR_MESSAGE()
				select @rSqlError = ERROR_NUMBER() ;					
			END CATCH;		
			
			if (@rSqlError != 0)
			begin
				select @rErrorText = 'CiSp_ExtractForGLMaster....: Error maintaining system table. Contact Administrator --> ' + @rErrorText  

				if @pDebug  > 0   
					print @rErrorText

				 return -236609
			end								
			
return 0
GO

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_ExtractForGLMaster]') 
			AND type in (N'P'))
	Print '<<< Success Procedure [dbo].[CiSp_ExtractForGLMaster] created !!! >>>'
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_ExtractForGLMaster] Not created >>>'
GO		  