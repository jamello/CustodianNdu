using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class MedicalExamsRepository:IMedicalExamsRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(MedicalExams saveObj)
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
        public void Delete(MedicalExams delObj)
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
        public IList<MedicalExams> MedicalExamsInfo()
        {
            using (var session = GetSession())
            {
                var mInfo = session.CreateCriteria<MedicalExams>()

                                     .List<MedicalExams>();

                return mInfo;
            }
        }
        public MedicalExams GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<MedicalExams>(id);
            }
        }
        public MedicalExams GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from MedicalExams i where i.meId = " + keys[0]
                              + " and i.ModuleSource = '" + keys[1] + "'";

            using (var session = GetSession())
            {

                return (MedicalExams)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
    }
}
