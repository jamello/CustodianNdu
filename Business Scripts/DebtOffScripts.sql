

--drop table ABSDebtWoff
--SELECT  * into ABSDebtWoff  
--FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
--	 'Data Source="C:\james stuff\myC\WEBAPPS\PRODUCTION\CSHARP\VS2008 version\CustodianLife\credit control francis\PREMDECWRITOFF2013.xlsx";User ID=Admin;Password=;Extended properties="Excel 12.0;HDR=YES;IMEX=1";'
--         )...[WOFF$];

SELECT  * into ABSDebtWoff  
FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
'Data Source="C:\james stuff\myC\WEBAPPS\PRODUCTION\CSHARP\VS2008 version\CustodianLife\credit control francis\PREMDECWRITOFF2013.xls";Extended Properties=EXCEL 5.0')
...[WOFF$] ;

SELECT * FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
'Data Source=C:\DataFolder\Documents\TestExcel.xls;Extended Properties=EXCEL 5.0')...[Sheet1$] ;
--prepare the sql server for the first time
--EXEC sp_MSset_oledb_prop 'Microsoft.ACE.OLEDB.12.0', 'AllowInProcess' , 1; 
--EXEC sp_MSset_oledb_prop 'Microsoft.ACE.OLEDB.12.0', 'DynamicParameters', 1

--select * from absdebmast

--ALTER TABLE ABSDebtWoff
--  ALTER COLUMN [F13]
--    VARCHAR(255) COLLATE SQL_Latin1_General_CP1_CI_AS 

--SELECT
--    col.name, col.collation_name
--FROM 
--    sys.columns col
--WHERE
--    object_id = OBJECT_ID('absdebmast_cru')