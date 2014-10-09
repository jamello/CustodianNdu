declare		@pBrokerCode nvarchar(15)
	,	@pClaimNo	 nvarchar(25)
	,	@pTransNo	 nvarchar(15)
	
select		@pBrokerCode = 1
	,	@pClaimNo = '45/3456/678'
	,	@pTransNo = 123

SELECT * FROM CiFn_GrpClaimsDNoteDetail(@pBrokerCode,@pClaimNo,@pTransNo,NULL,NULL,NULL)

