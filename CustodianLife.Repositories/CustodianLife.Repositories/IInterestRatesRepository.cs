using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IInterestRatesRepository
    {
        IList<InterestRates> InterestRatesDetails();
        InterestRates GetById(String _key);
    }
}
