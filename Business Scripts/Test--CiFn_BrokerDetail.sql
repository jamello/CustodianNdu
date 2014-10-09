declare		@pBrokerCode nvarchar(15)

select		@pBrokerCode = 1
	
SELECT * FROM CiFn_BrokerDetail(@pBrokerCode,NULL,NULL,NULL)

