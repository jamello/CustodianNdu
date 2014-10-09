using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class ProductCoverDetailsRepository:IProductCoversRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(ProductCoverDetails saveObj)
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
        public void Delete(ProductCoverDetails delObj)
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
        public IList<ProductCoverDetails> ProductCovers()
        {
            using (var session = GetSession())
            {
                var pCovers = session.CreateCriteria<ProductCoverDetails>()

                                     .List<ProductCoverDetails>();

                return pCovers;
            }
        }
        public ProductCoverDetails GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ProductCoverDetails>(id);
            }
        }
        public ProductCoverDetails GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ProductCoverDetails i where i.pcId = " + keys[0]
                              + " and i.ProductCoverModule = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (ProductCoverDetails)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }  
}
