using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;



namespace CustodianLife.Repositories
{
    public interface IBankAccountsRepository:IRepository<BankAccounts,Int32?>
    {
        IList<BankAccounts> BankAccountDetails();
        BankAccounts GetById(String _key);

    }
}
