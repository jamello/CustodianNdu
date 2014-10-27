set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_ExtractForAllocation', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_ExtractForAllocation;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_ExtractForAllocation]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_ExtractForAllocation] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_ExtractForAllocation] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_ExtractForAllocation] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_ExtractForAllocation
(
		@pCompany_Id	            smallint
	,	@pProcess_From_Date         Date  
	,	@pProcess_To_Date           Date  
	,	@rRecCount			        int             output  	
	,	@pDebug			            tinyint 
	,	@rSqlError		            int             output  
	,	@rErrorText		            nvarchar(1000) 	output  
 )
 with encryption
AS
	/*  
        Author	    : James C. Nnannah
        Create date : August 2014
        Description : Extract and Allocates Individual Receipt Transactions
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
	
	Error Codes: Start -->  -127051      :: End -->  - 127099			
			
	*/

         Declare 
                @Ref_No              [nvarchar](40)  	
			-------------------------------------    
            ,   @PRDCT_CD              [nvarchar](25)  	
            ,   @RECP_TYP				[nvarchar](1)  	
            ,	@Channel_Id			    smallint 
		    ,   @ReturnCode			    int
	        ,	@Rowcount			    int 
	        ,	@Create_Date		    smalldatetime
			-------------------------------------             	
            ,   @Seq_NO			        int 
	        ,   @Start_No               Int
	        ,   @MaxRecords             Int
	        ,   @intErrorCode           Int 
	        ,   @ExitCode               Int
	        ,	@Reversed			    Bit    
            ,   @ClaimsAmt				decimal(21,6)
            ,   @Premium1				decimal(21,6)
            ,   @Premium2				decimal(21,6)
            ,   @Savings1				decimal(21,6)
            ,   @Savings2				decimal(21,6)
            ,   @Lump1   				decimal(21,6)
            ,   @ChgPrem  				decimal(21,6)
            ,   @PolicyType  				decimal(21,6)
			,   @BusinessType	    nvarchar(25)
