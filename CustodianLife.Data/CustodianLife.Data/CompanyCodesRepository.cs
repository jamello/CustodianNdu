using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
   public class CompanyCodesRepository:ICompanyCodesRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(CompanyCodes saveObj)
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
        public void Delete(CompanyCodes delObj)
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
        public IList<CompanyCodes> CompanyCodesDetails()
        {
            using (var session = GetSession())
            {
                var pDet = session.CreateCriteria<CompanyCodes>()

                                     .List<CompanyCodes>();

                return pDet;
            }
        }
        public CompanyCodes GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<CompanyCodes>(id);
            }
        }
        public CompanyCodes GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from CompanyCodes i where i.ccId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (CompanyCodes)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }


    }
}
