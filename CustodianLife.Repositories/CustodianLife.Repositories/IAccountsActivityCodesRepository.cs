using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;


namespace CustodianLife.Repositories
{
    public interface IAccountsActivityCodesRepository : IRepository<AccountsActivityCodes,Int32?>
    {
        IList<AccountsActivityCodes> AccountsActivityCodesDetails();
        AccountsActivityCodes GetById(String _key);

    }
}
