﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class todaysaccounts_managedmedicaid_PlanInfo : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToBoolean(Request.QueryString["showKeyContact"]) == false)
            keycontactsList.Visible = false;
    }
}
