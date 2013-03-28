using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class signout : System.Web.UI.Page
{
    protected override void OnLoad(EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session.Abandon();

        //////Response.Redirect("~");

        base.OnLoad(e);
    }
}
