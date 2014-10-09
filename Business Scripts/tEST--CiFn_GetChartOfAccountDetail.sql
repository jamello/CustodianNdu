declare	@pAccountCode nvarchar(25)
	,	@pCodeType   nvarchar(5)
	
select		@pAccountCode = '3010010015'
	,	@pCodeType = 'Main'
	
SELECT * FROM CiFn_GetChartOfAccountDetail(@pAccountCode,@pCodeType,NULL,NULL,NULL)

