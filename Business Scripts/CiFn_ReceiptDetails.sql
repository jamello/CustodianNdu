set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'[dbo].CiFn_ReceiptDetails', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_ReceiptDetails;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptDetails]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_ReceiptDetails] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_ReceiptDetails] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_ReceiptDetails] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_ReceiptDetails
(
		@pReceiptNo	nvarchar(25)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rReceiptInfo Table 
(
		sReceiptNo			nvarchar(15) NULL
	 ,	sInsuredName		nvarchar(150) NULL
	 ,	sInsuredAddress		nvarchar(250) NULL
	 ,  sReceiptAmount		decimal NULL
	 ,  sInsurancePeriod    nvarchar(100) NULL
	 ,  sBrokerAgentName    nvarchar(100) NULL
	 ,  sReceiptDate        datetime NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 4th March 2014
	    Description : Used to return the receipt details of a particular receipt number. 
					  This is primarily used by the receipt print routine.  
	    Version     : 1
    ******************************************/
		
		set @pParam1 = REPLACE(@pParam1,N'''',N'--');
		set @pParam1 = REPLACE(@pParam1,N'--',N'--');		
		set @pParam1 = REPLACE(@pParam1,N';',N'--');				
		set @pParam1 = REPLACE(@pParam1,N'/* ... */',N'--');	
		set @pParam1 = REPLACE(@pParam1,N'xp_',N'--');

		set @pParam2 = REPLACE(@pParam2,N'''',N'--');
		set @pParam2 = REPLACE(@pParam2,N'--',N'--');		
		set @pParam2 = REPLACE(@pParam2,N';',N'--');				
		set @pParam2 = REPLACE(@pParam2,N'/* ... */',N'--');	
		set @pParam2 = REPLACE(@pParam2,N'xp_',N'--');

		set @pParam3 = REPLACE(@pParam3,N'''',N'--');
		set @pParam3 = REPLACE(@pParam3,N'--',N'--');		
		set @pParam3 = REPLACE(@pParam3,N';',N'--');				
		set @pParam3 = REPLACE(@pParam3,N'/* ... */',N'--');	
		set @pParam3 = REPLACE(@pParam3,N'xp_',N'--');

	INSERT INTO @rReceiptInfo   
	SELECT
		   [TBFN_ACCT_DOC_NO]
		  ,[TBIL_INSRD_SURNAME] + ' ' + [TBIL_INSRD_FIRSTNAME] + ' ' + [TBIL_INSRD_LONG_NAME] as Insured_Name
		  ,b.TBIL_INSRD_ADRES1 + ' ' + b.TBIL_INSRD_ADRES2 as Insured_Address
		  ,[TBFN_ACCT_AMT_LC]
		  ,[TBFN_ACCT_TRANS_DESC2]
		  ,c.[TBIL_AGCY_AGENT_NAME]  
		  ,[TBFN_ACCT_ENTRY_DATE]
	FROM [TBFN_RECPT_FILE] p 
	  INNER JOIN [TBIL_INS_DETAIL] b ON p.TBFN_ACCT_INS_CODE = b.TBIL_INSRD_CODE
	  INNER JOIN [TBIL_AGENCY_CD] c ON p.[TBFN_ACCT_AGENT_CODE] = c.[TBIL_AGCY_AGENT_CD] 
	WHERE p.[TBFN_ACCT_DOC_NO] = @pReceiptNo ;
  
 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptDetails]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_ReceiptDetails] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_ReceiptDetails] Not created >>>'
GO