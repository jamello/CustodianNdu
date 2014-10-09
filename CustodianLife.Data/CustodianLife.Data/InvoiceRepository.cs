using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;
using System.Data.SqlClient;
using CustodianLife.Model;
using CustodianLife.Repositories;
using NHibernate;

namespace CustodianLife.Data
{
    public class InvoiceRepository:IInvoiceRepository
    {

        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(Invoice saveObj)
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
        public void Delete(Invoice delObj)
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
        public IList<Invoice> InvoiceDetails()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<Invoice>()

                                     .List<Invoice>();
                return intr;
            }
        }

        public Invoice GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from Invoice i where i.IvId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              + " and i.BatchNo = " + keys[2]
                              + " and i.BatchDate = " + keys[3]
                                  + " and i.SerialNo = " + keys[4];

            using (var session = GetSession())
            {

                return (Invoice)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }


        public IList<Invoice> GetById(String _key, String _value)
        {
            String fCriteria = string.Empty;
            string hqlOptions = string.Empty;
            //the _key is a code or name with which to filter the data
            if (_key == "Code")
                fCriteria = "InvoiceNo";
            else if (_key == "TDate")
                fCriteria = "TransDate";
            else if (_key == "BatchNo")
                fCriteria = "BatchNo";
            else if (_key == "BatchDate")
                fCriteria = "BatchDate";
            else if (_key == "All")
                fCriteria = "";

            switch (_key)
            {
                case "BatchNo":
                case "BatchDate":
                    hqlOptions = "from Invoice r where r." + fCriteria + " = '" + _value + "'";
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<Invoice>();
                    }
                case "Code":
                    hqlOptions = "from Invoice r where r." + fCriteria + " like '%" + _value + "%'";
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<Invoice>();
                    }
                case "TDate":

                    hqlOptions = "from Invoice r where r." + fCriteria + " = " + _value;
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<Invoice>();
                    }

                case "All":

                    hqlOptions = "from Invoice r";
                    using (var session = GetSession())
                    {
                        return session.CreateQuery(hqlOptions).List<Invoice>();
                    }

                default:
                    return null;
                // break;

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


        public Invoice GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<Invoice>(id);
            }
        }

       
        /// <summary>
        /// this returns a dataset to be converted to XML for serialization into a Json object 
        /// used to retrieve data from the back end to the html page using jQuery 
        /// </summary>
        /// <param name="qry"></param>
        /// <returns></returns>
        private static DataSet GetDataSet(string qry)
        {
            using (var session = GetSession())
            {
                using (var conn = session.Connection as SqlConnection)
                {
                    var adapter = new SqlDataAdapter(qry, conn);
                    var dataSet = new System.Data.DataSet();

                    adapter.Fill(dataSet);

                    return dataSet;
                }
            }
        }

        private static DataSet GetDataSet(string qry, SqlCommand com)
        {
            using (var session = GetSession())
            {
                using (var conn = session.Connection as SqlConnection)
                {
                    var adapter = new SqlDataAdapter();
                    var dataSet = new System.Data.DataSet();
                    com.Connection = conn;
                    adapter.SelectCommand = com;
                    adapter.Fill(dataSet);

                    return dataSet;

                }
            }
        }


        public String GetNextSerialNumber(string sys_id
                                           , String sys_type
                                           , String sys_branch
                                           , String sys_year
                                           , String sys_prefix
                                           , String sys_out_int
                                           , String sys_out_char)
        {
            var session = GetSession();
            session.BeginTransaction();
            IDbCommand command = session.Connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "CiSP_GetAcctSerialNo";

            IDbDataParameter inputparameter1 = command.CreateParameter();
            inputparameter1.ParameterName = "@PARAM_SYS_ID";
            inputparameter1.DbType = DbType.String;
            inputparameter1.Size = 5;
            inputparameter1.Direction = ParameterDirection.Input;
            inputparameter1.Value = sys_id;

            command.Parameters.Add(inputparameter1);

            IDbDataParameter inputparameter2 = command.CreateParameter();
            inputparameter2.ParameterName = "@PARAM_SYS_TYPE";
            inputparameter2.DbType = DbType.String;
            inputparameter2.Direction = ParameterDirection.Input;
            inputparameter2.Size = 5;
            inputparameter2.Value = sys_type;
            command.Parameters.Add(inputparameter2);

            IDbDataParameter inputparameter3 = command.CreateParameter();
            inputparameter3.ParameterName = "@PARAM_SYS_BRANCH";
            inputparameter3.DbType = DbType.String;
            inputparameter3.Direction = ParameterDirection.Input;
            inputparameter3.Size = 5;
            inputparameter3.Value = sys_branch;
            command.Parameters.Add(inputparameter3);

            IDbDataParameter inputparameter4 = command.CreateParameter();
            inputparameter4.ParameterName = "@PARAM_SYS_YEAR";
            inputparameter4.DbType = DbType.String;
            inputparameter4.Direction = ParameterDirection.Input;
            inputparameter4.Size = 10;
            inputparameter4.Value = sys_year;
            command.Parameters.Add(inputparameter4);

            IDbDataParameter inputparameter5 = command.CreateParameter();
            inputparameter5.ParameterName = "@PARAM_SYS_PREFIX";
            inputparameter5.DbType = DbType.String;
            inputparameter5.Size = 10;
            inputparameter5.Direction = ParameterDirection.Input;
            inputparameter5.Value = sys_prefix;
            command.Parameters.Add(inputparameter5);

            IDbDataParameter inputparameter6 = command.CreateParameter();
            inputparameter6.ParameterName = "@PARAM_OUT_INT";
            inputparameter6.DbType = DbType.String;
            inputparameter6.Direction = ParameterDirection.Input;
            inputparameter6.Size = 20;
            inputparameter6.Value = sys_out_int;
            command.Parameters.Add(inputparameter6);

            IDbDataParameter outparameter = command.CreateParameter();
            outparameter.ParameterName = "@PARAM_OUT_CHAR";
            outparameter.DbType = DbType.String;
            outparameter.Size = 20;
            outparameter.Direction = ParameterDirection.Output;
            command.Parameters.Add(outparameter);

            session.Transaction.Enlist(command);
            command.ExecuteNonQuery();

            //retrieve value from out parameter
            IDbDataParameter outparameter4valu = command.CreateParameter();

            outparameter4valu = (IDbDataParameter)command.Parameters["@PARAM_OUT_CHAR"];
            string outval = (string)outparameter4valu.Value;

            session.Transaction.Commit();
            return outval;
        }

        public String GetInvoiceInfo(string _creditorcode
                                     , String _invoiceno)
        {


            string query = "SELECT * "
                          + "FROM CiFn_GetCredMasterDetail('"
                          + _creditorcode + "','"
                          + _invoiceno + "',NULL,NULL,NULL)";

            return GetDataSet(query).GetXml();
        }

        public String GetBrokerInfo(string _brokercode)
        {


            string query = "SELECT * "
                          + "FROM CiFn_BrokerDetail('"
                          + _brokercode + "',NULL,NULL,NULL)";

            return GetDataSet(query).GetXml();
        }



    }
}
