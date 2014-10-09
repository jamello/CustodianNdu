using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class ReInsuranceTreatyCommissionRepository:IReInsuranceTreatyCommissionRepository
    {
               private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

               public void Save(ReInsuranceTreatyCommission saveObj)
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
               public void Delete(ReInsuranceTreatyCommission delObj)
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
               public IList<ReInsuranceTreatyCommission> ReInsuranceTreatyCommissionDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<ReInsuranceTreatyCommission>()

                                     .List<ReInsuranceTreatyCommission>();

                return pDet;
            }
        }
               public ReInsuranceTreatyCommission GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ReInsuranceTreatyCommission>(id);
            }
        }
               public ReInsuranceTreatyCommission GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ReInsuranceTreatyCommission i where i.tcId = " + keys[0]
                              + " and i.SystemModule = '" + keys[1] + "'"
                              + " and i.ProductCode = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (ReInsuranceTreatyCommission)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
