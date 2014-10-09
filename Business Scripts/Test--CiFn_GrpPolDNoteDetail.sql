declare		@pBrokerCode nvarchar(15)
	,	@pPolicyNo	 nvarchar(25)
	,	@pTransNo	 nvarchar(15)
	
select		@pBrokerCode = 1
	,	@pPolicyNo = '4567/789/90'
	,	@pTransNo = 123

SELECT * FROM CiFn_GrpPolDNoteDetail(@pBrokerCode,@pPolicyNo,@pTransNo,NULL,NULL,NULL)

