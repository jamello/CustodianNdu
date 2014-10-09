using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class RateTypeCodesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(RateTypeCodes saveObj)
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
        public void Delete(RateTypeCodes delObj)
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
        public IList<RateTypeCodes> RateTypeCodesDetails()
        {
            using (var session = GetSession())
            {
                var mInfo = session.CreateCriteria<RateTypeCodes>()

                                     .List<RateTypeCodes>();

                return mInfo;
            }
        }
        public RateTypeCodes GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<RateTypeCodes>(id);
            }
        }
        public RateTypeCodes GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from RateTypeCodes i where i.rtId = " + keys[0]
                              + " and i.ModuleSource = '" + keys[1] + "'"
                              + " and i.ProductCode = '" + keys[2] + "'";

            
            using (var session = GetSession())
            {

                return (RateTypeCodes)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
