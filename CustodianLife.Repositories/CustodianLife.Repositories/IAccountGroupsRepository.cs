using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IAccountGroupsRepository:IRepository<AccountGroup, Int32?>
    {
        IList<AccountGroup> AccountGroupDetails();
        AccountGroup GetById(String _key);

    }
}
