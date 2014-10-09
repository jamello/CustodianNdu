using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;
namespace CustodianLife.Data
{
    public class AgencyProductionBudgetRepository:IAgencyProductionBudgetRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(AgencyProductionBudget saveObj)
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
        public void Delete(AgencyProductionBudget delObj)
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
        public IList<AgencyProductionBudget> AgencyProductionBudgetDetails()
        {
            using (var session = GetSession())
            {
                var aComm = session.CreateCriteria<AgencyProductionBudget>()

                                     .List<AgencyProductionBudget>();

                return aComm;
            }
        }
        public AgencyProductionBudget GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<AgencyProductionBudget>(id);
            }
        }
        public AgencyProductionBudget GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from AgencyProductionBudget i where i.abId = " + keys[0]
                              + " and i.AgencyTypeCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (AgencyProductionBudget)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }

    }
}
