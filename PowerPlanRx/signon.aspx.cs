using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Web.Security;

public partial class signon : System.Web.UI.Page
{
    protected override void OnLoad(EventArgs e)
    {
        string hash = Request["Hash_Value"];
        string timeStamp = Request["Encrypted_TS"];

        if ( !string.IsNullOrEmpty(hash) && !string.IsNullOrEmpty(timeStamp) )
        {
            if ( Membership.Provider.ValidateUser(hash, timeStamp) )
            {
                Response.Cookies.Add(FormsAuthentication.GetAuthCookie(hash, false));

                Response.Redirect("~/home.aspx");
            }
            
            
        }
        base.OnLoad(e);
    }
}
