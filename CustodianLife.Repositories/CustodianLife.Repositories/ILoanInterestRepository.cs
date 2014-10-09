using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface ILoanInterestRepository:IRepository<LoanInterest,Int32?>
    {
        IList<LoanInterest> LoanInterestRates();
        LoanInterest GetById(String _key);

    }
}
