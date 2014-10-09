Declare		@pDocNo	nvarchar(25)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	

select
		@pDocNo		 = 'JV-NO-0005'
	,	@pParam1     = null
	,	@pParam2     = Null
	,	@pParam3     = null	



--select * from CiFn_ReceiptDetails(@pReceiptNo,null,null,null)
--SELECT * FROM CiFn_JournalDetails(@pDocNo,NULL,NULL,NULL)
EXEC CiSp_JournalDetails @pDocNo,NULL,NULL,NULL 