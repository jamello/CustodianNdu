set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON   --[TBIL_GRP_POLICY_DNOTE_DETAILS]
GO

IF OBJECT_ID (N'[dbo].CiFn_BrokerDetail', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_BrokerDetail;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_BrokerDetail]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_BrokerDetail] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_BrokerDetail] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_BrokerDetail] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_BrokerDetail
(
		@pBrokerCode nvarchar(15)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rBrokerInfo Table 
(
		sCustomerName			nvarchar(100) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James C. Nnannah
	    Create date : 26th May 2014
	    Description : Used to return the Customer (broker) details . 
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

	INSERT INTO @rBrokerInfo   
	SELECT
		
		[TBIL_CUST_DESC]
	FROM [TBIL_CUST_DETAIL] p 
	WHERE [TBIL_CUST_CODE] = @pBrokerCode
			
 
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_BrokerDetail]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_BrokerDetail] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_BrokerDetail] Not created >>>'
GO