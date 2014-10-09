--drop table absdebmasttEST
select DISTINCT LEFT(DEB_ACC_NUM_OLD,1) AS ACN from ABSDEBMAST_CRU

select * from absdebmasttEST
select * from ABSDebtWoff
select DEB_ACC_NUM,DEB_ACC_NUM_OLD AS OLD, DEB_BUS_SOURCE from ABSDEBMAST_CRU
WHERE LEFT(DEB_ACC_NUM_OLD,1) NOT IN ('R','A','B','D')

SELECT [CODE]
      ,[NAME]
      ,[Trans# Date]
      ,[Trans No]
      ,[Ref Number]
      ,[Policy Number]
      ,[Insured Name]
      ,[Debitt Amount]
      ,[Credit Amount]
      ,[Net Amount]
      ,[Original Amt]
      ,[Remarks]
      ,[F13]
  FROM [ABS].[dbo].[ABSDebtWoff]
GO


--R
--A
--C
--1
--M
--0
--D
--I
--T
--B
--insert into absdebmasttEST
 
select	001 as recid,
		201312 as procdate,
		'HO' as brchnum,
		b.Code as acctnum,
		null as recnum,
		b.[Trans# Date] as transdate,
		b.[Trans No] as transnum,
	CASE left(b.[Trans No],3)
                         WHEN 'JV' THEN 'JVDB'
                         WHEN 'CJ' THEN 'JVDB'
                         WHEN 'BP' THEN 'JVDB'
                         WHEN '01' THEN 'JVDB'
                         WHEN 'BR' THEN 'JVDB'
                         WHEN 'DN' THEN 'JVDB'
                         WHEN 'RJ' THEN 'JVDB'
                         WHEN 'CN' THEN 'JVDB'
                     END as trantype,
                      b.[Trans# Date] as refdate,
                     b.[Ref Number] as refnum,
                     CASE left(b.[Trans No],3)
                         WHEN 'JV' THEN 'JVDB'
                         WHEN 'CJ' THEN 'JVDB'
                         WHEN 'BP' THEN 'JVDB'
                         WHEN '01' THEN 'JVDB'
                         WHEN 'BR' THEN 'JVDB'
                         WHEN 'DN' THEN 'JVDB'
                         WHEN 'RJ' THEN 'JVDB'
                         WHEN 'CN' THEN 'JVDB'
                     END as reftype,
                     ISNULL((SELECT t.[DEB_UNIT_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),8) as unitnum, --unit num defaults to 8 - head office if not found
                      ISNULL((SELECT t.[DEB_INS_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),'*') as insnum, --unit num defaults to '*' if not found
                      b.[Policy Number] as policynum,
                      ISNULL((SELECT t.[DEB_RISK_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),null) as risknum, --risk defaults to null - if not found
                      ISNULL((SELECT t.[DEB_SUBRISK_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),null) as subrisk, --sub risk defaults to null - if not found
                      LEFT([Trans No],2) as bustype,
                      'MISCELLANOUS W-OFF' as descr,
                      ' ' as ClaimNum, --Claim num
                       ISNULL((SELECT t.[DEB_BUS_SOURCE]
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),null) as bussource, --bus. source
                      0.00 as gross,
                      0.00 as commrate,
                      0.00 as commamt,
                      0.00 as vatrate,
                      0.00 as vatamt,
                      b.[Net Amount] as netamt,
                      'Y' as dropflag,
                      'CRU' as compflag,
                      'R' as debflag,
                      '2013-12-30' as keydate,
                      'ADM' as operid                     
--INTO absdebmasttEST 
from ABSDebtWoff b
--select 1139061079.91
--select 367786 + 4231 = 372017
--select distinct left([Trans No],3) from absDebtWoff

--JV
--CJ
--BP
--NULL
--01
--BR
--DN
--RJ
--CN



         