using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class ProductDetailsRepository:IProductDetailsRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(ProductDetails saveObj)
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
        public void Delete(ProductDetails delObj)
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
        public IList<ProductDetails> ProductDetailInfo()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<ProductDetails>()

                                     .List<ProductDetails>();

                return pDet;
            }
        }
        public ProductDetails GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ProductDetails>(id);
            }
        }
        public ProductDetails GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ProductDetails i where i.pdId = " + keys[0]
                              + " and i.ProductDetailsModule = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (ProductDetails)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
