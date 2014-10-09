using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface ICompanyCodesRepository:IRepository<CompanyCodes,Int32?>
    {
        IList<CompanyCodes> CompanyCodesDetails();
        CompanyCodes GetById(String _key);

    }
}
