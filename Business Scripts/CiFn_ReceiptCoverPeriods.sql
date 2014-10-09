set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID (N'[dbo].CiFn_ReceiptCoverPeriods', N'TF') IS NOT NULL
begin
   DROP FUNCTION [dbo].CiFn_ReceiptCoverPeriods;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptCoverPeriods]') 
				AND type in (N'TF')
			  )
		Print '<<< Failed Dropping  FUNCTION [CiFn_ReceiptCoverPeriods] created !!! >>>'
	else
		Print '<<< FUNCTION [dbo].[CiFn_ReceiptCoverPeriods] Dropped >>>'
end   
else
	Print '<<< !!! Error FUNCTION [dbo].[CiFn_ReceiptCoverPeriods] does Not exist >>>' ;   
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function dbo.CiFn_ReceiptCoverPeriods
(
		@pPolicyNo	nvarchar(25),
		@pMOP	nvarchar(1),
	    @pPolicyEffDate	date,
		@pCONTRIB numeric(8),
		@pAmountPaid numeric(8)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	
)
RETURNS @rPeriodsCovered Table 
(
		sPeriodsCoverRange		nvarchar(50) NULL
)
--with encryption
AS
BEGIN
    /***************************************
	    Author      : James Nnannah
	    Create date : Feb  2014
	    Description : Used to return the periods covered by a payment by customer 
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


Declare @TotalPremPaid	numeric(8),
		@MOP	nvarchar(1),
	    @PolicyEffDate	datetime,
	    @LastDateCovered	datetime,
	    @CurrentDateCovered	datetime,
		@CONTRIB numeric(8),
		@AmountPaid numeric(8),
		@LastPeriodsCovered bigint,
		@CurrentPeriodsCovered bigint,
	    @tmpLastDateCovered	nvarchar(15),
	    @tmpCurrentDateCovered	nvarchar(15)

	   
--sum total amount paid to date for the policy
SELECT @TotalPremPaid = sum([TBFN_TRANS_TOT_AMT])
  FROM [dbo].[TBFN_ALLOC_DETAIL] a
  WHERE a.TBFN_TRANS_POLY_NO = @pPolicyNo AND a.TBFN_TRANS_TYPE = 'N';
  
 
 IF @pMOP = 'M'
	 BEGIN 
		SELECT @LastPeriodsCovered = @TotalPremPaid/@pCONTRIB,
			   @LastDateCovered = DATEADD(month, @LastPeriodsCovered, @pPolicyEffDate )
		SELECT @CurrentPeriodsCovered =  @pAmountPaid/@pCONTRIB,
			   @CurrentDateCovered =  DATEADD(month, @CurrentPeriodsCovered, @LastDateCovered)		 
	 END
	 
 IF @pMOP = 'Q'
	BEGIN 
		SELECT @LastPeriodsCovered = @TotalPremPaid/@pCONTRIB,
	   		   @LastDateCovered = DATEADD(QUARTER, @LastPeriodsCovered, @pPolicyEffDate )
		SELECT @CurrentPeriodsCovered =  @pAmountPaid/@pCONTRIB,
			   @CurrentDateCovered =  DATEADD(QUARTER, @CurrentPeriodsCovered, @LastDateCovered)
	END
	
 IF @pMOP = 'H'
	BEGIN 
		SELECT @LastPeriodsCovered = @TotalPremPaid/@pCONTRIB,
	   		   @LastDateCovered = DATEADD(YEAR, @LastPeriodsCovered/2, @pPolicyEffDate )
		SELECT @CurrentPeriodsCovered =  @pAmountPaid/@pCONTRIB,
			   @CurrentDateCovered =  DATEADD(YEAR, @CurrentPeriodsCovered/2, @LastDateCovered)
	END
		
	
	
	
IF @pMOP = 'A'
	BEGIN 
	    SELECT @LastPeriodsCovered = @TotalPremPaid/@pCONTRIB,
		       @LastDateCovered = DATEADD(YEAR, @LastPeriodsCovered, @pPolicyEffDate) 
		SELECT @CurrentPeriodsCovered =  @pAmountPaid/@pCONTRIB,
			   @CurrentDateCovered =  DATEADD(YEAR, @CurrentPeriodsCovered, @LastDateCovered)
     END
     SELECT @tmpLastDateCovered = convert(varchar, @LastDateCovered, 104)  
     SELECT @tmpCurrentDateCovered = convert(varchar, @CurrentDateCovered, 104)  
	 INSERT INTO @rPeriodsCovered values (@tmpLastDateCovered + ' To ' + @tmpCurrentDateCovered)
  
     RETURN
END	
GO
IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiFn_ReceiptCoverPeriods]') 
			AND type in (N'TF'))
	Print '<<< Success creating function  [dbo].[CiFn_ReceiptCoverPeriods] created !!! >>>'
else
	Print '<<< !!! Error creating function [dbo].[CiFn_ReceiptCoverPeriods] Not created >>>'
GO