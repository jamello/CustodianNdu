using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class LoanInterestRepository:ILoanInterestRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(LoanInterest saveObj)
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
        public void Delete(LoanInterest delObj)
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
        public IList<LoanInterest> LoanInterestRates()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<LoanInterest>()

                                     .List<LoanInterest>();

                return intr;
            }
        }

        public LoanInterest GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from LoanInterest i where i.biId = " + keys[0]
                              + " and i.LoanCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (LoanInterest)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }



        public LoanInterest GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<LoanInterest>(id);
            }
        }





    }
}
