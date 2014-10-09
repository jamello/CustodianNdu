select distinct a.DEB_ACC_NUM, a.DEB_TRANS_NUM from absdebmast_cru a





select * from absdebmast_cru a
where  DEB_ACC_NUM = b.code    

select 
		(select cast(DEB_UNIT_NUM as char(10))
		from absdebmast_cru
		where DEB_ACC_NUM = b.code and DEB_TRANS_NUM =b.[Trans No])
		
from ABSDebtWoff b

select 
	001,201312,'HO',b.Code,null,b.[Trans# Date],b.[Trans No],
	CASE left(b.[Trans No],3)
                         WHEN 'JV' THEN 'JV'
                         WHEN 'CJ' THEN 'JV'
                         WHEN 'BP' THEN 'BP'
                         WHEN '01' THEN '01'
                         WHEN 'BR' THEN 'BR'
                         WHEN 'DN' THEN 'CN'
                         WHEN 'RJ' THEN 'RJ'
                         WHEN 'CN' THEN 'DN'
                     END, b.[Trans# Date],b.[Ref Number],NULL,
                     
from ABSDebtWoff b

 --(select  cast(DEB_UNIT_NUM as char(10)) + ', '+ DEB_INS_NUM + ', ' + DEB_RISK_NUM + ', ' +  DEB_SUBRISK_NUM + ', ' + 
	--	  DEB_BUS_TYPE + ', ' + DEB_BUS_SOURCE + ', ' + DEB_CLAIM_NUM