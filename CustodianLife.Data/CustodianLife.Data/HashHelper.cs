using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.Security.Cryptography;
using System.Globalization;


namespace CustodianLife.Data
{
    public class hashHelper
    {
        public static string CreateSalt(int size)
        {
            // Generate a cryptographic random number using the cryptographic
            // service provider
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] buff = new byte[size];
            rng.GetBytes(buff);
            // Return a Base64 string representation of the random number
            return Convert.ToBase64String(buff);
        }

        public static string CreatePasswordHash(string pwd, string salt)
        {
            string saltAndPwd = String.Concat(pwd, salt);
            string hashedPwd =
                  FormsAuthentication.HashPasswordForStoringInConfigFile(
                                                       saltAndPwd, "SHA1");
            return hashedPwd;
        }


        //public static bool VerifyPassword(Object _user, string suppliedPassword, string objType)
        //{
        //    bool passwordMatch = false;
        //    // Get the salt and pwd from the database based on the user name.
        //    string dbPasswordHash = String.Empty;
        //    string salt = String.Empty;
        //    //objMembersCred memCred;
        //    //objUserCredentials userCred;
        ////    switch (objType)
        //    {
        //        case "member":
        //            memCred = (objMembersCred)_user;
        //            dbPasswordHash = memCred.PassWordHash;
        //            salt = memCred.Salt;
        //            break;
        //        case "admin":
        //            userCred = (objUserCredentials)_user;
        //            dbPasswordHash = userCred.PassWordHash;
        //            salt = userCred.Salt;
        //            break;

        //    }
        //    try
        //    {
        //        // Now take the salt and the password entered by the user
        //        // and concatenate them together.
        //        string passwordAndSalt = String.Concat(suppliedPassword, salt);
        //        // Now hash them
        //        string hashedPasswordAndSalt =
        //                   FormsAuthentication.HashPasswordForStoringInConfigFile(
        //                                                   passwordAndSalt, "SHA1");
        //        // Now verify them.
        //        passwordMatch = hashedPasswordAndSalt.Equals(dbPasswordHash);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception("ERROR verifying password: " + ex.Message);
        //    }
        //    finally
        //    {
        //    }
        //    return passwordMatch;
        //}

        public static DateTime GoodDate(string yr, string mth, string dy)
        {
            string strDte = yr + "/" + mth + "/" + dy;
            return checkDate(strDte);
        }
        public static DateTime GoodDate(string mydate)
        {
            return moveDateToCulture(mydate);
        }

        private static DateTime checkDate(string dte)
        {
            string pattern = "dd/MM/yyyy";
            DateTime myDate = DateTime.Today;
            try
            {
               // myDate = Convert.ToDateTime(dte);
                //IFormatProvider provider = new System.Globalization.CultureInfo("en-GB", true);
               // myDate = DateTime.ParseExact(dte, pattern, provider);
                myDate = Convert.ToDateTime(dte);
                //string strDate = moveDateToCulture(dte);

                
            }
            catch (Exception c)
            {
                throw new Exception("Invalid Date!");
            }
            return myDate;

        }

        public static string removeDateSeperators(DateTime dte)
        {
            string dy = dte.Day.ToString();
            string myday = dte.Day.ToString();
            string mt = dte.Month.ToString();
            string mth = dte.Month.ToString();
            if (mt.Length == 1)
                mth = "0" + mt;
            if (dy.Length == 1)
                myday = "0" + dy;

            string ky = dte.Year.ToString() + mth + myday;
            return ky;
        }

        public static DateTime moveDateToCulture(String dte)
        {
            //change date from dd/mm/yyyy to mm/dd/yyyy to achieve consonance with the server.
            //It seems that settings from the c# dll calls for date format is changed when it gets to VB.net client. 
            //This is still subject to research before final conclusion though.
            string[] dateparts = dte.Split('/');
            Int16 dy =Convert.ToInt16( dateparts[0]);
            Int16 mt = Convert.ToInt16( dateparts[1]);
            Int16 ky  = Convert.ToInt16( dateparts[2]);
            System.DateTime dateInMay = new System.DateTime(ky, mt, dy, 0, 0, 0);
            //String myDate = mt + "/" + dy + "/" + ky;
            return dateInMay;
        }
 
        public static Double RealNumberNoSpaces(string str)
        {
            if (str == "")
                return 0;
            return Math.Round(Convert.ToDouble(str), 2);

        }
        public static DateTime RealDateNoSpaces(string str)
        {
            if (str == "")
                return DateTime.Now;
            return Convert.ToDateTime(str);

        }

    }
}
