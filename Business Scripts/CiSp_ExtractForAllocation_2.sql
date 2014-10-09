set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO
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
	
			
	*/

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

--select * from Prod_Margin_Hist
create proc  [dbo].CiSp_ExtractForAllocation
(
				@pCompany_Id	nvarchar(3)
			,	@pStartDate		Datetime 
			,	@pEndDate		Datetime 
			,	@pDebug			tinyint 
			,	@rSqlError		int  output  
			,	@rErrorText		nvarchar(1000) 	output  
 )
 with encryption
AS
	/*  
		Version = 1  
	*/
		 Declare 
				@sPrintDebug varchar(120)
			,	@ReturnCode	int
			,	@Rowcount int 
			,	@Tran_Date date
			,	@Channel_Id smallint
			,	@rOption_Value varchar(10)
			,	@rData_Type varchar(15) 
			, 	@max_no smallint	
			,   @Start_No smallint	
			,	@Margin_Id	int
			,	@Row_Version int
			,	@Client_Row_Version int
			,	@Posting_Branch   smallint  
			,	@Target_Branch   smallint  
			,	@Status  varchar (15)
			,	@Client_Id Int
			,	@Reversed	Bit
			,	@Reversal_Date smalldatetime
			,	@Fee		smallint 	 
			,	@Composite_Fee smallint  
			,	@Fee_amount	 decimal(21,6) 	 
			,	@Fee_tax  decimal(21,6)  
			,	@Description   varchar(150)  
			,	@Effective_Date   smalldatetime   
			,	@Supervised_By   Int
			,	@Amount   decimal (21,6) 
			,	@Currency_Iso nvarchar(3)
			,	@Local_Currency_Iso nvarchar(3)			
			,	@Row_Id	 bigint

 		--Print Procedure parameters  
		if @pDebug = 1 
		begin
			print @sPrintDebug  
		end 
		--
		-- initialise variables
		--	
		 select @rErrorText = Null
		 ,	@rSqlError = 0
		 ,	@sPrintDebug = ''
		 ,	@Channel_Id = 19   -- Product Margin
		--
		-- check if batch has no transactions to process
		--




		if not exists (Select 1  From TBFN_RECEPT_FILE
				  Where TBFN_ACCT_TRANS_COMP = @pCompany_Id
				  and TBFN_ACCT_ENTRY_DATE between  @pStartDate and @pEndDate
				  and TBFN_ACCT_APPRV_YN = 'Y'
				  )
		begin 
			select @rErrorText = 'Message !!! CiSp_ExtractForAllocation : There are no transactions to extract from << Start Date ' 
								 + isnull(cast(@pStartDate as varchar(15)),'') +' and End Date' + isnull(cast(@pEndDate as varchar(15)),'') +' >> '
			if @pDebug = 1  
			begin
				print @rErrorText
			end
			 return -299001					
		end
				--
				-- Get Transaction details for Validation
				--
				Select 		@Row_Id			=	Row_Id
					,		@Margin_Id		=  Margin_Id
					,		@Client_Id		=  Client_Id
					,		@Reversed		=  Reversed
					,		@Amount			=  Amount
					,		@Description	= [Description]
					,		@Fee			=  Fee
					,		@Composite_Fee	=  Composite_Fee
					,		@Fee_amount		=  Fee_amount
					,		@Fee_tax		=  Fee_tax
					,		@Currency_Iso	=  Currency_Iso
					,		@Row_version	=  Row_version
				 From Prod_Margin_Hist
				 Where Company_Id	= @pCompany_Id
				 and tran_id		= @pTran_Id
				 and Post_Code		= @pPost_Code
				 and [Status]		= 'Pending'
	 
					select @RowCount = @@ROWCOUNT, @rSqlError = @@ERROR

					If (@rSqlError > 0) or (@RowCount != 1)
					Begin
						select @rErrorText =  'Error !!! CiSp_ExtractForAllocation : Txn not found or in Invalid Status << Batch ID :: ' 
										+ cast(@pTran_id as varchar(15)) +' >> @pPost_Code <<'
										+ cast(@pPost_Code as nvarchar(10)) + ' >>'
							if @pDebug = 1  
							begin
								print @rErrorText
							end
						return -299005
					 End
	 
					--
					-- Throw exception if account is not in Unfunded status 
					--	   
					if  not exists (select 1 from Prod_Margins 
									where Company_Id = @pCompany_Id
									and Margin_Id = @Margin_Id
									and Status = 'UnFunded'
									)
					begin
						select @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: Invalid Transaction.  PC140 can only be posted '
											+ 'against an unfunded account  << ' 
											+ isnull(cast(@Margin_Id as nvarchar(10)),'Null') 
											+ ' >> ' 
								if @pDebug = 1  
								begin
									print @rErrorText
								end			  
						  return -299006
					end

					--
					-- validate Client_Id   
					--
					exec @ReturnCode = Ctsp_Validations @pCompany_Id, 'Client_Id',@Client_Id,@pDebug ,@rSqlError output ,@rErrorText output
					if @ReturnCode <> 0
							return @ReturnCode 	
					--
					-- Validate Margin Acct 
					--	 
					--exec @ReturnCode = Ctsp_Validations @pCompany_Id,'Margin_Acct',@Margin_Id,@pDebug ,@rSqlError output,@rErrorText output
					--if  (@ReturnCode = -105016) or (@ReturnCode = 0) -- Account is still unfunded so dint Abort 
					--begin
					--			select @rErrorText = '' , @rSqlError = 0
					--			return 0
					--end 
					--else 
					--	return @ReturnCode					

  					--
					-- Validate Currecny ISo code for batch header
					--	 
					exec @ReturnCode = Ctsp_Validations @pCompany_Id,'Iso_Code',@Currency_Iso ,@pDebug ,@rSqlError output,@rErrorText output
					if @ReturnCode <> 0
						return @ReturnCode 	
			
				  --
				  -- Reset the posting branch to the branch of the Process user
				  --
				  select @Posting_Branch = (select Branch_Id 
											from sec_users
											where Company_Id = @pCompany_Id 
											and    User_Id =  @pProcessed_By
											)
				--
				-- validate @Posting_Branch
				--
				exec @ReturnCode = Ctsp_Validations @pCompany_Id,'Branch_Id',@Posting_Branch,@pDebug ,@rSqlError output,@rErrorText output
				if @ReturnCode <> 0
				   return @ReturnCode	

				  --
				  -- Reset the target branch to the branch of client Account
				  --
				  select @Target_branch = (select Branch_Id  
										   from Client_Profiles 
										   where Company_Id = @pCompany_Id 								
										   and   Client_ID =  @Client_Id 
											)		   
								--
					-- validate @Target_branch
					--
					exec @ReturnCode = Ctsp_Validations @pCompany_Id,'Branch_Id',@Target_branch,@pDebug ,@rSqlError output,@rErrorText output
					if @ReturnCode <> 0
					   return @ReturnCode	
					--
					-- Currency must be local currency
					-- 
					if @Currency_Iso <>  @Local_Currency_Iso
					begin
						select @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: Invalid Transaction Currecny.  '
											+ 'All product are Denominated in Local Currency  << '
											+ isnull(@Currency_Iso,'Null') 
											+ ' >> ' 
								if @pDebug = 1  
								begin
									print @rErrorText
								end			  
						  return -299007	
					
					end  
					--
					-- validate the Funding amount Against the CLPE value 
					--	   
					if  (@Amount > (select (Collateral_Cover + CLPE_Limit) 
									from Prod_Margins 
									where Company_Id = @pCompany_Id
									and Margin_Id = @Margin_Id
									and Status = 'UnFunded'
									)
						)
					begin
						select @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: Posting amount grater than CLPE plus Collatera Cover) '
											+ 'Account cannot be Activated/ Funded  Margin Acct Id::<< ' 
											+ isnull(cast(@Margin_Id as nvarchar(10)),'Null') 
											+ ' >> ' 
								if @pDebug = 1  
								begin
									print @rErrorText
								end			  
						  return -299008
					end					
					--
					-- just making sure that this flag is not set to 1   
					--	
					if (@Reversed = 1)
					begin
						select @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: Status is pending ,but reversal is set to True << ' 
											+ isnull(cast(@Margin_Id as nvarchar(10)),'Null') 
											+ ' >> ' 
								if @pDebug = 1  
								begin
									print @rErrorText
								end			  
						  return -299009	
					end

			   		select @Client_Row_Version	= Row_Version  
					from  Client_Balances
					Where	company_id	= @pCompany_Id
					and		client_id	= @Client_Id

					if (@@rowcount != 1)
					begin
						select @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: Unable to retrive client balance record Client Id << '
											+ isnull(cast(@Client_Id as nvarchar(10)),'Null') 
											+ ' >> ' 
								if @pDebug = 1  
								begin
									print @rErrorText
								end			  
						  return -299010
					end						
					
					
			/*******************************************************************************************************/					
			/*******************************************************************************************************/							
				--
				-- Begin Updates
				--
			/*******************************************************************************************************/					
			/*******************************************************************************************************/				
				--
				-- update Product Margin Account 
				-- select approved_margin, * from Prod_Margins
				--
				BEGIN TRY
					Update Prod_Margins
					Set approved_margin	=  @Amount
					,	Status = 'Active'
					,	Row_Version		= Row_Version + 1
					where Company_Id = @pCompany_Id
					and Margin_Id = @Margin_Id
					and Status = 'UnFunded'

					select @Rowcount = @@ROWCOUNT, @rSqlError = @@ERROR

				END TRY
				BEGIN CATCH
					set    @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: '+ isnull(ERROR_MESSAGE(),'Null')
					select @rSqlError = ERROR_NUMBER() ;					
				END CATCH;	

				if  (@RowCount != 1) OR (@rSqlError != 0 )
				begin
					select @rErrorText =  @rErrorText + ':: Unable to Activate Margin Acount:: RowCount =  << ' 
										+ cast(@RowCount as varchar(10))+ ' >> @rSqlError <<' 
										+ cast(@rSqlError as varchar(10))+ ' >>'  
					if @pDebug = 1  
					begin
						print @rErrorText
					end
					 return -299011
				end
				--
				-- update transation in margin History
				--
				BEGIN TRY

					select * from Prod_Margin_Hist
					--
					Update Prod_Margin_Hist
						set Row_Version = Row_Version + 1
						,	Status = 'Processed'
						,	Target_Branch = @Target_Branch
						,	Posting_Branch = @Posting_Branch
						,	Channel_Id = @Channel_Id
					 From Prod_Margin_Hist
					 Where Company_Id	= @pCompany_Id
					 and tran_id		= @pTran_Id
					 and [Status]		= 'Pending'					
					 and Row_version	= @Row_version

					select @Rowcount = @@ROWCOUNT, @rSqlError = @@ERROR

				END TRY
				BEGIN CATCH
					set    @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: '+ isnull(ERROR_MESSAGE(),'Null')
					select @rSqlError = ERROR_NUMBER() ;					
				END CATCH;	
				
				if  (@RowCount != 1) OR (@rSqlError != 0 )
				begin
					select @rErrorText =  @rErrorText + ':: Unable to Transaction Record RowCount =  << ' 
										+ cast(@RowCount as varchar(10))+ ' >> @rSqlError <<' 
										+ cast(@rSqlError as varchar(10))+ ' >>'  
					if @pDebug = 1  
					begin
						print @rErrorText
					end
					 return -299012
				end
	
				--
				-- update Related Client Balances Information 
				--		
			   	BEGIN TRY		
			   			
					Update Client_Balances
						Set Avail_Margin = Avail_Margin + @Amount
						,	Row_Version	= Row_Version + 1
					Where	company_id	= @pCompany_Id
					and		client_id	= @Client_Id
					and		Row_Version = @Client_Row_Version 
						
						select @Rowcount = @@ROWCOUNT, @rSqlError = @@ERROR
				END TRY
				BEGIN CATCH
					set    @rErrorText = 'Error !!! CiSp_ExtractForAllocation :: '+ isnull(ERROR_MESSAGE(),'Null')
					select @rSqlError = ERROR_NUMBER() ;					
				END CATCH;	
					
				if (@rSqlError != 0 ) or (@Rowcount != 1)
				begin
					select @rErrorText = 'Error !!! CiSp_ExtractForAllocation : Unable to update Related Client Acct Balance Row Count = << ' 
										+ cast(@RowCount as varchar(10))+ ' >> @rSqlError <<' 
										+ cast(@rSqlError as varchar(10))+ ' >>  @Client_Id  << '  
										+ cast(@Client_Id as varchar(10))+ ' >>  '  										
										
					if @pDebug = 1  
					begin
						 Print @rErrorText
					end					
					return -299013
				end
		
	Print ' End of Procing Post code PC140........................'

 return 0
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'dbo.CiSp_ExtractForAllocation') 
			AND type in (N'P'))
	Print '<<< Success Procedure dbo.CiSp_ExtractForAllocation created !!! >>>'
else
	Print '<<< !!! Error Procedure dbo.CiSp_ExtractForAllocation Not created >>>'
GO
