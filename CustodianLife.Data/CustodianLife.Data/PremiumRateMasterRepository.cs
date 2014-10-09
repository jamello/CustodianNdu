using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class PremiumRateMasterRepository:IPremiumRateMasterRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(PremiumRatesMaster saveObj)
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
        public void Delete(PremiumRatesMaster delObj)
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
        public IList<PremiumRatesMaster> PremiumRatesDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<PremiumRatesMaster>()

                                     .List<PremiumRatesMaster>();

                return pDet;
            }
        }
        public PremiumRatesMaster GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<PremiumRatesMaster>(id);
            }
        }
        public PremiumRatesMaster GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from PremiumRatesMaster i where i.pmId = " + keys[0]
                              + " and i.ModuleSource = '" + keys[1] + "'"
                              + " and i.ProductCode = '" + keys[2] + "'"
                              + " and i.RateTypeCode = '" + keys[3] + "'";

            using (var session = GetSession())
            {

                return (PremiumRatesMaster)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
