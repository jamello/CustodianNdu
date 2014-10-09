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
    public class GLTransRepository:IGLTransRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(GLTrans saveObj)
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
        public void Delete(GLTrans delObj)
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
        public IList<GLTrans> GLTransDetails()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<GLTrans>()

                                     .List<GLTrans>();
                return intr;
            }
        }

        public GLTrans GetById(String _key)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from GLTrans i where i.glId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              + " and i.BatchNo = " + keys[2]
                              + " and i.BatchDate = " + keys[3]
                                  + " and i.SerialNo = " + keys[4];

            using (var session = GetSession())
            {

                return (GLTrans)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }
        public GLTrans GetById(String _key, String _prg)
        {
            //the _key is an array of string values (3). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from GLTrans i where i.glId = " + keys[0]
                              + " and i.CompanyCode = '" + keys[1] + "'"
                              + " and i.BatchNo = " + keys[2]
                              + " and i.BatchDate = " + keys[3]
                                  + " and i.SerialNo = " + keys[4]
                                  + " and i.SubSerialNo = " + keys[5]
                                + " and i.TransType = '" + _prg + "'";

            using (var session = GetSession())
            {

                return (GLTrans)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }


        public IList<GLTrans> GetById(String _key, String _value, String _prg, Int32? _searchDirection)
        {
            if (_value != null)
                _value = _value.Trim();
            //            _value = value;
            String fCriteria = string.Empty;
            string hqlOptions = string.Empty;
            //the _key is a code or name with which to filter the data
            if (_key == "Code")
                fCriteria = "DocNo";
            if (_key == "Code2")
                fCriteria = "DocNo";
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
                    if (_prg == "journal" || _prg == "JV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'JV'";
                    }
                    else if (_prg == "payment" || _prg == "PV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'PV'";
                    }
                    else
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'R'";
                    }

                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<GLTrans>();
                    }
                case "Code":

                    if (_prg == "journal" || _prg == "JV")
                    {
                        if (_searchDirection == 0) // from the begining
                        {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " like '" + _value + "%' and TransType = 'JV'";
                        } 
                        else
                            hqlOptions = "from GLTrans r where r." + fCriteria + " like '%" + _value + "%' and TransType = 'JV'";

                    }
                    else if (_prg == "payment" || _prg == "PV")
                    {
                        if (_searchDirection == 0)
                        {
                            hqlOptions = "from GLTrans r where r." + fCriteria + " like '" + _value + "%' and TransType = 'PV'";
                        }
                        else
                            hqlOptions = "from GLTrans r where r." + fCriteria + " like '%" + _value + "%' and TransType = 'PV'";
                    }
                    else
                    {
                        if (_searchDirection == 0)//display occurrence of the string only in the beginings of sentences or words
                        {
                            hqlOptions = "from GLTrans r where r." + fCriteria + " like '" + _value + "%' and TransType = 'R'";
                        }
                        else
                            //display occurrence of the string anywhere on sentences or words
                            hqlOptions = "from GLTrans r where r." + fCriteria + " like '%" + _value + "%' and TransType = 'R'";

                    }
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<GLTrans>();
                    }
                case "Code2":

                    if (_prg == "journal" || _prg == "JV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'JV'";
                    }
                    else if (_prg == "payment" || _prg == "PV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'PV'";
                    }
                    else
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = '" + _value + "' and TransType = 'R'";
                    }
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<GLTrans>();
                    }
                case "TDate":

                    if (_prg == "journal" || _prg == "JV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = " + _value + " and TransType = 'JV'";
                    }
                    else if (_prg == "payment" || _prg == "PV")
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = " + _value + " and TransType = 'PV'";
                    }
                    else
                    {
                        hqlOptions = "from GLTrans r where r." + fCriteria + " = " + _value + " and TransType = 'R'";
                    }

                    
                    using (var session = GetSession())
                    {

                        return session.CreateQuery(hqlOptions).List<GLTrans>();
                    }

                case "All":

                    hqlOptions = "from GLTrans r";

                    if (_prg == "journal" || _prg == "JV")
                    {
                        hqlOptions = "from GLTrans r where  r.TransType = 'JV'";
                    }
                    else if (_prg == "payment" || _prg == "PV")
                    {
                        hqlOptions = "from GLTrans r where  r.TransType = 'PV'";
                    }
                    else
                    {
                        hqlOptions = "from GLTrans r where  r.TransType = 'R'";
                    }
                    
                    using (var session = GetSession())
                    {
                        return session.CreateQuery(hqlOptions).List<GLTrans>();
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


        public GLTrans GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<GLTrans>(id);
            }
        }
        
        /// <summary>
        /// Gets the policy info in a dataset. 
        /// this is to be converted to the xml format transferred to the jquery function
        /// </summary>
        /// <param name="criteriaValue">Either the policy or the proposal number </param>
        /// <param name="searchtype">the search switch (P = Policy, D = Proposal)</param>
        /// <returns></returns>
        public String GetPolicyInfo(String criteriaValue, String searchType)
        {
            String fld = String.Empty;
            if (searchType == "P")
                fld = "[TBIL_POLY_POLICY_NO]";
            else if (searchType == "D")
                fld = "[TBIL_POLY_PROPSAL_NO]";


            string query = "SELECT "
                           + " [TBIL_POLY_PROPSAL_NO]"
                          + ",[TBIL_POLY_POLICY_NO]"
                          + ",[TBIL_POLY_ASSRD_CD]"
                          + ",(SELECT [TBIL_INSRD_SURNAME] + ' ' + [TBIL_INSRD_FIRSTNAME] + ' ' + [TBIL_INSRD_LONG_NAME] "
                          + " FROM [TBIL_INS_DETAIL] b WHERE b.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Name"
                          + "	                    ,	(SELECT "
                          + "    [TBIL_INSRD_ADRES1] + ' ' + [TBIL_INSRD_ADRES2] "
                          + "  FROM [TBIL_INS_DETAIL] y "
                          + "  WHERE y.[TBIL_INSRD_CODE] = p.[TBIL_POLY_ASSRD_CD]) as Insured_Address "
                          + ",[TBIL_POLY_AGCY_CODE]"
                          + ",(SELECT [TBIL_AGCY_AGENT_NAME] FROM [TBIL_AGENCY_CD] d WHERE d.[TBIL_AGCY_AGENT_CD]= p.[TBIL_POLY_AGCY_CODE]) as Agent_Name"
                          + ", [TBIL_POL_PRM_DTL_MOP_PRM_LC]"

                          + ",[TBIL_POL_PRM_MODE_PAYT] as Payment_Mode "
                          + ",(SELECT CASE [TBIL_POL_PRM_MODE_PAYT] WHEN 'M' THEN 'MONTHLY' WHEN 'A' THEN 'ANNUALLY' WHEN 'H' THEN 'HALF YEARLY' WHEN 'Q' THEN 'QUARTERLY' END) as Payment_Mode_Desc "
                          + ",convert(varchar, [TBIL_POLICY_EFF_DT], 102) as TBIL_POLICY_EFF_DT"
                          + " FROM [TBIL_POLICY_DET] p INNER JOIN [TBIL_POLICY_PREM_DETAILS] q "
                          + "ON p.[TBIL_POLY_POLICY_NO] = q.[TBIL_POL_PRM_DTL_POLY_NO] "
                          + "INNER JOIN [TBIL_POLICY_PREM_INFO] r "
                          + "ON p.[TBIL_POLY_POLICY_NO] = r.TBIL_POL_PRM_POLY_NO "
                          + " WHERE p." + fld + " = '" + criteriaValue + "'";
            return GetDataSet(query).GetXml();

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


        public String GetGroupDRNoteInfo(string _brokercode
                                        , String _policynum
                                        , String _transno)
        {


            string query = "SELECT * "
                          + "FROM CiFn_GrpPolDNoteDetail('"
                          + _brokercode + "','"
                          + _policynum + "',"
                          + _transno + ",NULL,NULL,NULL)";

            return GetDataSet(query).GetXml();
        }


        public String GetClaimsDRNoteInfo(string _brokercode
                                        , String _claimnum
                                        , String _transno)
        {


            string query = "SELECT * "
                          + "FROM CiFn_GrpClaimsDNoteDetail('"
                          + _brokercode + "','"
                          + _claimnum + "',"
                          + _transno + ",NULL,NULL,NULL)";

            return GetDataSet(query).GetXml();
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
