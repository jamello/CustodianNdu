using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;


namespace CustodianLife.Data
{
    public class AccountsChartRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(ChartOfAccounts saveObj)
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
        public void Delete(ChartOfAccounts delObj)
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
        public IList<ChartOfAccounts> AccountsChartInfo()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<ChartOfAccounts>()

                                     .List<ChartOfAccounts>();
                return intr;
            }
        }

        public IList<ChartOfAccounts> GetAccountChartList(String _key, String _value)
        {
            String fCriteria = string.Empty;
            string hqlOptions = string.Empty;
            //the _key is a code or name with which to filter the data
            if (_key == "All")
                fCriteria = "";
            else
                if (_key == "Code")
                    fCriteria = "MainAcctsCode";
                else
                    if (_key == "Name")
                        fCriteria = "FullDescription";
                    else
                        if (_key == "Name1")
                            fCriteria = "ShortDescription";

            switch (_key)
            {
                case "Code":
                case "Name":
                    hqlOptions = "from ChartOfAccounts c where c." + fCriteria + " like '%" + _value + "%'";
                    using (var session = GetSession())
                    {
                        return session.CreateQuery(hqlOptions).List<ChartOfAccounts>();
                    }
                case "Name1":

                    hqlOptions = " from ChartOfAccounts c where c." + fCriteria + " like '%" + _value + "%'";
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<ChartOfAccounts>();
                    }

                case "All":

                    hqlOptions = "from ChartOfAccounts c";
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<ChartOfAccounts>();
                    }

                default:
                    return null;
                // break;

            }
        }


        public ChartOfAccounts GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<ChartOfAccounts>(id);
            }
        }

        public ChartOfAccounts GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from ChartOfAccounts i where i.caId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              + " and i.MainAcctsCode = " + keys[2]
                              + " and i.SubAcctsCode = " + keys[3];

            using (var session = GetSession())
            {

                return (ChartOfAccounts)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }


    }
}
