﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class custom_controls_FilterMeetingOctcome : System.Web.UI.UserControl
{
    protected override void OnInit(EventArgs e)
    {
        dsOutcome.ConnectionString = Pinsonault.Web.Session.ClientConnectionString;

        base.OnInit(e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
