using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class AccountGroupsRepository:IAccountGroupsRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(AccountGroup saveObj)
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
        public void Delete(AccountGroup delObj)
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
        public IList<AccountGroup> AccountGroupDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<AccountGroup>()

                                     .List<AccountGroup>();

                return pDet;
            }
        }
        public AccountGroup GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<AccountGroup>(id);
            }
        }
        public AccountGroup GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from AccountGroup i where i.agId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              + " and i.AccountGroupCode = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (AccountGroup)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
