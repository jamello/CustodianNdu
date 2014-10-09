using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class BrokersCommRatesRepository:IBrokersCommRatesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(BrokersCommRates saveObj)
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
        public void Delete(BrokersCommRates delObj)
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
        public IList<BrokersCommRates> BrokersCommissionsDetails()
        {
            using (var session = GetSession())
            {
                var bComm = session.CreateCriteria<BrokersCommRates>()

                                     .List<BrokersCommRates>();

                return bComm;
            }
        }
        public BrokersCommRates GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<BrokersCommRates>(id);
            }
        }
        public BrokersCommRates GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from BrokersCommRates i where i.bcId = " + keys[0]
                              + " and i.ProductCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (BrokersCommRates)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
