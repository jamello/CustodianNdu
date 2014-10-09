Declare		@pStartDate	datetime
	,	@pEndDate	datetime
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	

select
		@pStartDate	 = '2014/01/01'
	,	@pEndDate	 = '2015/01/01'
	,	@pParam1     = null
	,	@pParam2     = Null
	,	@pParam3     = null	


SELECT * FROM CiFn_ReceiptsByDate(@pStartDate,@pEndDate,NULL,NULL,NULL)