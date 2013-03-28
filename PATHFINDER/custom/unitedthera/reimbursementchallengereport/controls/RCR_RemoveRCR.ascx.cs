using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PathfinderClientModel;
using Pinsonault.Application.UnitedThera;
using System.IO;
using Pinsonault.Data;
using System.Linq.Expressions;

public partial class custom_unitedthera_reimbursementchallengereport_controls_RCR_RemoveRCR : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Msglbl.Visible = false;
    }
    protected void Yesbtn_Click(object sender, EventArgs e)
    {
        using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
        {

            if (DeleteRCR(System.Convert.ToInt32(Page.Request.QueryString["IRID"])))
            {
                this.Msglbl.Text = "<div>Selected Reimbursment Issue Report has been removed successfully.</div>";
                this.Msglbl.Visible = true;

                Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "RefreshRCR", "RefreshRCR();", true);
            }
        }
    }

    public bool DeleteRCR(int IRID)
    {
       
        if (IRID != null)
        {
            using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
            {
                 RCReports rcrView;
                 rcrView = context.RCReportsSet.FirstOrDefault(c => c.RC_Report_ID == IRID);
                 rcrView.Report_Status = false;
                 rcrView.Modified_DT = DateTime.UtcNow;
                 rcrView.Modified_BY = Pinsonault.Web.Session.FullName;
                 context.SaveChanges();
           
            }
            
            return true;
        }

        return false;
    }
}
