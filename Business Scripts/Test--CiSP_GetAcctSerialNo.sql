	declare @PARAM_SYS_ID		char(5)
	,@PARAM_SYS_TYPE	char(5) = '001'
	,@PARAM_SYS_BRANCH	char(5) = 'XXXX'
	,@PARAM_SYS_YEAR	char(10) = 'XXXX'
	,@PARAM_SYS_PREFIX	char(10) = ''
	,@PARAM_OUT_INT		char(20) 
	,@PARAM_OUT_CHAR	char(20)
	,@OUT_CHAR char(20)
	
	--select 
	-- @PARAM_SYS_ID	='L01'
	--,@PARAM_SYS_TYPE	= '001'
	--,@PARAM_SYS_BRANCH	= '2'
	--,@PARAM_SYS_YEAR	= '2015'
	--,@PARAM_SYS_PREFIX	= 'IL-BR-'

	select 
	 @PARAM_SYS_ID	='RCN'
	,@PARAM_SYS_TYPE	= '002'
	,@PARAM_SYS_BRANCH	= '03'
	,@PARAM_SYS_YEAR	= '2015'
	,@PARAM_SYS_PREFIX	= 'IL-BR-'
--	,@PARAM_OUT_INT = ' '
--	,@PARAM_OUT_CHAR = '11'
--"RCN", "002", docMonth, docYear, "IL-BR-", "12", "11"
EXEC CiSP_GetAcctSerialNo 
	@PARAM_SYS_ID
   ,@PARAM_SYS_TYPE
   ,@PARAM_SYS_BRANCH
   ,@PARAM_SYS_YEAR
   ,@PARAM_SYS_PREFIX
   ,@PARAM_OUT_INT
   ,@PARAM_OUT_CHAR = @OUT_CHAR output ;
   
print @OUT_CHAR;
