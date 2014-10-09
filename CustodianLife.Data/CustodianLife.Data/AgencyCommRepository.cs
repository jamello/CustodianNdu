using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class AgencyCommRepository:IAgcyStdComRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(AgencyStandardComm saveObj)
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
        public void Delete(AgencyStandardComm delObj)
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
        public IList<AgencyStandardComm> AgencyStandardCommissions()
        {
            using (var session = GetSession())
            {
                var aComm = session.CreateCriteria<AgencyStandardComm>()

                                     .List<AgencyStandardComm>();

                return aComm;
            }
        }
        public AgencyStandardComm GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<AgencyStandardComm>(id);
            }
        }
        public AgencyStandardComm GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from AgencyStandardComm i where i.acId = " + keys[0]
                              + " and i.ProductCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (AgencyStandardComm)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
