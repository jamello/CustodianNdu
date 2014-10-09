Declare		@pReceiptNo	nvarchar(25)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	

select
		@pReceiptNo	 = 'IL-BR0001'
	,	@pParam1     = null
	,	@pParam2     = Null
	,	@pParam3     = null	



--select * from CiFn_ReceiptDetails(@pReceiptNo,null,null,null)
SELECT * FROM CiFn_ReceiptDetails(@pReceiptNo,NULL,NULL,NULL)