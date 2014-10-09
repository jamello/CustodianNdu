declare		@pCreditorCode nvarchar(15)
	,	@pInvoiceNo	 nvarchar(25)
	
select		@pCreditorCode = 1
	,	@pInvoiceNo = '123'


SELECT * FROM CiFn_GetCredMasterDetail(@pCreditorCode,@pInvoiceNo,NULL,NULL,NULL)

