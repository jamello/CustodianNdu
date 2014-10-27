DECLARE		@pSearchType  nvarchar(20)
		,@pSearchValue  nvarchar(50)

--SELECT		@pSearchType  = 'Policy'
--		,@pSearchValue  = 'PI/2014/1201/E/E001/I/0000002'

SELECT		@pSearchType  = 'Proposal'
		,@pSearchValue  = 'P/2/CE/00097'

SELECT * FROM CiFn_GetPolicyList(@pSearchType,@pSearchValue)

--select * from TBIL_POLICY_DET