-----------------------------------------------------------
			,   @rProductCd	        nvarchar(50) 
			,   @rPolicyType	    nvarchar(5) 
			,   @rAllocationCode	nvarchar(1) 
			,   @rBusinessType	    nvarchar(25)
			,   @rTransAmt	        decimal(23,9)
			,   @rMOPPrem	        decimal(23,9)
			,   @rMOPContrib        decimal(23,9)
			,   @rYear				int
            
	        
		    --
		    -- Declare  Table variable to be used for processing
		    --
            Declare @ReceiptTransList Table
            (
	            sSeq_no					Int Identity(1,1)
            ,   sREF_NO		[nvarchar](40) NULL
            ,	sPRDCT_CD [nvarchar](15) NULL
			,	sRECP_TYP [nvarchar](1) NULL

            
            )
		
		set nocount on;
    	    --
		    -- initialise variables
		    --	
		     select 
		        @rErrorText             = ''
		     ,	@rSqlError              = 0
		     ,  @RowCount               = 0   
		     ,  @rRecCount              = 0 		 
		     ,  @Start_No               = 1  		     
		     ,  @MaxRecords             = 0 
		     ,  @intErrorCode           = 0	
		     ,  @ExitCode               = 0	 
             ,  @Channel_Id             = 30
             ,  @ReturnCode             = 0

            ,   @Premium1				= 0
            ,   @Premium2				= 0 
            ,   @Savings1				= 0
            ,   @Savings2				= 0
            ,   @Lump1   				= 0
            ,   @Chg_Prem  				= 0

		    if @pDebug > 0
			    print 'Starting CiSp_ExtractForAllocation.................'

		    --
			--
			-- Validate from date  
			--    	
		      if (@pProcess_From_Date is Null)
		      begin
				    select @rErrorText = 'CiSp_ExtractForAllocation.....:  Process from date cannot be null'
    				                    
				    if @pDebug > 0
					    print @rErrorText
    					
				        return -127052
	 	      end
              else 
		            if @pDebug > 0
			            print 'CiSp_ExtractForAllocation......: Process from date validated --> ' + cast(@pProcess_From_Date as nvarchar(20))

			--
			-- Validate process to  date  
			--    	
		      if (@pProcess_To_Date is Null)
		      begin
				    select @rErrorText = 'CiSp_ExtractForAllocation.....:  Process to date cannot be null'
    				                    
				    if @pDebug > 0
					    print @rErrorText
    					
				        return -127053 
	 	      end
              else 
		            if @pDebug > 0
			            print 'CiSp_ExtractForAllocation......: Process to date validated --> ' + cast(@pProcess_To_Date as nvarchar(20))
			            			            			     
             --
   					    
            /***************************************************
                Get Records To Process 
            ***************************************************/
              Begin Try
              
                    Insert into @ReceiptTransList    
						select 
						 TBFN_ACCT_REF_NO
						,TBFN_ACCT_PRDCT_CD
						,TBFN_ACCT_RECP_TYP
						from TBFN_RECPT_FILE
						where TBFN_ACCT_TRANS_COMP = @pCompany_Id
                    --and  TBFN_ACCT_APPRV_YN =  'Y'
                    and (TBFN_ACCT_ENTRY_DATE between @pProcess_From_Date and @pProcess_To_Date)
                                            

                    Select @MaxRecords = @@ROWCOUNT
                     
              End Try
              Begin Catch
		            Select @rErrorText = ERROR_MESSAGE()
		            ,      @rSqlError  = ERROR_NUMBER()
              End Catch    		                
              if  (@rSqlError != 0 )
              begin
	                select @rErrorText = 'CiSp_ExtractForAllocation.....: Error Retreving receipt details for allocation processing - '
	                                    + @rErrorText
    				                    
	                if @pDebug > 0  
		                print @rErrorText
					
	                Return -127100
              end
              else 
                if @pDebug > 0
                    print 'CiSp_ExtractForAllocation......:Receipt details Retrieved ' 
                            + ltrim(cast(@MaxRecords as nvarchar(50)))  
                  --
                  --Begin Processing
                  --
                  While @Start_No <= @MaxRecords  -- Beging processing  receipt record 
                  begin
                         --
                         -- Clear variables
                         --
                          select
			                    @ExitCode			    = 0
	                        ,	@intErrorCode		    = 0
	                        ,   @rSqlError              = 0 
	                        ,   @rErrorText             = ''
                            -----------------------------------------
         	                ,   @Seq_NO					= 	 Null	 
                            ,   @Ref_No				= 	 Null	 
    						
                            -----------------------------------------------
                            -- Start A Transaction if non has been started
                            -----------------------------------------------
                            begin
		                        if @@trancount = 0
			                        Begin Tran
                            end	
                           --
                           --
                           --						  
                           Save Tran  DetailWork;            						
                           --
                           --  Get the ref no record to extract
                           --
				           select
             	                @Seq_NO		    = 	sSeq_NO			 
                            ,   @Ref_No		=	sREF_NO	
                            ,   @PRDCT_CD		=	sPRDCT_CD
                            ,   @RECP_TYP		=	sRECP_TYP
                           from @ReceiptTransList		  
                           where sSeq_NO		    = @Start_No   

		                   select @RowCount = @@ROWCOUNT	, @rSqlError = @@Error

		                   if (@RowCount != 1 ) or  (@rSqlError != 0)
		                   begin
					                Begin
						                if @@TRANCOUNT > 0
							                Rollback Tran DetailWork 
					                end								    
    														    
					                select @rErrorText = 'CiSp_ExtractForAllocation....: Error Retreving  ref no(1)' 
    																
					                if @pDebug > 0  
						                print @rErrorText
    								
					                select @intErrorCode = -127101
    																		 	
					                goto ERR_HANDLER								
		                    end  
                            else 
                                if @pDebug > 0
                                    print 'CiSp_ExtractForAllocation......: Retrived ref no Details --> '
                                            + LTRIM(str(@Ref_No)) 
                            ------------------------------------------------------
                            -- Submit verification for Claims 
                            ------------------------------------------------------	  
                                  					            
				            if @RECP_TYP = 'Y'
				            begin
				             --validate for claims				             
				            Begin Try       

                                    Exec @ReturnCode = CiSp_GetProductsInfoForExtract
		                                    @pCompany_Id 
                                        ,   @Ref_No             
                                        ,   @RECP_TYP
                                        ,   @pProcess_From_Date
	                                    ,	@rProductCd output
                                        ,   @rPolicyType output 
                                        ,   @rAllocationCode output
                                        ,   @rBusinessType output
                                        ,   @rTransAmt output
                                        ,   @rMOPPrem output
                                        ,   @rMOPContrib output
                                        ,   @rYear output
	                                    ,	@pDebug			    
	                                    ,	@rSqlError		    output  
	                                    ,	@rErrorText		    output     

                              End Try
                              Begin Catch
                                    Select @rErrorText = ERROR_MESSAGE()
                                    ,      @rSqlError  = ERROR_NUMBER()
                              End Catch  

                              if (@ReturnCode != 0 ) or  (@rSqlError != 0)
                              begin
			                            begin
				                            if @@TRANCOUNT > 0
					                            Rollback Tran DetailWork 
			                            end								    
        														    
			                            select @rErrorText = 'CiSp_ExtractForAllocation....: Error retrieving values. Ref No '
			                                                + ltrim(Str(@Ref_No)) + ' - '
			                                                + @rErrorText
			                            if @pDebug > 0  
				                            print @rErrorText
        								
			                            select @intErrorCode = -127054
        																		 	
			                            goto ERR_HANDLER								
                               end   
                               else 
                              --  if @pDebug > 0
                              --insert record into the allocation table
									SELECT @PRDCT_CD = @rProductCd
										  ,@PolicyType = @rPolicyType
										  ,@BusinessType = @rBusinessType
										  ,@ClaimsAmt = @rTransAmt
									 			
				            Begin Try       

                                    Exec @ReturnCode = CiSp_CreateAllocationDetails
		                                    @pCompany_Id 
                                        ,   @Ref_No             
                                        ,   @RECP_TYP
                                        ,   @pProcess_From_Date
	                                    ,	@rProductCd output
                                        ,   @rPolicyType output 
                                        ,   @rAllocationCode output
                                        ,   @rBusinessType output
                                        ,   @rTransAmt output
                                        ,   @rMOPPrem output
                                        ,   @rMOPContrib output
                                        ,   @rYear output
	                                    ,	@pDebug			    
	                                    ,	@rSqlError		    output  
	                                    ,	@rErrorText		    output     

                              End Try
                              Begin Catch
                                    Select @rErrorText = ERROR_MESSAGE()
                                    ,      @rSqlError  = ERROR_NUMBER()
                              End Catch  

                              if (@ReturnCode != 0 ) or  (@rSqlError != 0)
                              begin
			                            begin
				                            if @@TRANCOUNT > 0
					                            Rollback Tran DetailWork 
			                            end								    
        														    
			                            select @rErrorText = 'CiSp_ExtractForAllocation....: Error processing valuation. Ref No '
			                                                + ltrim(Str(@Ref_No)) + ' - '
			                                                + @rErrorText
			                            if @pDebug > 0  
				                            print @rErrorText
        								
			                            select @intErrorCode = -127054
        																		 	
			                            goto ERR_HANDLER								
                               end   
                               else 


                                   print '*** Successfully process data extraction. Ref No --> '
                                         + STR(@Ref_No) 

                                ------------------------------------------------------
                                --You can do any other update of other files
                                --Update Client profile Table with maintenance information
                                ------------------------------------------------------	  
                              --  Begin Try
                                
                              --      update Client_Profiles
                              --      set Last_Valuation_Date = CAST(@pProcess_From_Date as Date)
                              --      where Company_Id =  @pCompany_Id
                              --      and   Client_ID  = @Ref_No
                                
                              --      Select @Rowcount = @@ROWCOUNT
                                    
                              --End Try
                              --Begin Catch
                              --      Select @rErrorText = ERROR_MESSAGE()
                              --      ,      @rSqlError  = ERROR_NUMBER()
                              --End Catch  
                              --if (@Rowcount != 1) or (@rSqlError != 0)
                              --begin
		                            --Begin
			                           -- if @@TRANCOUNT > 0
				                          --  Rollback Tran DetailWork 
		                            --end								    
    														    
		                            --select @rErrorText = 'CiSp_ExtractForAllocation....: Error updating client profile table. Client Id '
		                            --                    + ltrim(Str(@Ref_No)) + ' - '
		                            --                    + @rErrorText
		                            --if @pDebug > 0  
			                           -- print @rErrorText
    								
		                            --select @intErrorCode = -127055
    																		 	
		                            --goto ERR_HANDLER
                              -- end   
                              -- else 
                              --   if @pDebug > 0
                              --     print '*** Updated Client Profile  for Client --> '
                              --           + STR(@Ref_No) 
                           end
                            
                                ERR_HANDLER:	 
		    	                            IF (@intErrorCode != 0) 
				                            BEGIN
			    		                            Begin
							                            if @@TRANCOUNT > 0
								                            Save Tran Errorupdate 
							                            else
							                            begin
								                            Begin Tran
								                            Save Tran Errorupdate 
							                            end	
						                            end	
						                            --
						                            --
						                            --	
					                                begin try
                                                            -- Insert into EOD Error Log
                                                            INSERT INTO dbo.EOD_Process_Log
                                                                       (Company_Id
                                                                       ,EOD_Id
                                                                       ,Job_Sequence        
                                                                       ,Job_Id              
                                                                       ,Job_Sub_Sequence    
                                                                       ,Process_Source
                                                                       ,Process_From_Date
                                                                       ,Process_To_Date
                                                                       ,Product_Type
                                                                       ,Product_Id
                                                                       ,Error_Code
                                                                       ,SQL_Error
                                                                       ,Error_Text
                                                                       ,Create_Date
                                                                       ,Create_User_Id)
                                                                 VALUES
                                                                       (@pCompany_Id
                                                                       ,@pEOD_Id
                                                                       ,@pJob_Sequence        
                                                                       ,@pJob_Id              
                                                                       ,@pJob_Sub_Sequence                                                     
                                                                       ,'EOD - Client Portfolio Valuation'
                                                                       ,@pProcess_From_Date
                                                                       ,@pProcess_To_Date
                                                                       ,'Client'
                                                                       ,@Ref_No
                                                                       ,@intErrorCode
                                                                       ,@rSqlError
                                                                       ,@rErrorText
                                                                       ,GETDATE()
                                                                       ,@pProcess_User_Id
                                                                       )
                                                            
						                                select @RowCount = @@ROWCOUNT
                    						            
					                                End Try
					                                Begin catch
                                                                Select @rErrorText = ERROR_MESSAGE()
                                                                ,      @rSqlError  = ERROR_NUMBER()		
					                                End Catch	
                        												
					                                if (@RowCount != 1 or @rSqlError != 0 )  
					                                begin
							                                select @rErrorText = 'CiSp_ExtractForAllocation ...: Critical Error !!! Logging Processing error :' 
							                                                    + @rErrorText  														
							                                if @pDebug > 0  
								                                print @rErrorText
                            									    
								                            Begin
									                            if @@TRANCOUNT > 0
										                            Rollback  Tran Errorupdate;	
								                            end	
								                            
							                                select @ExitCode =  -127059
							                                goto ExitWork
					                                end	
					                                else
						                            Begin
								                            if @@TRANCOUNT > 0
									                            commit tran Errorupdate
						                            end					    
				                            END	  -- if (@intErrorCode != 0)	
				                            else if (@intErrorCode = 0)
				                            begin   -- Record Successfully Processed 
                    				        
					                            if @pDebug > 0
						                            print '*** Record Successfully Processed '				    

											                    if @@TRANCOUNT > 0
												                    commit tran DetailWork
                    														
			   			                    end  -- if (@intErrorCode = 0)	

 	  		                        --
		                            -- Get next Record 
		                            --
		                            if (@Start_No = @MaxRecords)  -- Exit Loop if this is end of work 
			                            break;
                        			
		                            select @Start_No = @Start_No + 1   --- Increment counter to get next record
	                           end   -- End Processing of  Detailed list  Records 
	  
ExitWork:

		if @pDebug > 0 
		    print 'End CiSp_ExtractForAllocation........... Records Processed --> '+ ltrim(str(@MaxRecords))
			
        select @rRecCount = @MaxRecords			

        Return @ExitCode  
       
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'dbo.CiSp_ExtractForAllocation') 
			AND type in (N'P')
			)
	Print '<<< Success Procedure dbo.CiSp_ExtractForAllocation created !!! >>>'
else
	Print '<<< !!! Error Procedure dbo.CiSp_ExtractForAllocation Not created >>>'
GO
