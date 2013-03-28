using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;
using System.Text;

public class TimelineInfo
{
    public DateTime StartDate;
    public DateTime EndDate
    {
        get { return StartDate.AddMonths(Duration); }
    }
    public int Duration;
    public int CampaignID;
    public string CampaignName;
}

public partial class admintimelines : System.Web.UI.Page
{
    protected void OnSelectingTimelines(object sender, SqlDataSourceSelectingEventArgs args)
    {
        //must correct value automatically added since we are appending extra data to list items
        string val = rcbAccountExec.SelectedValue;

        if ( !string.IsNullOrEmpty(val) )
        {
            string[] vals = val.Split('|');
            ((SqlParameterCollection)args.Command.Parameters)["@territory"].Value = vals[0];
        }
        else
            args.Cancel = true;
    }

    protected bool EditMode
    {
        get
        {
            object mode = ViewState["editMode"];
            if ( mode != null )
                return (bool)mode;

            return false;
        }
        set { ViewState["editMode"] = value; }
    }

    protected void OnCancelEdit(object sender, EventArgs args)
    {
        EditMode = false;
        radGrid.DataBind();
    }

    protected void OnEditTimelines(object sender, EventArgs args)
    {
        EditMode = true;
        radGrid.DataBind();
    }

    protected void OnSaveTimelines(object sender, EventArgs args)
    {
        EditMode = false;

        StringBuilder sb = new StringBuilder();

        SqlConnection cn = null;
        SqlCommand cmd = null;
        SqlTransaction tran = null;
        try
        {
            RadComboBox rcbDuration;
            TextBox txtStartDate;
            TimelineInfo timelineInfo;
            
            cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
            cn.Open();
            tran = cn.BeginTransaction();
            cmd = new SqlCommand("usp_Campaign_UpdateTimeline", cn, tran);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            foreach ( GridDataItem item in radGrid.Items )
            {
                
                rcbDuration = item.FindControl("dlDuration") as RadComboBox;
                txtStartDate = item.FindControl("txtStartDate") as TextBox;

                timelineInfo = new TimelineInfo
                {
                    CampaignID = (int)item.GetDataKeyValue("Campaign_ID"),
                    CampaignName = item.GetDataKeyValue("Campaign_Name") as string,
                    Duration = Convert.ToInt32(rcbDuration.SelectedValue),
                    StartDate = Convert.ToDateTime(txtStartDate.Text)
                };

                cmd.Parameters.Clear();

                cmd.Parameters.AddWithValue("@Campaign_ID", timelineInfo.CampaignID);
                cmd.Parameters.AddWithValue("@Start_Date", timelineInfo.StartDate);
                cmd.Parameters.AddWithValue("@Campaign_Duration", timelineInfo.Duration);
                cmd.Parameters.AddWithValue("@userName", Impact.User.FullName);
                cmd.Parameters.AddWithValue("@isAdmin", true);

                if ( cmd.ExecuteNonQuery() > 0 )
                {
                    sb.AppendFormat("The timeline for campaign {0}-{1} has been modified by the system administrator.  Start Date: {2:d} - End Date:{3:d}\n\n", timelineInfo.CampaignID, timelineInfo.CampaignName, timelineInfo.StartDate, timelineInfo.EndDate);
                }
            }

            tran.Commit();

            cn.Close();
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
            Impact.Utility.Utility.SendEMail(vals[1], Impact.User.Email, "PowerPlanRx - Campaign Timeline Updates", sb.ToString(), System.Net.Mail.MailPriority.High);
        }

        radGrid.DataBind();
    }

    //void sendNotifications(string email, List<TimelineInfo> list)
    //{
    //    foreach ( TimelineInfo item in list )
    //    {            
    //        Impact.Utility.Utility.SendEMail(email, Impact.User.Email, , System.Net.Mail.MailPriority.High);
    //    }
    //}

    protected override void OnPreRender(EventArgs e)
    {
        btnEditPlans.Visible = !EditMode;
        btnSavePlans.Visible = EditMode;
        btnCancel.Visible = EditMode;

        base.OnPreRender(e);
    }
}
