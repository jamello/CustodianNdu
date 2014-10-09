using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class PlanMasterRepository:IPlanMasterRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(PlanMaster saveObj)
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
        public void Delete(PlanMaster delObj)
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
        public IList<PlanMaster> PlanMasterInfo()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<PlanMaster>()

                                     .List<PlanMaster>();

                return pDet;
            }
        }
        public PlanMaster GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<PlanMaster>(id);
            }
        }
        public PlanMaster GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from PlanMaster i where i.pmId = " + keys[0]
                              + " and i.ProductCode = '" + keys[1] + "'"
                              +" and i.PlanCode = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (PlanMaster)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
