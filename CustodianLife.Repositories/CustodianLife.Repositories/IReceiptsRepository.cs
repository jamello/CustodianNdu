using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IReceiptsRepository:IRepository<Receipts,Int32?>
    {
        IList<Receipts> ReceiptDetailInfo();
        Receipts GetById(String _key);
    }
}
