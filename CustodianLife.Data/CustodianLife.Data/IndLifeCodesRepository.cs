using System;
using System.Collections;

using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class IndLifeCodesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(LifeCodes saveObj)
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
        public void Delete(LifeCodes delObj)
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
        public IList<LifeCodes> IndividualLifeCodes()
        {
            using (var session = GetSession())
            {
                var lndCodes = session.CreateCriteria<LifeCodes>()
                                     
                                     .List<LifeCodes>();

                return lndCodes;
            }
        }

        //public  IList IndividualLifeCode()
        //{
        //    using (var session = GetSession())
        //    {
        //        var lndCodes = session.CreateFilter(IndividualLifeCodes, "")

        //                             .List<LifeCodes>();

        //        return lndCodes;
        //    }
        //}
        ////hql "from" and "select" are implicit
        //var ordersByDate = session
        //    .CreateFilter(cust.OrderCollection, "order by OrderDate")
        //    .List<Order>();
        ////use no hql to just do paging
        //var orders = session
        //    .CreateFilter(cust.OrderCollection, "") //empty hql
        //    .SetMaxResults(5).SetFirstResult(5) //paging
        //    .List<Order>();

        public LifeCodes GetById(String _key) 
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] {','};
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from LifeCodes i where i.lcId = " + keys[0] 
                              + " and i.CodeTabId = '" + keys[1] + "' and i.CodeType = '" + keys[2] + "'";

            using (var session = GetSession())
            {

                return (LifeCodes)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
        /// <summary>
        /// Pull data using the tabid and the type
        /// </summary>
        /// <param name="CodeTabId">TabId</param>
        /// <param name="CodeType">CodeType</param>
        /// <returns></returns>
        public IList GetById(String CodeTabId, String CodeType)
        {

            string hqlOptions = "from LifeCodes i where i.CodeTabId = '" + CodeTabId + "' and i.CodeType = '" + CodeType + "'";

            using (var session = GetSession())
            {

                return (IList)session.CreateQuery(hqlOptions).List();
            }
        }

        public LifeCodes GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<LifeCodes>(id);
            }
        }
        



    }
}
