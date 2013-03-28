using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.IO;


public class NovoMembership : MembershipProvider
{
    #region NotImplemented
    public override string ApplicationName
    {
        get
        {
            throw new NotImplementedException();
        }
        set
        {
            throw new NotImplementedException();
        }
    }

    public override bool ChangePassword(string username, string oldPassword, string newPassword)
    {
        throw new NotImplementedException();
    }

    public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
    {
        throw new NotImplementedException();
    }

    public override bool DeleteUser(string username, bool deleteAllRelatedData)
    {
        throw new NotImplementedException();
    }

    public override bool EnablePasswordReset
    {
        get { throw new NotImplementedException(); }
    }

    public override bool EnablePasswordRetrieval
    {
        get { throw new NotImplementedException(); }
    }

    public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override int GetNumberOfUsersOnline()
    {
        throw new NotImplementedException();
    }

    public override string GetPassword(string username, string answer)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser GetUser(string username, bool userIsOnline)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
    {
        throw new NotImplementedException();
    }

    public override string GetUserNameByEmail(string email)
    {
        throw new NotImplementedException();
    }

    public override int MaxInvalidPasswordAttempts
    {
        get { throw new NotImplementedException(); }
    }

    public override int MinRequiredNonAlphanumericCharacters
    {
        get { throw new NotImplementedException(); }
    }

    public override int MinRequiredPasswordLength
    {
        get { throw new NotImplementedException(); }
    }

    public override int PasswordAttemptWindow
    {
        get { throw new NotImplementedException(); }
    }

    public override MembershipPasswordFormat PasswordFormat
    {
        get { throw new NotImplementedException(); }
    }

    public override string PasswordStrengthRegularExpression
    {
        get { throw new NotImplementedException(); }
    }

    public override bool RequiresQuestionAndAnswer
    {
        get { throw new NotImplementedException(); }
    }

    public override bool RequiresUniqueEmail
    {
        get { throw new NotImplementedException(); }
    }

    public override string ResetPassword(string username, string answer)
    {
        throw new NotImplementedException();
    }

    public override bool UnlockUser(string userName)
    {
        throw new NotImplementedException();
    }

    public override void UpdateUser(MembershipUser user)
    {
        throw new NotImplementedException();
    }
    #endregion

    public override bool ValidateUser(string hash, string timeStamp)
    {
        bool authenticated = false;
        Aes aes = AesManaged.Create();

        aes.Padding = PaddingMode.None;
        aes.Mode = CipherMode.CBC;

        using ( ICryptoTransform transform = aes.CreateDecryptor(new byte[] { 187, 162, 250, 42, 40, 101, 46, 37, 149, 46, 30, 168, 208, 69, 196, 68 }, new byte[] { 164, 194, 100, 212, 125, 58, 109, 198, 155, 111, 25, 175, 199, 69, 101, 122 }) )
        {
            byte[] input = Convert.FromBase64String(timeStamp);
            byte[] buffer = new byte[transform.InputBlockSize];


            using ( MemoryStream ms = new MemoryStream() )
            {
                int i = 0;
                while ( transform.InputBlockSize < input.Length - i )
                {
                    i += transform.TransformBlock(input, i, transform.InputBlockSize, buffer, 0);
                    ms.Write(buffer, 0, buffer.Length);
                }
                ms.Write(transform.TransformFinalBlock(input, i, transform.InputBlockSize), 0, transform.InputBlockSize);


                string decryptedTimeStamp = UTF8Encoding.UTF8.GetString(ms.ToArray()).Trim();
                DateTime novoTimeStamp = DateTime.MinValue;
                if ( DateTime.TryParse(decryptedTimeStamp, out novoTimeStamp) )
                {
                    if ( DateTime.Now.Subtract(novoTimeStamp).TotalMinutes < 5 )
                    {
                        authenticated = MembershipUtil.Authenticate("usp_ValidateUserByHash", hash, null);
                    }
                }
            }                
        }

        return authenticated;
    }
}

