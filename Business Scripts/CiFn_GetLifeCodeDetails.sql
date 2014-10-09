set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON  
GO

IF OBJECT_ID (N'[dbo].CiFn_GetLifeCodeDetails', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_GetLifeCodeDetails;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetLifeCodeDetails]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_GetLifeCodeDetails] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_GetLifeCodeDetails] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_GetLifeCodeDetails] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_GetLifeCodeDetails
(
		@pCode nvarchar(5)
	,	@pTabId     nvarchar(5)
	,	@pCodeType     nvarchar(5)
	,	@pParam1     nvarchar(100)	
)
RETURNS @rLifeCodeInfo Table 
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
	    Create date : 23nd July 2014
	    Description : Used to return the life code details e.g LifeCode. 
	    Version     : 1
    ******************************************/
		
		set @pParam1 = REPLACE(@pParam1,N'''',N'--');
		set @pParam1 = REPLACE(@pParam1,N'--',N'--');		
		set @pParam1 = REPLACE(@pParam1,N';',N'--');				
		set @pParam1 = REPLACE(@pParam1,N'/* ... */',N'--');	
		set @pParam1 = REPLACE(@pParam1,N'xp_',N'--');

		BEGIN	
			INSERT INTO @rLifeCodeInfo
			SELECT 
			   TBIL_COD_ITEM
			  ,TBIL_COD_LONG_DESC
			  ,TBIL_COD_SHORT_DESC
			FROM TBIL_LIFE_CODES p
			WHERE p.TBIL_COD_TAB_ID = @pTabId  AND p.TBIL_COD_TYP = @pCodeType AND TBIL_COD_ITEM = @pCode
		END			
	 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_GetLifeCodeDetails]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_GetLifeCodeDetails] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_GetLifeCodeDetails] Not created >>>'
GO