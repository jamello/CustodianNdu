using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IInvoiceRepository:IRepository<Invoice,Int32?>
    {
        IList<Invoice> InvoiceDetails();
        Invoice GetById(String _key);

    }
}
