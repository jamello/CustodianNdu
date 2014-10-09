using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;
namespace CustodianLife.Data
{
    public class LoanDisbursementRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(LoanDisbursement saveObj)
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
        public void Delete(LoanDisbursement delObj)
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
        public IList<LoanDisbursement> LoanDisbursementInfo()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<LoanDisbursement>()

                                     .List<LoanDisbursement>();

                return intr;
            }
        }

        public LoanDisbursement GetById(String _key)
        {
            //the _key is an array of string values (4). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from LoanDisbursement i where i.ldId = " + keys[0]
                              + " and i.LoanCode = '" + keys[1] + "'"
                              + " and i.ProductCode = '" + keys[2] + "'"
                              + " and i.PolicyNumber = '" + keys[3] + "'";
    
            using (var session = GetSession())
            {

                return (LoanDisbursement)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }



        public LoanDisbursement GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<LoanDisbursement>(id);
            }
        }


    }
}
