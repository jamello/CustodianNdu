select * from ABSDebtWoff
select *  from ABSDEBMAST_CRU
select * from absdebmastTEST
select	'001' as recid,
		'201312' as procdate,
		'HO' as brchnum,
		b.Code as acctnum,
		null as recnum,
		b.[Trans# Date] as transdate,
		b.[Trans No] as transnum,
	CASE left(b.[Trans No],2)
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
                     CASE left(b.[Trans No],2)
                         WHEN 'JV' THEN 'JVDB'
                         WHEN 'CJ' THEN 'JVDB'
                         WHEN 'BP' THEN 'JVDB'
                         WHEN '01' THEN 'JVDB'
                         WHEN 'BR' THEN 'JVDB'
                         WHEN 'DN' THEN 'JVDB'
                         WHEN 'RJ' THEN 'JVDB'
                         WHEN 'CN' THEN 'JVDB'
                     END as reftype,
                     (SELECT ISNULL(t.[DEB_UNIT_NUM],8) 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]) as unitnum, --unit num defaults to 8 - head office if not found
                      ISNULL((SELECT t.[DEB_INS_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),'*') as insnum, --unit num defaults to '*' if not found
                      b.[Policy Number] as policynum,
                      b.[Policy Number] as policynumold,
                      ISNULL((SELECT t.[DEB_RISK_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),null) as risknum, --risk defaults to null - if not found
                      ISNULL((SELECT t.[DEB_SUBRISK_NUM] 
                      FROM ABSTEMPDEBTINFO t 
                      WHERE t.[DEB_ACC_NUM] = b.CODE AND t.DEB_TRANS_NUM = b.[Trans No]),null) as subrisk, --sub risk defaults to null - if not found
                      LEFT([Trans No],2) as bustype,
                      b.[Insured Name] as debdescr,
                      null as ClaimNum, --Claim num
                      null as ClaimNumOld, --Claim num
                       LEFT(CODE,1) as bussource, --bus. source
                      b.[Debitt Amount] as gross,
                      0.00 as commrate,
                      [Credit Amount] as commamt,
                      0.00 as vatrate,
                      0.00 as vatamt,
                      b.[Original Amt] as origamt,
                      'C' as origdrcr,
                      b.[Net Amount] as netamt,
                      NULL as dropflag,
                      'CRU' as compflag,
                      'R' as debflag,
                      '2013-12-30' as keydate,
                      'ADM' as operid                     
INTO absdebmastTEST 
from ABSDebtWoff b

