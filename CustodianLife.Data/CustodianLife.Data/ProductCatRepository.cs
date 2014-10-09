using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
    public class ProductCatRepository:IProductCatRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(ProductCategories saveObj)
        {
            using (var session = GetSession())
            {
                using (var trans = session.BeginTransaction())
                {
                    session.FlushMode = FlushMode.Commit;
                    session.SaveOrUpdate(saveObj);
                    trans.Commit();
                    session.Flush();
                    //}
                }
            }
        }
        public void Delete(ProductCategories delObj)
        {
            using (var session = GetSession())
            {
                using (var trans = session.BeginTransaction())
                {
                    session.Delete(delObj);
                    trans.Commit();
                }
            }
        }
        public IList<ProductCategories> ProductCategories()
        {
            using (var session = GetSession())
            {
                var pCategories = session.CreateCriteria<ProductCategories>()

                                     .List<ProductCategories>();

                return pCategories;
            }
        }
        public ProductCategories GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ProductCategories>(id);
            }
        }
        public ProductCategories GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ProductCategories i where i.pcId = " + keys[0]
                              + " and i.ProductCatModule = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (ProductCategories)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }  
}
