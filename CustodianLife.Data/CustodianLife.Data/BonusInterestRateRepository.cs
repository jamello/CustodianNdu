using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
    public class BonusInterestRateRepository:IBonusInterestRatesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(BonusInterestRate saveObj)
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
        public void Delete(BonusInterestRate delObj)
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
        public IList<BonusInterestRate> BonusInterestRateDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<BonusInterestRate>()

                                     .List<BonusInterestRate>();

                return pDet;
            }
        }
        public BonusInterestRate GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<BonusInterestRate>(id);
            }
        }
        public BonusInterestRate GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from BonusInterestRate i where i.irId = " + keys[0]
                              + " and i.ProductCode = '" + keys[1] + "'"
                              + " and i.RateTypeCode = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (BonusInterestRate)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
