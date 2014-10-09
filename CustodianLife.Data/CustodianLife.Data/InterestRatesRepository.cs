using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
    public class InterestRatesRepository:IInterestRatesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(InterestRates saveObj)
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
        public void Delete(InterestRates delObj)
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
        public IList<InterestRates> InterestRatesDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<InterestRates>()

                                     .List<InterestRates>();

                return pDet;
            }
        }
        public InterestRates GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<InterestRates>(id);
            }
        }
        public InterestRates GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from InterestRates i where i.irId = " + keys[0]
                              + " and i.ProductCode = '" + keys[1] + "'"
                              + " and i.RateType = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (InterestRates)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
