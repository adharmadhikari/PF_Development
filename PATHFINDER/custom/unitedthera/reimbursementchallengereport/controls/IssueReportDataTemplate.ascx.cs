using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Pinsonault.Data.Reports;

public partial class custom_unitedthera_reimbursementchallengereport_controls_IssueReportDataTemplate : System.Web.UI.UserControl
{
    public RadGrid HostedGrid
    {
        get { return gridIssueSummaryReport; }
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
    }

    protected void gridIssueSummaryReport_PreRender(object sender, EventArgs e)
    {
        foreach (Telerik.Web.UI.GridDataItem item in gridIssueSummaryReport.MasterTableView.Items)
        {
            System.Web.UI.WebControls.TableCell c = item["Issue_Name"];

            int num;
            bool isNum = int.TryParse(c.Text, out num);

            if (isNum)
            {
                c.BackColor = ReportColors.CustomerContactReports.GetColor(num - 1);
                c.Text = "";
            }
        }
    }
}