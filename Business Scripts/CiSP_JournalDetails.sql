set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'[dbo].CiSp_JournalDetails', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_JournalDetails;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_JournalDetails]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  PROCEDURE [CiSp_JournalDetails] created !!! >>>'
	else
		Print '<<< PROCEDURE [dbo].[CiSp_JournalDetails] Dropped >>>'
end   
else
	Print '<<< !!! Error PROCEDURE [dbo].[CiSp_JournalDetails] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.CiSp_JournalDetails
(
		@pDocNo	nvarchar(25)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 26th June 2014
	    Description : Used to return the Journal details of a particular document number. 
					  This is primarily used by the Journal print routine.  
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

	SELECT
		   [TBFN_GL_DOC_NO]
		  ,[TBFN_GL_DOC_DATE]
		  , (SELECT TOP 1 b.[TBFN_ACCT_MAIN_DESC] FROM [TBFN_ACCT_CODES] b WHERE a.[TBFN_GL_MAIN_ACCT] = b.[TBFN_ACCT_MAIN_CD] )
		  ,[TBFN_GL_MAIN_ACCT]
		  ,[TBFN_GL_SUB_ACCT]
		  ,[TBFN_GL_REF_NO1]
		  ,[TBFN_GL_CURRCY_TYPE]
		  ,[TBFN_GL_DR_CR_CD]
		  ,[TBFN_GL_AMT_LC]
		  ,[TBFN_GL_TRANS_DESC]
		  ,[TBFN_GL_OPER_ID]
		  ,[TBFN_GL_ENTRY_DATE]
	FROM [TBFN_TRANS_FILE] a 
	WHERE a.[TBFN_GL_DOC_NO] = @pDocNo --AND [TBFN_GL_TRANS_ID] = 'D'
   
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_JournalDetails]') 
			AND type in (N'P'))
	Print '<<< Success creating PROCEDURE  [dbo].[CiSp_JournalDetails] created !!! >>>'
else
	Print '<<< !!! Error creating PROCEDURE [dbo].[CiSp_JournalDetails] Not created >>>'
GO