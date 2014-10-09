set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'[dbo].CiFn_ReceiptsByDate', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_ReceiptsByDate;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptsByDate]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_ReceiptsByDate] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_ReceiptsByDate] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_ReceiptsByDate] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_ReceiptsByDate
(
		@pStartDate		datetime
	,	@pEndDate		datetime
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rReceiptInfo Table 
(
		sReceiptDate		datetime NULL
	,	sReceiptNo			nvarchar(15) NULL
	,	sReceiptType		nvarchar(15) NULL
	 ,	sTellerNo			nvarchar(15) NULL
	 ,	sBank				nvarchar(250) NULL
	 ,	sPolicyNo			nvarchar(25) NULL
	 ,	sDescription		nvarchar(250) NULL
	 ,  sReceiptAmount		decimal NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 4th April 2014
	    Description : Used to return the list of receipts fora particular date range. 
					  This is primarily used by a receipt print routine.  
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
		   cast([TBFN_ACCT_ENTRY_DATE] as DATE)
		  , [TBFN_ACCT_DOC_NO]
		  ,[TBFN_ACCT_RECP_TYP]
		  ,[TBFN_ACCT_CHQ_TELLER_NO]
		  ,[TBFN_ACCT_BANK_CD]
		  ,[TBFN_ACCT_REF_NO]
		  ,[TBFN_ACCT_TRANS_DESC1] + ' ' + [TBFN_ACCT_TRANS_DESC2]  
		  ,[TBFN_ACCT_AMT_LC]
	FROM [TBFN_RECPT_FILE] p 	  
	WHERE cast([TBFN_ACCT_ENTRY_DATE] as DATE) between @pStartDate and @pEndDate;
  
 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptsByDate]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_ReceiptsByDate] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_ReceiptsByDate] Not created >>>'
GO