using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
namespace CustodianLife.Repositories
{
    public interface IAccountsChartRepository:IRepository<ChartOfAccounts,Int32?>
    {
        IList<ChartOfAccounts> AccountsChartInfo();
        ChartOfAccounts GetById(String _key);
    }
}
