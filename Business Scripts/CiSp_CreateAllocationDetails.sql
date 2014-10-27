set ansi_nulls off;
go  
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_CreateAllocationDetails', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_CreateAllocationDetails;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_CreateAllocationDetails]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_CreateAllocationDetails] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_CreateAllocationDetails] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_CreateAllocationDetails] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_CreateAllocationDetails
(		
		@pCompany_Id		nvarchar(3)
	   ,@pALLC_BATCH_NO  int
	   ,@pALLC_SER_NO  bigint
	   ,@pALLC_TRANS_TYP  nvarchar(1)
	   ,@pALLC_TEMP_TRANS_NO  nvarchar(40)
	   ,@pALLC_DOC_DATE  datetime
	   ,@pALLC_ENTRY_DATE  datetime
	   ,@pALLC_TRANS_MODE nvarchar(1)
	   ,@pALLC_RECP_TYP  nvarchar(1)
	   ,@pALLC_REF_NO  nvarchar(40)
	   ,@pALLC_PRDCT_CD  nvarchar(15)
	   ,@pALLC_DOC_NO  nvarchar(15)
	   ,@pALLC_CURRCY_TYPE  nvarchar(5)
	   ,@pALLC_CHQ_TELLER_NO  nvarchar(15)
	   ,@pALLC_CHQ_INWARD_NO  nvarchar(15)
	   ,@pALLC_CHQ_INWARD_DATE  datetime
	   ,@pALLC_PAYER_PAYEE_NAME  nvarchar(50)
	   ,@pALLC_TRANS_DESC1  nvarchar(100)
	   ,@pALLC_TRANS_DESC2  nvarchar(50)
	   ,@pALLC_BRANCH_CD  nvarchar(5)
	   ,@pALLC_BANK_CD  nvarchar(15)
	   ,@pALLC_AMT_LC  decimal(19,5)
	   ,@pALLC_AMT_FC  decimal(19,5)
	   ,@pALLC_INS_CODE  nvarchar(15)
	   ,@pALLC_AGENT_CODE  nvarchar(15)
	   ,@pALLC_COMM_YN  nvarchar(1)
	   ,@pALLC_POLY_CONTRIB  decimal(19,5)
	   ,@pALLC_POLY_MOP  nvarchar(1)
	   ,@pALLC_DR_MAIN  nvarchar(15)
	   ,@pALLC_DR_SUB  nvarchar(10)
	   ,@pALLC_CR_MAIN  nvarchar(15)
	   ,@pALLC_CR_SUB  nvarchar(10)
	   ,@pALLC_LEDG_TYP_CR  nvarchar(3)
   	,	@pDebug				tinyint 
	,	@rSqlError			int output
	,	@rErrorText			nvarchar(1000) output
 )
 with encryption
