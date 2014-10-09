set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON  
GO

IF OBJECT_ID (N'[dbo].CiFn_GetCredMasterDetail', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GetCredMasterDetail;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetCredMasterDetail]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GetCredMasterDetail] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GetCredMasterDetail] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GetCredMasterDetail] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GetCredMasterDetail
(
		@pCreditorCode nvarchar(15)
	,	@pInvoiceNo	 nvarchar(25)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rInvoiceInfo Table 
(
		sTransDate			nvarchar(10) NULL
	 ,	sTransAmountLC		decimal NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 2nd June 2014
	    Description : Used to return the invoice details of some specified parameters. 
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

	INSERT INTO @rInvoiceInfo   
	SELECT
		CONVERT(nvarchar(10), [TBFN_CRD_TRANS_DATE],101)
		,[TBFN_CRD_TRANS_AMT]
	FROM TBFN_CRED_MASTER p 
	WHERE p.[TBFN_CRD_ACCT_NO] = @pCreditorCode 
			AND p.[TBFN_CRD_TRANS_NO] = @pInvoiceNo
			
 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetCredMasterDetail]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GetCredMasterDetail] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GetCredMasterDetail] Not created >>>'
GO