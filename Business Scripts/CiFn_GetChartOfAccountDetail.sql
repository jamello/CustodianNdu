set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON  
GO

IF OBJECT_ID (N'[dbo].CiFn_GetChartOfAccountDetail', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GetChartOfAccountDetail;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetChartOfAccountDetail]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GetChartOfAccountDetail] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GetChartOfAccountDetail] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GetChartOfAccountDetail] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GetChartOfAccountDetail
(
		@pAccountCode nvarchar(25)
	,	@pCodeType   nvarchar(5)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rChartInfo Table 
(
	 	sMainCode			nvarchar(50) NULL
	 ,	sMainDesc			nvarchar(200) NULL
	 ,	sSubCode			nvarchar(50) NULL
	 ,	sSubDesc			nvarchar(200) NULL
	 ,	sLedgType			nvarchar(5) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 12nd June 2014
	    Description : Used to return the chart of accounts details. 
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

	IF (@pCodeType = 'Main' )
		BEGIN	
			INSERT INTO @rChartInfo
			SELECT
			   [TBFN_ACCT_MAIN_CD]
			  , [TBFN_ACCT_MAIN_DESC]
			  ,[TBFN_ACCT_SUB_CD]
			  ,[TBFN_ACCT_SUB_DESC]	
			  ,TBFN_ACCT_LEDG_TYPE
			FROM  TBFN_ACCT_CODES P 
			WHERE p.[TBFN_ACCT_MAIN_CD] = @pAccountCode
		END			
	ELSE IF (@pCodeType = 'Sub' )
		BEGIN	
			INSERT INTO @rChartInfo
			SELECT
			   [TBFN_ACCT_MAIN_CD]
			  , [TBFN_ACCT_MAIN_DESC]
			  ,[TBFN_ACCT_SUB_CD]
			  ,[TBFN_ACCT_SUB_DESC]	
			  ,TBFN_ACCT_LEDG_TYPE
			FROM  TBFN_ACCT_CODES P 
			WHERE p.[TBFN_ACCT_SUB_CD] = @pAccountCode
		END			
	 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetChartOfAccountDetail]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GetChartOfAccountDetail] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GetChartOfAccountDetail] Not created >>>'
GO