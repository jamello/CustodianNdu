using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
   public  class BankAccountsRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(BankAccounts saveObj)
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
        public void Delete(BankAccounts delObj)
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
        public IList<BankAccounts> BankAccountDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<BankAccounts>()

                                     .List<BankAccounts>();

                return pDet;
            }
        }
        public BankAccounts GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<BankAccounts>(id);
            }
        }
        public BankAccounts GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from BankAccounts i where i.baId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (BankAccounts)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
