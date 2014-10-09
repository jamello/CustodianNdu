Declare		@pPolicyNo	nvarchar(25),
		@pMOP	nvarchar(1),
	    @pPolicyEffDate	datetime,
		@pCONTRIB numeric(8),
		@pAmountPaid numeric(8)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	


SELECT @pMOP ='M',
	   @pCONTRIB = 1000,
	   @pPolicyEffDate = '2010-01-31',
	   @pAmountPaid = 4000,
	   @pPolicyNo = '4567/789/90', 
	   @pParam1 = null, 	   
	   @pParam2 = null, 	   
	   @pParam3 = null 

SELECT * FROM CiFn_ReceiptCoverPeriods(@pPolicyNo,@pMOP,(SELECT REPLACE(CONVERT(VARCHAR(10), @pPolicyEffDate, 102), '/', '-')),@pCONTRIB,@pAmountPaid,NULL,NULL,NULL)