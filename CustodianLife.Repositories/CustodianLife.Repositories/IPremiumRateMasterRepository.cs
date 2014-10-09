using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IPremiumRateMasterRepository:IRepository<PremiumRatesMaster,Int32?>
    {
        IList<PremiumRatesMaster> PremiumRatesDetails();
        PremiumRatesMaster GetById(String _key);

    }
}
