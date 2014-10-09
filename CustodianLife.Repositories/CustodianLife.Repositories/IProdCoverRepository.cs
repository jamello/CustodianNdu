using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IProdCoverRepository : IRepository<ProductCoverDetails, Int32?>
    {
        IList<ProductCoverDetails> ProductCoverDetail();
        ProductCoverDetails GetById(String _key);

    }
}