AS
	/*  
        Author	    : James C. Nnannah
        Create date : October 2014
        Description : Inserts allocation records to the table extracted from the receipt file
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
		,		@PolicyStartDate			datetime 
		,		@ClaimDate			datetime 

			if @pDebug > 0 
				Print 'Starting CiSp_CreateAllocationDetails......... - ' 
				
			--
			--  initialiase the return variables
			--
				
			select  
					@Rowcount       = 0
				,   @rErrorText     = ''
				,   @pDebug         = ISNULL(@pDebug,0)
 			--
			--
		    if (@pALLC_DOC_NO is null) 
		    begin
			    select @rErrorText = 'CiSp_CreateAllocationDetails....: Invalid Reference no. --> (' + isnull(@pALLC_DOC_NO,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				

		    
		    if (@pALLC_DR_MAIN is null) 
		    begin
			    select @rErrorText = 'CiSp_CreateAllocationDetails....: Invalid DR Account no. --> (' + isnull(@pALLC_DR_MAIN,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				

		    
			--
			--1. Claims
			begin
			
				if @pDebug > 0
				   print '******** Start Data Insertion in CiSp_CreateAllocationDetails ..............'  

					INSERT INTO [TBIL_FIN_RECT_GL_TRANS]
							   ([TBFN_ALLC_TRANS_COMP]
							   ,[TBFN_ALLC_BATCH_NO]
							   ,[TBFN_ALLC_SER_NO]
							   ,[TBFN_ALLC_TRANS_TYP]
							   ,[TBFN_ALLC_TEMP_TRANS_NO]
							   ,[TBFN_ALLC_DOC_DATE]
							   ,[TBFN_ALLC_ENTRY_DATE]
							   ,[TBFN_ALLC_TRANS_MODE]
							   ,[TBFN_ALLC_RECP_TYP]
							   ,[TBFN_ALLC_REF_NO]
							   ,[TBFN_ALLC_PRDCT_CD]
							   ,[TBFN_ALLC_DOC_NO]
							   ,[TBFN_ALLC_CURRCY_TYPE]
							   ,[TBFN_ALLC_CHQ_TELLER_NO]
							   ,[TBFN_ALLC_CHQ_INWARD_NO]
							   ,[TBFN_ALLC_CHQ_INWARD_DATE]
							   ,[TBFN_ALLC_PAYER_PAYEE_NAME]
							   ,[TBFN_ALLC_TRANS_DESC1]
							   ,[TBFN_ALLC_TRANS_DESC2]
							   ,[TBFN_ALLC_BRANCH_CD]
							   ,[TBFN_ALLC_BANK_CD]
							   ,[TBFN_ALLC_AMT_LC]
							   ,[TBFN_ALLC_AMT_FC]
							   ,[TBFN_ALLC_INS_CODE]
							   ,[TBFN_ALLC_AGENT_CODE]
							   ,[TBFN_ALLC_COMM_YN]
							   ,[TBFN_ALLC_POLY_CONTRIB]
							   ,[TBFN_ALLC_POLY_MOP]
							   ,[TBFN_ALLC_DR_MAIN]
							   ,[TBFN_ALLC_DR_SUB]
							   ,[TBFN_ALLC_CR_MAIN]
							   ,[TBFN_ALLC_CR_SUB]
							   ,[TBFN_ALLC_LEDG_TYP_CR])
						 VALUES
							   (
							   @pCompany_Id
							   ,@pALLC_BATCH_NO
							   ,@pALLC_SER_NO
							   ,@pALLC_TRANS_TYP
							   ,@pALLC_TEMP_TRANS_NO
							   ,@pALLC_DOC_DATE
							   ,@pALLC_ENTRY_DATE
							   ,@pALLC_TRANS_MODE
							   ,@pALLC_RECP_TYP
							   ,@pALLC_REF_NO
							   ,@pALLC_PRDCT_CD
							   ,@pALLC_DOC_NO
							   ,@pALLC_CURRCY_TYPE
							   ,@pALLC_CHQ_TELLER_NO
							   ,@pALLC_CHQ_INWARD_NO
							   ,@pALLC_CHQ_INWARD_DATE
							   ,@pALLC_PAYER_PAYEE_NAME
							   ,@pALLC_TRANS_DESC1
							   ,@pALLC_TRANS_DESC2
							   ,@pALLC_BRANCH_CD
							   ,@pALLC_BANK_CD
							   ,@pALLC_AMT_LC
							   ,@pALLC_AMT_FC
							   ,@pALLC_INS_CODE
							   ,@pALLC_AGENT_CODE
							   ,@pALLC_COMM_YN
							   ,@pALLC_POLY_CONTRIB
							   ,@pALLC_POLY_MOP
							   ,@pALLC_DR_MAIN
							   ,@pALLC_DR_SUB
							   ,@pALLC_CR_MAIN
							   ,@pALLC_CR_SUB
							   ,@pALLC_LEDG_TYP_CR
							   )
							
									
					select @rSqlError =  @@ERROR, @RowCount = @@ROWCOUNT

					if (@rSqlError != 0 ) or (@RowCount != 1)
					begin
						select @rErrorText = 'CiSp_CreateAllocationDetails....:Error creating the allocation details for ref no  --> (' + isnull(@pALLC_DOC_NO,'Null') + ')'
						
						if @pDebug > 0
							print @rErrorText

						 return -236605
					end				
			end		


return 0
GO

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_CreateAllocationDetails]') 
			AND type in (N'P'))
	Print '<<< Success Procedure [dbo].[CiSp_CreateAllocationDetails] created !!! >>>'
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_CreateAllocationDetails] Not created >>>'
GO		  