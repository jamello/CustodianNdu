using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;


namespace CustodianLife.Repositories
{
    public interface IProductCoversRepository:IRepository<ProductCoverDetails,Int32?>
    {
        IList<ProductCoverDetails> ProductCovers();
        ProductCoverDetails GetById(String _key);

    }
}
