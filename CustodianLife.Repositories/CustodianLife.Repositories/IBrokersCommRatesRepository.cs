using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IBrokersCommRatesRepository:IRepository<BrokersCommRates,Int32?>
    {
        IList<BrokersCommRates> BrokersCommissionsDetails();
        BrokersCommRates GetById(String _key);

    }
}
