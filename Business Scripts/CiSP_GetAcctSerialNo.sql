set ansi_nulls off;
go
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSP_GetAcctSerialNo', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSP_GetAcctSerialNo;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSP_GetAcctSerialNo ]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  PROCEDURE [CiSP_GetAcctSerialNo ] !!! >>>'
	else
		Print '<<< PROCEDURE [dbo].[CiSP_GetAcctSerialNo ] Dropped >>>'
end   
else
	Print '<<< !!! Error PROCEDURE [dbo].[CiSP_GetAcctSerialNo ] does Not exist >>>' ;   
GO

-- SELECT * FROM TBIL_ACCT_SYS_GEN_NUMB
CREATE   PROCEDURE CiSP_GetAcctSerialNo
	(@PARAM_SYS_ID		char(5) = 'L02'
	,@PARAM_SYS_TYPE	char(5) = '001'
	,@PARAM_SYS_BRANCH	char(5) = 'XXXX'
	,@PARAM_SYS_YEAR	char(5) = 'XXXX'
	,@PARAM_SYS_PREFIX	char(10) = ''
	,@PARAM_OUT_INT		char(20) = '2'
	,@PARAM_OUT_CHAR	char(20) output
	)
AS

BEGIN
    /***************************************
	    Author      : Sunkanmi Oduwole
	    Modified    : James Nnannah
	    Create date : Feb 2014
	    Description : Supplies the next number serially to used in the life system account module
	    file        : CiSP_GetAcctSerialNo
	    Version     : 1.1
	    Modification Notes: 
	    The original came from that being used in the underwriting module. Just modified it to suit the account module 
	    Added the Flag field -- TBIL_SYS_ACCT_GEN_FLAG
	          the operator id field -- TBIL_SYS_ACCT_GEN_OPERID
	          the entry date field --	TBIL_SYS_ACCT_GEN_KEYDTE

    ******************************************/

declare @next_num	numeric(8)
declare @next_no	char(10)
declare @next_numX	char(10)
declare @field_len	numeric(5)
declare @DN_num		numeric(8)
declare @CN_num		numeric(8)
declare @foundYN	char(1)

declare @keydte		datetime
set @keydte = getdate()

declare @my_prefix	char(10)
set @my_prefix = ltrim(rtrim(@PARAM_SYS_PREFIX))

set @next_num = 0
--select * from TBIL_ACCT_SYS_GEN_NUMB
if exists(select top 1 TBIL_SYS_ACCT_GEN_ID from TBIL_ACCT_SYS_GEN_NUMB
     where TBIL_SYS_ACCT_GEN_ID = @PARAM_SYS_ID
       and TBIL_SYS_ACCT_GEN_TRN = @PARAM_SYS_TYPE
       and TBIL_SYS_ACCT_GEN_BRCH = @PARAM_SYS_BRANCH
       and TBIL_SYS_ACCT_GEN_YR = @PARAM_SYS_YEAR)
  begin
    select top 1 @next_num = TBIL_SYS_ACCT_GEN_NO from TBIL_ACCT_SYS_GEN_NUMB
     where TBIL_SYS_ACCT_GEN_ID = @PARAM_SYS_ID
       and TBIL_SYS_ACCT_GEN_TRN = @PARAM_SYS_TYPE
       and TBIL_SYS_ACCT_GEN_BRCH = @PARAM_SYS_BRANCH
       and TBIL_SYS_ACCT_GEN_YR = @PARAM_SYS_YEAR
  end
else
  begin
    set @next_num = 0
    insert into TBIL_ACCT_SYS_GEN_NUMB(TBIL_SYS_ACCT_GEN_ID
	,TBIL_SYS_ACCT_GEN_TRN
	,TBIL_SYS_ACCT_GEN_BRCH
	,TBIL_SYS_ACCT_GEN_YR
	,TBIL_SYS_ACCT_GEN_NO
	,TBIL_SYS_ACCT_GEN_FLAG
	,TBIL_SYS_ACCT_GEN_OPERID
	,TBIL_SYS_ACCT_GEN_KEYDTE)
    values(@PARAM_SYS_ID
	, @PARAM_SYS_TYPE
	, @PARAM_SYS_BRANCH
	, @PARAM_SYS_YEAR
	, @next_num
	, 'A', 'SYS', @keydte)
  end

