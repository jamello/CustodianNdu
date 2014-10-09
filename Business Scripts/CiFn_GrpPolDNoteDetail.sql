set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON   --[TBIL_GRP_POLICY_DNOTE_DETAILS]
GO

IF OBJECT_ID (N'[dbo].CiFn_GrpPolDNoteDetail', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GrpPolDNoteDetail;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GrpPolDNoteDetail]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GrpPolDNoteDetail] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GrpPolDNoteDetail] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GrpPolDNoteDetail] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GrpPolDNoteDetail
(
		@pBrokerCode nvarchar(15)
	,	@pPolicyNo	 nvarchar(25)
	,	@pTransNo	 nvarchar(15)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rGrpNoteInfo Table 
(
		sTransDate			nvarchar(10) NULL
	 ,	sTransAmountLC		decimal NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 20th May 2014
	    Description : Used to return the group debit note details of some specified parameters. 
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

	INSERT INTO @rGrpNoteInfo   
	SELECT
		CONVERT(nvarchar(10), TBIL_POL_PRM_DCN_TRNS_DATE,101)
		,TBIL_POL_PRM_DCN_AMT_LC
	FROM [TBIL_GRP_POLICY_DNOTE_DETAILS] p 
	WHERE p.[TBIL_POL_PRM_DCN_POLY_NO] = @pPolicyNo 
			AND [TBIL_POL_PRM_DCN_BRK_CODE] = @pBrokerCode
			AND TBIL_POL_PRM_DCN_TRANS_NO = @pTransNo 
 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GrpPolDNoteDetail]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GrpPolDNoteDetail] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GrpPolDNoteDetail] Not created >>>'
GO