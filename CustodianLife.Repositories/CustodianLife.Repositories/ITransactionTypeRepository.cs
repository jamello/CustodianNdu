using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface ITransactionTypeRepository:IRepository<TransactionTypes,Int32?>
    {
        IList<TransactionTypes> TransactionTypesDetails();
        TransactionTypes GetById(String _key);


    }
}
