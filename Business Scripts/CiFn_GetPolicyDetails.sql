
set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON  
GO

IF OBJECT_ID (N'[dbo].CiFn_GetPolicyDetails', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GetPolicyDetails;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetPolicyDetails]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GetPolicyDetails] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GetPolicyDetails] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GetPolicyDetails] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GetPolicyDetails
(
		@pSearchType  nvarchar(1)
)
RETURNS @rPolyInfo Table 
(
		sCode			nvarchar(5) NULL
	 ,	sDescr			nvarchar(100) NULL
	 ,	sShortDescr			nvarchar(100) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 15th August 2014
	    Description : Used to return the policy details. 
	    Version     : 1
    ******************************************/
            --if (searchType == P)
            --    fld = [TBIL_POLY_POLICY_NO];
            --else if (searchType == D)
            --    fld = [TBIL_POLY_PROPSAL_NO];

	IF @pSearchType = 'P' 		
		BEGIN	
			INSERT INTO @rPolyInfo
			   SELECT 
				[TBIL_POLY_PROPSAL_NO]
			   ,[TBIL_POLY_POLICY_NO]
			   ,[TBIL_POLY_ASSRD_CD]
			   ,(SELECT [TBIL_INSRD_SURNAME] +' ' +[TBIL_INSRD_FIRSTNAME]
				FROM [TBIL_INS_DETAIL] b WHERE b.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Name
           							,	(SELECT 
				   [TBIL_INSRD_ADRES1] + ' ' + [TBIL_INSRD_ADRES2]   
				 FROM [TBIL_INS_DETAIL] y 
				 WHERE y.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Address 
			   ,[TBIL_POLY_AGCY_CODE]
			   ,(SELECT [TBIL_AGCY_AGENT_NAME] FROM [TBIL_AGENCY_CD] d WHERE d.[TBIL_AGCY_AGENT_CD]= p.[TBIL_POLY_AGCY_CODE]) as Agent_Name
			   , [TBIL_POL_PRM_DTL_MOP_PRM_LC]
			   ,[TBIL_POL_PRM_MODE_PAYT] as Payment_Mode 
			   ,(SELECT CASE [TBIL_POL_PRM_MODE_PAYT] WHEN 'M' THEN 'MONTHLY' WHEN 'A' THEN 'ANNUALLY' WHEN 'H' THEN 'HALF YEARLY' WHEN 'Q' THEN 'QUARTERLY' END) as Payment_Mode_Desc 
			   ,convert(varchar, [TBIL_POLICY_EFF_DT], 102) as TBIL_POLICY_EFF_DT
				FROM [TBIL_POLICY_DET_COMBINE] p INNER JOIN [TBIL_POLICY_PREM_DETAILS] q  
			   ON p.[TBIL_POLY_POLICY_NO] = q.[TBIL_POL_PRM_DTL_POLY_NO] 
			   INNER JOIN [TBIL_POLICY_PREM_INFO_COMBINE] r  
			   ON p.[TBIL_POLY_POLICY_NO] = r.TBIL_POL_PRM_POLY_NO 
			   WHERE p.[TBIL_POLY_POLICY_NO] =   
		END			
		ELSE
		Print 'done'
















	 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetPolicyDetails]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GetPolicyDetails] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GetPolicyDetails] Not created >>>'
GO