/// <summary>
/// Summary description for NovoMembership
/// </summary>
public class StandardMembershipProvider : MembershipProvider
{
    #region NotImplemented
    public override string ApplicationName
    {
        get
        {
            throw new NotImplementedException();
        }
        set
        {
            throw new NotImplementedException();
        }
    }

    public override bool ChangePassword(string username, string oldPassword, string newPassword)
    {
        throw new NotImplementedException();
    }

    public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
    {
        throw new NotImplementedException();
    }

    public override bool DeleteUser(string username, bool deleteAllRelatedData)
    {
        throw new NotImplementedException();
    }

    public override bool EnablePasswordReset
    {
        get { throw new NotImplementedException(); }
    }

    public override bool EnablePasswordRetrieval
    {
        get { throw new NotImplementedException(); }
    }

    public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
    {
        throw new NotImplementedException();
    }

    public override int GetNumberOfUsersOnline()
    {
        throw new NotImplementedException();
    }

    public override string GetPassword(string username, string answer)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser GetUser(string username, bool userIsOnline)
    {
        throw new NotImplementedException();
    }

    public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
    {
        throw new NotImplementedException();
    }

    public override string GetUserNameByEmail(string email)
    {
        throw new NotImplementedException();
    }

    public override int MaxInvalidPasswordAttempts
    {
        get { throw new NotImplementedException(); }
    }

    public override int MinRequiredNonAlphanumericCharacters
    {
        get { throw new NotImplementedException(); }
    }

    public override int MinRequiredPasswordLength
    {
        get { throw new NotImplementedException(); }
    }

    public override int PasswordAttemptWindow
    {
        get { throw new NotImplementedException(); }
    }

    public override MembershipPasswordFormat PasswordFormat
    {
        get { throw new NotImplementedException(); }
    }

    public override string PasswordStrengthRegularExpression
    {
        get { throw new NotImplementedException(); }
    }

    public override bool RequiresQuestionAndAnswer
    {
        get { throw new NotImplementedException(); }
    }

    public override bool RequiresUniqueEmail
    {
        get { throw new NotImplementedException(); }
    }

    public override string ResetPassword(string username, string answer)
    {
        throw new NotImplementedException();
    }

    public override bool UnlockUser(string userName)
    {
        throw new NotImplementedException();
    }  

    public override void UpdateUser(MembershipUser user)
    {
        throw new NotImplementedException();
    }
    #endregion

    public override bool ValidateUser(string username, string password)
    {
        if ( string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) )
            throw new ArgumentNullException("Username and Password are required.");

        return MembershipUtil.Authenticate("usp_ValidateUserByName", username, password);
    }
}

public class MembershipUtil
{
    public static bool Authenticate(string command, string username, string password)
    {
        using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
        {
            using ( SqlCommand cmd = new SqlCommand(command, cn) )
            {
                cmd.Parameters.AddWithValue("@userName", username);
                if(!string.IsNullOrEmpty(password)) //single sign on does not require password
                    cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@ipaddress", HttpContext.Current.Request.UserHostAddress);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cn.Open();

                using ( SqlDataReader rdr = cmd.ExecuteReader() )
                {
                    if ( rdr.Read() )
                    {
                        int validRoles = rdr.GetInt32(0);
                        if ( validRoles > 0 )
                        {
                            //if only 1 role for user then assign title id session variable otherwise leave empty so user has to pick
                            if ( validRoles == 1 )
                            {
                                HttpContext.Current.Session["titleID"] = rdr.GetInt32(1);
                                HttpContext.Current.Session["territoryID"] = rdr.GetString(3);
                                HttpContext.Current.Session["pinsoUserID"] = rdr.GetInt32(4);
                                //HttpContext.Current.Session["districtID"] = rdr.GetString(5);
                                //HttpContext.Current.Session["regionID"] = rdr.GetString(6);
                            }

                            HttpContext.Current.Session["FirstName"] = rdr.GetString(2);
                            HttpContext.Current.Session["fullName"] = rdr.GetString(5);
                            HttpContext.Current.Session["email"] = rdr.GetString(6);

                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
}
