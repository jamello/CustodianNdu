using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IBonusInterestRatesRepository:IRepository<BonusInterestRate,Int32?>
    {
        IList<BonusInterestRate> BonusInterestRateDetails();
        BonusInterestRate GetById(String _key);


    }
}
