﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class custom_controls_MeetingTypeDrillDown : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gridMeetingTypeDrillDown.ClientSettings.DataBinding.Location = "~/custom/" + Pinsonault.Web.Session.ClientKey + "/customercontactreports/services/GSKDataService.svc";
    }
}
