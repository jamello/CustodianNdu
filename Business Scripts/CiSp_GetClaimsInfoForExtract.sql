set ansi_nulls off;
go  
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_GetClaimsInfoForExtract', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_GetClaimsInfoForExtract;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_GetClaimsInfoForExtract]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_GetClaimsInfoForExtract] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_GetClaimsInfoForExtract] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_GetClaimsInfoForExtract] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_GetClaimsInfoForExtract
(		
		@pCompany_Id		nvarchar(3)
    ,   @pRefNo				nvarchar(10)
    ,	@pProcess_From_Date date  		
    ,   @rClaimsProductCd	    nvarchar(10) output
    ,   @rBusinessType	    nvarchar(10) output
    ,   @rClaimsAmt	       decimal(23,9) output    
   	,	@pDebug				tinyint 
	,	@rSqlError			int output
	,	@rErrorText			nvarchar(1000) output
 )
 with encryption
AS
	/*  
        Author	    : James C. Nnannah
        Create date : August 2014
        Description : Extracts some important info from claims to be used 
		Version     : 1
		
	:-------:-----------History-----:---------------------------------------------------------------------------: 
	:  Ver  :Date      :Name        :Notes                                                                      :
	:-------:-----------------------:---------------------------------------------------------------------------: 
	:       :		   :            :																			:
	:       :          :            :												                            :
	:       :          :            :                                                                           :	    	    
	:       :          :            :															                :	    	    
	:       :          :            :                                                                           :	    	    
	:       :          :            :                                                                           :	    	    
	:-------:-----------------------:---------------------------------------------------------------------------: 
	
			
	*/
	    set nocount on;

		Declare @sPrintDebug	varchar(120)
		,		@ReturnCode		int
		,		@Rowcount		int 
		,		@Claim_Date			datetime 

			if @pDebug > 0 
				Print 'Starting CiSp_GetClaimsInfoForExtract......... - ' 
				
			--
			--  initialiase the return variables
			--
				
			select  
					@Rowcount       = 0
				,   @rErrorText     = ''
				,   @pDebug         = ISNULL(@pDebug,0)
 			--
			-- validate value of @pMandate   
			--
			--
            --  validate  cscs acct o
			--
		    if (@pRefNo is null) 
		    begin
			    select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Invalid Claims no. --> (' + isnull(@pRefNo,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				
			--
			-- Check for and retrieve the claim details
			--
			else
			begin
					--
				SELECT 
					   @rClaimsProductCd = [TBIL_CLM_RPTD_PRDCT_CD]
					  , [TBIL_CLM_RPTD_CLM_TYPE]
					  , @Claim_Date = [TBIL_CLM_RPTD_POLY_FROM_DT]
					  ,@rClaimsAmt = [TBIL_CLM_RPTD_BASIC_LOSS_AMT_LC]
				FROM [TBIL_CLAIM_REPTED] WHERE [TBIL_CLM_RPTD_CLM_NO] = @pRefNo					
				
				if 


					if @pDebug > 0
						print '******** Start Processing Group Fees in CiSp_GetClaimsInfoForExtract (Buy) ..............'  

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
						select @rErrorText = 'CiSp_GetClaimsInfoForExtract.....: Error calculating order fees ' + @rErrorText  
													
						if @pDebug > 0
							print @rErrorText

						 return @ReturnCode
					end		
								
					if @pDebug > 0
						print '******** End  Processing Group Fees in CiSp_GetClaimsInfoForExtract (Buy) ..............'  
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
						print '******** End  Getting Client Available Bal  CiSp_GetClaimsInfoForExtract (Buy) ..............'  
												
					--
					-- Check if there is sufficient funds for trade
					--			
					If (@Available_Funds - @rNet_order ) < 0
					Begin
							select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Insufficient balance to execute transactin Available Funds --> ' 
												+ isnull(cast(@Available_Funds as nvarchar(50)),'Null') + ', Net Order --> '
												+ isnull(cast(@rNet_order as nvarchar(50)),'Null') + ' '											
												
							if @pDebug > 0
								print @rErrorText
							return -236604
				   end
					if @pDebug > 0
						print '******** End  Checking Available Bal  CiSp_GetClaimsInfoForExtract (Buy) ..............'  
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
						select @rErrorText = 'CiSp_GetClaimsInfoForExtract....:Error retriving client portofilio details  '
						
						if @pDebug > 0
							print @rErrorText

						 return -236605
					end				
			
							--
				    -- Any increase in pending or deductable should not dcrease the available nit to less than 0 
				    --
				    if (@Units_Available - @pUnits_Ordered) < 0
				    begin
					    select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Insufficient units in portfolio to complete order. Units Ordered --> ' 
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
					    select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Client does not have ' 
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
						select @rErrorText = 'CiSp_GetClaimsInfoForExtract.....: Error calculating order fees ' + @rErrorText  
	
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
						select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Error maintaining system table. Contact Administrator --> ' + @rErrorText  
	
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
				select @rErrorText = 'CiSp_GetClaimsInfoForExtract....: Error maintaining system table. Contact Administrator --> ' + @rErrorText  

				if @pDebug  > 0   
					print @rErrorText

				 return -236609
			end								
			
return 0
GO

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_GetClaimsInfoForExtract]') 
			AND type in (N'P'))
	Print '<<< Success Procedure [dbo].[CiSp_GetClaimsInfoForExtract] created !!! >>>'
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_GetClaimsInfoForExtract] Not created >>>'
GO		  