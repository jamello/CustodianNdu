using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
    public class AccountsActivityCodesRepository:IAccountsActivityCodesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(AccountsActivityCodes saveObj)
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
        public void Delete(AccountsActivityCodes delObj)
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
        public IList<AccountsActivityCodes> AccountsActivityCodesDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<AccountsActivityCodes>()

                                     .List<AccountsActivityCodes>();

                return pDet;
            }
        }
        public AccountsActivityCodes GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<AccountsActivityCodes>(id);
            }
        }
        public AccountsActivityCodes GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from AccountsActivityCodes i where i.aaId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              +" and i.GLMainAccountCode = '" + keys[2] + "'";
            
            using (var session = GetSession())
            {

                return (AccountsActivityCodes)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }




    }
}
