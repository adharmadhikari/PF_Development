﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class custom_pinso_customercontactreports_all_customercontactreport : PageBase
{
    protected override void OnError(EventArgs e)
    {
        base.OnError(e);
    }
    protected override void OnLoad(EventArgs e)
    {
        lblUserID.Text = Pinsonault.Web.Session.UserID.ToString();
        lblRoleID.Text = HttpContext.Current.User.IsInRole("admin").ToString();
            //Pinsonault.Web.Session.Admin.ToString();
        base.OnLoad(e);
    }
}