set @next_num = isnull(@next_num,0)


START_RTN_LOOP:

set @next_num = isnull(@next_num,0)
set @next_num = @next_num + 1

if exists(select top 1 TBIL_SYS_ACCT_GEN_ID from TBIL_ACCT_SYS_GEN_NUMB
     where TBIL_SYS_ACCT_GEN_ID = @PARAM_SYS_ID
       and TBIL_SYS_ACCT_GEN_TRN = @PARAM_SYS_TYPE
       and TBIL_SYS_ACCT_GEN_BRCH = @PARAM_SYS_BRANCH
       and TBIL_SYS_ACCT_GEN_YR = @PARAM_SYS_YEAR)
  begin
  update TBIL_ACCT_SYS_GEN_NUMB
     set TBIL_SYS_ACCT_GEN_NO = @next_num
     where TBIL_SYS_ACCT_GEN_ID = @PARAM_SYS_ID
       and TBIL_SYS_ACCT_GEN_TRN = @PARAM_SYS_TYPE
       and TBIL_SYS_ACCT_GEN_BRCH = @PARAM_SYS_BRANCH
       and TBIL_SYS_ACCT_GEN_YR = @PARAM_SYS_YEAR
  end
else
  begin
    insert into TBIL_ACCT_SYS_GEN_NUMB(TBIL_SYS_ACCT_GEN_ID
	,TBIL_SYS_ACCT_GEN_TRN
	,TBIL_SYS_ACCT_GEN_BRCH
	,TBIL_SYS_ACCT_GEN_YR
	,TBIL_SYS_ACCT_GEN_NO
	,TBIL_SYS_ACCT_GEN_FLAG
	,TBIL_SYS_ACCT_GEN_OPERID
	,TBIL_SYS_ACCT_GEN_KEYDTE)
    values(@PARAM_SYS_ID
	, @PARAM_SYS_TYPE
	, @PARAM_SYS_BRANCH
	, @PARAM_SYS_YEAR
	, @next_num
	, 'A', 'SYS', @keydte)
  end

set @next_numX = ''
set @next_no = convert(char(4),@next_num)
set @field_len = 4 - len(@next_num) 
if @field_len <= 0
   begin
     set @next_numX = ''
   end
else
   begin
     set @next_numX = REPLICATE(0, @field_len) 
end

     set @next_numX = ltrim(rtrim(@my_prefix)) +  ltrim(rtrim(@next_numX)) + ltrim(rtrim(@next_no)) 

set @foundYN = 0
--if @param_rec_id in('001')
--begin
  if exists(select top 1 TBIL_COD_ITEM from dbo.TBIL_LIFE_CODES
     where TBIL_COD_TAB_ID = @PARAM_SYS_ID
     and TBIL_COD_TYP = @PARAM_SYS_TYPE
     and TBIL_COD_ITEM = @next_numX)
  begin
    set @foundYN = 1
    goto START_RTN_LOOP
  end
--end


END_RTN_LOOP:
   set @param_out_int = convert(char(20), @next_num)
   set @param_out_char = convert(char(20), @next_numX)

	END_RTN:
END
GO

IF  EXISTS (SELECT * FROM sys.objects 
	   WHERE object_id = OBJECT_ID(N'[dbo].[CiSP_GetAcctSerialNo]') 
	   AND type in (N'P')
	   )
	Print '<<< Success creating PROCEDURE  [dbo].[CiSP_GetAcctSerialNo] created !!! >>>'
else
	Print '<<< !!! Error creating PROCEDURE [dbo].[CiSP_GetAcctSerialNo] Not created >>>'
GO
---
---
---
--GRANT select  ON CiSP_GetAcctSerialNoTO CiUsers
--Print '<<< Assigned Execute  permissions for CiSP_GetAcctSerialNo to CTusers  >>>'
--go

