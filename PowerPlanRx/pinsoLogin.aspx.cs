using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Security;
using System.Configuration;
using System.Web.Services;
using System.Security.Cryptography;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    protected override void OnLoad(EventArgs e)
    {
        HttpContext.Current.Response.AddHeader("p3p", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");

        if ( !Page.IsPostBack )
        {
            string name = getUserNameCookieVal();

            TextBox textBox = (TextBox)login1.FindControl("UserName");
            if ( !string.IsNullOrEmpty(name) )
            {
                textBox.Text = name;
                textBox.ReadOnly = !string.IsNullOrEmpty(textBox.Text);
                textBox.CssClass = "textBoxReadOnly";
            }
            else
            {
                textBox.Text = "";
                textBox.ReadOnly = false;
                textBox.CssClass = "textBox";
            }
        }

        login1.LoggedIn += new EventHandler(OnLoggedIn);
        
        base.OnLoad(e);
    }

    void OnLoggedIn(object sender, EventArgs e)
    {
        HttpCookie cookie = new HttpCookie("u", FormsAuthentication.Encrypt(new FormsAuthenticationTicket(login1.UserName, true, 0)));
        cookie.Expires = DateTime.MaxValue;
        Response.Cookies.Add(cookie);
    }

    string getUserNameCookieVal()
    {
        HttpCookie cookie = Request.Cookies["u"];
        if ( cookie != null )
        {
            try
            {
                return FormsAuthentication.Decrypt(cookie.Value).Name;
            }
            catch //In case of error reset to basic configuration
            {
            }
        }

        return null;
    }

    [WebMethod]
    public static bool SubmitEmail(string Email)
    {
        string email = Email;
        if ( email != null )        
            email = email.Trim();
        

        if ( !string.IsNullOrEmpty(email) )
        {

            string firstName = null;
            string lastName = null;
            bool found = false;
            using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
            {
                using ( SqlCommand cmd = new SqlCommand("select top 1 User_F_Name, User_L_Name from User_Mast where Email = @email", cn) )
                {
                    cmd.Parameters.AddWithValue("@email", email);
                    cn.Open();
                    using ( SqlDataReader rdr = cmd.ExecuteReader() )
                    {
                        if ( rdr.Read() )
                        {
                            firstName = rdr.GetString(0);
                            lastName = rdr.GetString(1);
                            found = true;
                        }
                    }
                }
            }

            if ( found )
            {
                string body = string.Format(Resources.Resource.ForgotPassword_MessageFormat,
                                                    firstName, lastName, "Novo-Impact", email);

                return SendEmail(ConfigurationManager.AppSettings["AdminEmail"], ConfigurationManager.AppSettings["CustomerSupportEmail"], Resources.Resource.ForgotPassword_MessageSubject, body, false);
            }
        }
        return false;
    }

    /// <summary>
    /// Simple helper function for sending SMTP email messages.
    /// </summary>
    /// <param name="From">The email address that the message is being sent from.</param>
    /// <param name="To">The email address of the recipient(s).  Multiple addresses should be separated by commas.</param>
    /// <param name="Subject">Subject of the message.</param>
    /// <param name="Body">Body of the message.</param>
    /// <param name="IsHTML">Indicates if the body of the message contains HTML markup.</param>
    /// <returns></returns>
    public static bool SendEmail(string From, string To, string Subject, string Body, bool IsHTML)
    {
        try
        {

            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(ConfigurationManager.AppSettings["SmtpHost"]);
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage(From, To, Subject, Body);
            msg.IsBodyHtml = IsHTML;
            smtp.Send(msg);
            return true;
        }
        catch
        {
            return false;
        }
    }
}
