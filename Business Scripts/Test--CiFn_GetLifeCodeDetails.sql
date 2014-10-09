Declare				@pCode nvarchar(5)
	,	@pTabId     nvarchar(5)
	,	@pCodeType     nvarchar(5)
	,	@pParam1     nvarchar(100)	


select
		@pCode = '002'
	,	@pTabId    = 'L02'
	,	@pCodeType = '003'
	,	@pParam1   =null



SELECT * FROM CiFn_GetLifeCodeDetails(@pCode,@pTabId,@pCodeType,@pParam1)

--select * from TBIL_LIFE_CODES