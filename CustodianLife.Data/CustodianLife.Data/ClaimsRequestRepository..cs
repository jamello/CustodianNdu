using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class ClaimsRequestRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(ClaimsRequest saveObj)
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
        public void Delete(ClaimsRequest delObj)
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
        public IList<ClaimsRequest> ClaimsRequestDetails()
        {
            using (var session = GetSession())
            {
                var bCreq = session.CreateCriteria<ClaimsRequest>()

                                     .List<ClaimsRequest>();

                return bCreq;
            }
        }
        public ClaimsRequest GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ClaimsRequest>(id);
            }
        }
        public ClaimsRequest GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ClaimsRequest i where i.crId = " + keys[0]
                              + " and i.ClaimsNo = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (ClaimsRequest)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
