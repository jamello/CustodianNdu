using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;

namespace CustodianLife.Repositories
{
    public interface IProductCatRepository:IRepository<ProductCategories,Int32?>
    {
        IList<ProductCategories> ProductCategories();
        ProductCategories GetById(String _key);
    }
}
