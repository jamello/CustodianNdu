DECLARE		@pSearchType  nvarchar(20)
		,@pSearchValue  nvarchar(50)

SELECT		@pSearchType  = 'proposal'
		,@pSearchValue  = 'P/2/IP/000068'
	
SELECT * FROM CiFn_GetPolicyList(@pSearchType,@pSearchValue)

