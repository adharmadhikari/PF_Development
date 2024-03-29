﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using PathfinderClientModel;
using Pinsonault.Web;
using System.IO;
using Telerik.Web.UI;
using Pinsonault.Data.Reports;


public partial class custom_millennium_customercontactreports_controls_ccrMeetingActivityDataTemplate : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // base.OnLoad(e);
    }
    
    //public override Telerik.Web.UI.RadGrid HostedGrid
    public Telerik.Web.UI.RadGrid HostedGrid
    {
        get { return gridCcrMeetingActivity; }
    }

    protected void gridCcrMeetingActivity_PreRender(object sender, EventArgs e)
    {
        foreach (Telerik.Web.UI.GridDataItem item in gridCcrMeetingActivity.MasterTableView.Items)
        {
            System.Web.UI.WebControls.TableCell c = item["Meeting_Activity_ID"];

            int num;
            bool isNum = int.TryParse(c.Text, out num);

            if (isNum)
            {
                c.BackColor = ReportColors.CustomerContactReports.GetColor(num - 1);
                c.Text = "";
            }
            //item.Cells[2].BackColor = System.Drawing.Color.Orange;
        }
    }
}
