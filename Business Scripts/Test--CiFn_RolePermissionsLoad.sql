Declare		@pRoleName	nvarchar(50)
	,	@pParam1     nvarchar(100)
	,	@pParam2     nvarchar(100)
	,	@pParam3     nvarchar(100)	

select
		@pRoleName	 = 'administrator'
	,	@pParam1     = null
	,	@pParam2     = Null
	,	@pParam3     = null	




SELECT * FROM CiFn_RolePermissionsLoad(@pRoleName,NULL,NULL,NULL)