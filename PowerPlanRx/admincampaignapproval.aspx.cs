using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class admincampaignapproval : System.Web.UI.Page
{

    protected void OnSelectingCampaigns(object sender, SqlDataSourceSelectingEventArgs args)
    {

        //must correct value automatically added since we are appending extra data to the list.
        string val = rcbAccountExec.SelectedValue;

        if ( !string.IsNullOrEmpty(val) )
        {
            string[] vals = val.Split('|');
            ((SqlParameterCollection)args.Command.Parameters)["@territory"].Value = vals[0];
        }
        else
            args.Cancel = true;
    }

    protected void OnApproveCampaign(object sender, CommandEventArgs args)
    {
        string[] campaignArgs = args.CommandArgument.ToString().Split('|');
        int id = Convert.ToInt32(campaignArgs[0]);
        string name = campaignArgs[1];

        StringBuilder sb = new StringBuilder();

        SqlConnection cn = null;
        SqlCommand cmd = null;
        SqlTransaction tran = null;

        try
        {
            cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
            cn.Open();
            tran = cn.BeginTransaction();
            cmd = new SqlCommand("usp_Update_Team_Approval_Status", cn, tran);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Campaign_ID", id);            
            cmd.Parameters.AddWithValue("@IsAdmin", true);
            cmd.Parameters.AddWithValue("@userName", Impact.User.FullName);

            sb.AppendLine(string.Format("The campaign {0}-{1} has been approved by the administrator.", id, name));

            cmd.ExecuteNonQuery();

            tran.Commit();
        }
        catch ( Exception ex )
        {
            if ( tran != null )
                tran.Rollback();

            throw ex;
        }
        finally
        {
            if ( tran != null ) tran.Dispose();
            if ( cmd != null ) cmd.Dispose();
            if ( cn != null ) cn.Dispose();
        }

        //once database changes have been committed send notifications
        if ( sb.Length > 0 )
        {
            string[] vals = rcbAccountExec.SelectedValue.Split('|');
            Impact.Utility.Utility.SendEMail(vals[1], Impact.User.Email, "PowerPlanRx - Campaign Approved", sb.ToString(), System.Net.Mail.MailPriority.High);
        }

        radGrid.DataBind();

    }
}
