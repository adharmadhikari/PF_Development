﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_PlanInfoAddress : System.Web.UI.UserControl
{
    public bool ShowSectionDisclaimer { get; set; }

    public controls_PlanInfoAddress()
    {
        ShowSectionDisclaimer = true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}