using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace Impact
{
    /// <summary>
    /// Summary description for User
    /// </summary>
    public static class User
    {
        public static int PinsoUserID
        {
            get { return GetSessionValue<int>("pinsoUserID"); }
        }

        public static string FullName
        {
            get { return GetSessionValue<string>("fullName"); }
        }

        public static string TerritoryID
        {
            get { return GetSessionValue<string>("territoryID"); }
        }

        public static string Email
        {
            get { return GetSessionValue<string>("email"); }
        }

        //public static string DistrictID
        //{
        //    get { return GetSessionValue<string>("districtID"); }
        //}

        //public static string RegionID
        //{
        //    get { return GetSessionValue<string>("regionID"); }
        //}

        public static int TitleID
        {
            get { return UserTitle.CurrentTitleID; }
        }

        public static bool HasApprovalStatus
        {
            get { return UserTitle.CurrentUserCanApprove; }
        }

        public static bool IsSAE
        {
            get { return UserTitle.CurrentUserIsSAE; }
        }

        public static bool IsAccountExecutive
        {
            get { return UserTitle.CurrentUserIsAccountExecutive; }
        }

        public static bool IsAdmin
        {
            get { return UserTitle.CurrentUserIsAdmin; }
        }

        public static UserTitle Title
        {
            get { return UserTitle.CurrentTitle; }
        }

        /// <summary>
        /// Returns a value from the current Session
        /// </summary>
        /// <typeparam name="T">Return type of the Session value.</typeparam>
        /// <param name="Name">Name of the value to return.</param>
        /// <returns>Returns the value stored in session cast to the specified return type.  If the value is not found the default for the type is returned.</returns>
        public static T GetSessionValue<T>(string Name)
        {
            object value = HttpContext.Current.Session[Name];
            if ( value != null )
                return (T)value;
            else
                return default(T);
        }

        public static void CheckSession()
        {
            HttpContext.Current.Session["NovoUserID"] = HttpContext.Current.User.Identity.Name;

            string firstName = HttpContext.Current.Session["firstName"] as string;
            if ( string.IsNullOrEmpty(firstName) )
            {
                //recover session variables - Other than Novo_User_ID (which is same as HttpContext.Current.User.Identity.Name)
                using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
                {
                    using ( SqlCommand cmd = new SqlCommand("usp_GetCurrentUserInfo", cn) )
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@id", HttpContext.Current.User.Identity.Name);

                        cn.Open();

                        using ( SqlDataReader rdr = cmd.ExecuteReader() )
                        {
                            if ( rdr.Read() )
                            {
                                HttpContext.Current.Session["firstName"] = rdr.GetString(1);
                                HttpContext.Current.Session["fullName"] = rdr.GetString(5);
                                HttpContext.Current.Session["email"] = rdr.GetString(6);
                                if ( rdr.GetInt32(0) == 1 )
                                {
                                    HttpContext.Current.Session["titleID"] = rdr.GetInt32(2);
                                    HttpContext.Current.Session["territoryID"] = rdr.GetString(3);
                                    HttpContext.Current.Session["pinsoUserID"] = rdr.GetInt32(4);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}