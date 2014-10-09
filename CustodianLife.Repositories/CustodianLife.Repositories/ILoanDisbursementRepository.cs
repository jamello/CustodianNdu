using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface ILoanDisbursementRepository:IRepository<LoanDisbursement,Int32?>
    {
        IList<LoanDisbursement> LoanDisbursementDetails();
        LoanDisbursement GetById(String _key);



    }
}
