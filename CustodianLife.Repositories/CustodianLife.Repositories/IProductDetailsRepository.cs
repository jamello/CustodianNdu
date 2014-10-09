using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IProductDetailsRepository:IRepository<ProductDetails,Int32?>
    {
        IList<ProductDetails> ProductDetailInfo();
        ProductDetails GetById(String _key);
    }
}
