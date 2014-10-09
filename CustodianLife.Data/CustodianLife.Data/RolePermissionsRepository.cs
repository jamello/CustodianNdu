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
    public class RolePermissionsRepository:IRolePermissionsRepository
    {
        private static ISession GetSession()
        {
            return SessionProvider.SessionFactory.OpenSession();
        }

        public void Save(RolePermissions saveObj)
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
        public void Delete(RolePermissions delObj)
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
        public IList<RolePermissions> RoleDetails()
        {
            using (var session = GetSession())
            {
                var intr = session.CreateCriteria<RolePermissions>()

                                     .List<RolePermissions>();
                return intr;
            }
        }

        public RolePermissions GetByRole(String _key)
        {
            //the _key is an array of string values (2). Split into individual values and fill the parameters
            Char[] seperator = new char[] { ',' };
            string[] keys = _key.Split(seperator, StringSplitOptions.RemoveEmptyEntries);

            string hqlOptions = "from RolePermissions i where i.rtId = " + keys[0]
                              + " and i.UserRole = '" + keys[1] + "'";
                              
            using (var session = GetSession())
            {

                return (RolePermissions)session.CreateQuery(hqlOptions).UniqueResult();
            }
        }







        public RolePermissions GetById(Int32? id)
        {
            using (var session = GetSession())
            {
                return session.Get<RolePermissions>(id);
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




        public String GetRolePermissions(string _rolename)
        {


            string query = "SELECT * "
                          + "FROM CiFn_RolePermissionsLoad('"
                          + _rolename + "',NULL,NULL,NULL)";

            return GetDataSet(query).GetXml();
        }

        /// <summary>
        /// Provides the receipt details to enable printing
        /// </summary>
        /// <param name="_receiptNo">the receipt number to be printed</param>
        /// <returns>Returns a dataset to be used by the print engine</returns>
        public DataSet GetReceiptDetails(string _receiptNo)
        {


            string query = "SELECT * "
                          + "FROM CiFn_ReceiptDetails('"
                          + _receiptNo + "',NULL,NULL,NULL)";

            return GetDataSet(query);

        }


        public String GetPaymentCover1(string _polnum
                                         , String _mop
                                         , String _effdate
                                         , String _contrib
                                        , String _amtpaid)
        {

            var session = GetSession();
            session.BeginTransaction();
            SqlCommand command = (SqlCommand)session.Connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "CiFn_ReceiptCoverPeriods";

            SqlParameter inputparameter1 = command.CreateParameter();
            inputparameter1.ParameterName = "@pPolicyNo";
            inputparameter1.DbType = DbType.String;
            inputparameter1.Size = 25;
            inputparameter1.Direction = ParameterDirection.Input;
            inputparameter1.Value = _polnum;

            command.Parameters.Add(inputparameter1);

            SqlParameter inputparameter2 = command.CreateParameter();
            inputparameter2.ParameterName = "@pMOP";
            inputparameter2.DbType = DbType.String;
            inputparameter2.Direction = ParameterDirection.Input;
            inputparameter2.Size = 1;
            inputparameter2.Value = _mop;
            command.Parameters.Add(inputparameter2);

            SqlParameter inputparameter3 = command.CreateParameter();
            inputparameter3.ParameterName = "@pPolicyEffDate";
            inputparameter3.DbType = DbType.Date;
            inputparameter3.Direction = ParameterDirection.Input;
            //            inputparameter3.Size = 5;
            inputparameter3.Value = Convert.ToDateTime(_effdate);
            command.Parameters.Add(inputparameter3);

            SqlParameter inputparameter8 = command.CreateParameter();
            inputparameter8.ParameterName = "@pCONTRIB";
            inputparameter8.DbType = DbType.Decimal;
            inputparameter8.Direction = ParameterDirection.Input;
            //inputparameter4.Size = 5;
            inputparameter8.Value = Convert.ToDecimal(_contrib);
            command.Parameters.Add(inputparameter8);

            SqlParameter inputparameter4 = command.CreateParameter();
            inputparameter4.ParameterName = "@pAmountPaid";
            inputparameter4.DbType = DbType.Decimal;
            inputparameter4.Direction = ParameterDirection.Input;
            //inputparameter4.Size = 5;
            inputparameter4.Value = Convert.ToDecimal(_amtpaid);
            command.Parameters.Add(inputparameter4);

            SqlParameter inputparameter5 = command.CreateParameter();
            inputparameter5.ParameterName = "@Param1";
            inputparameter5.DbType = DbType.String;
            inputparameter5.Size = 100;
            inputparameter5.Direction = ParameterDirection.Input;
            inputparameter5.Value = null;
            command.Parameters.Add(inputparameter5);

            SqlParameter inputparameter6 = command.CreateParameter();
            inputparameter6.ParameterName = "@Param2";
            inputparameter6.DbType = DbType.String;
            inputparameter6.Direction = ParameterDirection.Input;
            inputparameter6.Size = 100;
            inputparameter6.Value = null;
            command.Parameters.Add(inputparameter6);

            SqlParameter inputparameter7 = command.CreateParameter();
            inputparameter7.ParameterName = "@Param3";
            inputparameter7.DbType = DbType.String;
            inputparameter7.Size = 100;
            inputparameter7.Direction = ParameterDirection.Input;
            command.Parameters.Add(inputparameter7);

            SqlParameter returnparameter = command.CreateParameter();
            returnparameter.ParameterName = "@RETURN_VALUE";
            returnparameter.DbType = DbType.String;
            returnparameter.Direction = ParameterDirection.ReturnValue;
            command.Parameters.Add(returnparameter);

            session.Transaction.Commit();
            return GetDataSet(" ", command).GetXml();
        }


    }
}
