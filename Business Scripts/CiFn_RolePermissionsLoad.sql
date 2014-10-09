set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'[dbo].CiFn_RolePermissionsLoad', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_RolePermissionsLoad;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_RolePermissionsLoad]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_RolePermissionsLoad] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_RolePermissionsLoad] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_RolePermissionsLoad] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[CiFn_RolePermissionsLoad]
(
		@pRoleName		 nvarchar(50)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rRoleDetails Table 
(
	[USER_ROLE] [nvarchar](50) NULL,
	[MENU] [nvarchar](10) NULL,
	[HOME] [nvarchar](10) NULL,
	[CODESMASTERSSETUP] [nvarchar](10) NULL,
	[CODESMASTERSSETUPU1] [nvarchar](10) NULL,
	[GENERALLEDGER] [nvarchar](10) NULL,
	[GENERALLEDGERU1] [nvarchar](10) NULL,
	[GLCODESSETUP] [nvarchar](10) NULL,
	[GLCODESSETUPU1] [nvarchar](10) NULL,
	[GLCODESPRINT] [nvarchar](10) NULL,
	[GLCODESPRINTU1] [nvarchar](10) NULL,
	[GLTRANS] [nvarchar](10) NULL,
	[GLTRANSU1] [nvarchar](10) NULL,
	[GLJOURNAL] [nvarchar](10) NULL,
	[GLJOURNALU1] [nvarchar](10) NULL,
	[GLMASTERUPDATE] [nvarchar](10) NULL,
	[GLMASTERUPDATEU1] [nvarchar](10) NULL,
	[GLREPORTS] [nvarchar](10) NULL,
	[GLREPORTSU1] [nvarchar](10) NULL,
	[FINREPORTGROUP] [nvarchar](10) NULL,
	[FINREPORTGROUPU1] [nvarchar](10) NULL,
	[GLMONTHEND] [nvarchar](10) NULL,
	[GLMONTHENDU1] [nvarchar](10) NULL,
	[GLYEAREND] [nvarchar](10) NULL,
	[GLYEARENDU1] [nvarchar](10) NULL,
	[RECEIVABLE] [nvarchar](10) NULL,
	[RECEIVABLEU1] [nvarchar](10) NULL,
	[RECCODESSETUP] [nvarchar](10) NULL,
	[RECCODESSETUPU1] [nvarchar](10) NULL,
	[RECDEBENTRY] [nvarchar](10) NULL,
	[RECDEBENTRYU1] [nvarchar](10) NULL,
	[RECDEBTRANSREPORT] [nvarchar](10) NULL,
	[RECDEBTRANSREPORTU1] [nvarchar](10) NULL,
	[RECMASTERUPDATE] [nvarchar](10) NULL,
	[RECMASTERUPDATEU1] [nvarchar](10) NULL,
	[RECDEBTORREPORTS] [nvarchar](10) NULL,
	[RECDEBTORREPORTSU1] [nvarchar](10) NULL,
	[PAYABLES] [nvarchar](10) NULL,
	[PAYABLESU1] [nvarchar](10) NULL,
	[PAYCODESSETUP] [nvarchar](10) NULL,
	[PAYCODESSETUPU1] [nvarchar](10) NULL,
	[PAYCREDTRANSENTRY] [nvarchar](10) NULL,
	[PAYCREDTRANSENTRYU1] [nvarchar](10) NULL,
	[PAYCREDTRANSREP] [nvarchar](10) NULL,
	[PAYCREDTRANSREPU1] [nvarchar](10) NULL,
	[PAYCREDITORSREPORTS] [nvarchar](10) NULL,
	[PAYCREDITORSREPORTSU1] [nvarchar](10) NULL,
	[FIXEDASSETS] [nvarchar](10) NULL,
	[FIXEDASSETSU1] [nvarchar](10) NULL,
	[FACODESSETUP] [nvarchar](10) NULL,
	[FACODESSETUPU1] [nvarchar](10) NULL,
	[FAREPORTS] [nvarchar](10) NULL,
	[FAREPORTSU1] [nvarchar](10) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 5th May 2014
	    Description : Used to return the details of permissions settings for a particular role name. 
					  
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

	INSERT INTO @rRoleDetails   
	SELECT
	   r.[USER_ROLE]
      ,r.[MENU]
      ,r.[HOME]
      ,r.[CODESMASTERSSETUP]
      ,r.[CODESMASTERSSETUPU1]
      ,r.[GENERALLEDGER]
      ,r.[GENERALLEDGERU1]
      ,r.[GLCODESSETUP]
      ,r.[GLCODESSETUPU1]
      ,r.[GLCODESPRINT]
      ,r.[GLCODESPRINTU1]
      ,r.[GLTRANS]
      ,r.[GLTRANSU1]
      ,r.[GLJOURNAL]
      ,r.[GLJOURNALU1]
      ,r.[GLMASTERUPDATE]
      ,r.[GLMASTERUPDATEU1]
      ,r.[GLREPORTS]
      ,r.[GLREPORTSU1]
      ,r.[FINREPORTGROUP]
      ,r.[FINREPORTGROUPU1]
      ,r.[GLMONTHEND]
      ,r.[GLMONTHENDU1]
      ,r.[GLYEAREND]
      ,r.[GLYEARENDU1]
      ,r.[RECEIVABLE]
      ,r.[RECEIVABLEU1]
      ,r.[RECCODESSETUP]
      ,r.[RECCODESSETUPU1]
      ,r.[RECDEBENTRY]
      ,r.[RECDEBENTRYU1]
      ,r.[RECDEBTRANSREPORT]
      ,r.[RECDEBTRANSREPORTU1]
      ,r.[RECMASTERUPDATE]
      ,r.[RECMASTERUPDATEU1]
      ,r.[RECDEBTORREPORTS]
      ,r.[RECDEBTORREPORTSU1]
      ,r.[PAYABLES]
      ,r.[PAYABLESU1]
      ,r.[PAYCODESSETUP]
      ,r.[PAYCODESSETUPU1]
      ,r.[PAYCREDTRANSENTRY]
      ,r.[PAYCREDTRANSENTRYU1]
      ,r.[PAYCREDTRANSREP]
      ,r.[PAYCREDTRANSREPU1]
      ,r.[PAYCREDITORSREPORTS]
      ,r.[PAYCREDITORSREPORTSU1]
      ,r.[FIXEDASSETS]
      ,r.[FIXEDASSETSU1]
      ,r.[FACODESSETUP]
      ,r.[FACODESSETUPU1]
      ,r.[FAREPORTS]
      ,r.[FAREPORTSU1]
	FROM [TBIL_ROLE_PERMISSIONS] r 	  
	WHERE r.[USER_ROLE] = @pRoleName;
  
 
     RETURN
END
go

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_RolePermissionsLoad]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_RolePermissionsLoad] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_RolePermissionsLoad] Not created >>>'
GO	
