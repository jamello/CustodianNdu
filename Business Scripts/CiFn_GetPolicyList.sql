
set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON  
GO

IF OBJECT_ID (N'[dbo].CiFn_GetPolicyList', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GetPolicyList;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetPolicyList]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GetPolicyList] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GetPolicyList] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GetPolicyList] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GetPolicyList
(
		@pSearchType  nvarchar(20)
		,@pSearchValue  nvarchar(50)
)
RETURNS @rPolyInfo Table 
(
		sPolicyNumber			nvarchar(50) NULL
	 ,	sInsuredName			nvarchar(100) NULL
	 ,	sProposalNumber			nvarchar(100) NULL
	 ,	sProductCode			nvarchar(25) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 15th August 2014
	    Description : Used to return the policy List. 
	    Version     : 1
    ******************************************/


		IF @pSearchType = 'Policy'
		BEGIN	
			INSERT INTO @rPolyInfo
			   SELECT 
			   [TBIL_POLY_POLICY_NO]
			   ,(SELECT [TBIL_INSRD_SURNAME] +' ' +[TBIL_INSRD_FIRSTNAME]
				FROM [TBIL_INS_DETAIL] b WHERE b.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Name
			   ,[TBIL_POLY_PROPSAL_NO]
			   ,TBIL_POLY_PRDCT_CD
		   FROM [TBIL_POLICY_DET] p
		   WHERE p.[TBIL_POLY_POLICY_NO] = @pSearchValue
		END			
		IF @pSearchType = 'Proposal'
		BEGIN	
			INSERT INTO @rPolyInfo
			   SELECT 
			   [TBIL_POLY_POLICY_NO]
			   ,(SELECT [TBIL_INSRD_SURNAME] +' ' +[TBIL_INSRD_FIRSTNAME]
				FROM [TBIL_INS_DETAIL] b WHERE b.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Name
			   ,[TBIL_POLY_PROPSAL_NO]
			   ,TBIL_POLY_PRDCT_CD
		   FROM [TBIL_POLICY_DET] p
		   WHERE p.[TBIL_POLY_PROPSAL_NO] = @pSearchValue
		END			
		
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetPolicyList]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GetPolicyList] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GetPolicyList] Not created >>>'
GO