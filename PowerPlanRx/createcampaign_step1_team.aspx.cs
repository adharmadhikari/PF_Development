using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Impact.Campaign;
using Impact.Utility;
using System.Net.Mail;
using Telerik.Web.UI;

public partial class createcampaign_step1_team : System.Web.UI.Page , IEditPage
{
    /// <summary>
    /// Check if the user is the AE for the campaign, if so make Campaign Team email button visible and show the Edit button
    /// Initialize the alerts as not visible 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        
        btnEmailTeam.Visible = ((MasterPage)Master).CanEdit;
        pnlTeamAlert.Visible = false;
        //pnlAdHocAlert.Visible = false;
        if(!Page.IsPostBack &&
            ((MasterPage)Master).CanEdit )
            Edit();
    }

    /// <summary>
    /// Used to add a new campaign team member from the drop down lists which show the RBD, RSM and RFT and the employee names
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    
    protected void btnAddToTeam_Click(object sender, EventArgs e)
    {
        int functionSelected = ((RadComboBox)frmCampaignTeam.FindControl("drpFunctionArea")).SelectedIndex;
        string territoryID = ((RadComboBox)frmCampaignTeam.FindControl("drpEmpName")).SelectedItem.Value;
        int campaignID = System.Convert.ToInt32(Request.QueryString["id"]);
        int userID = Impact.User.PinsoUserID;

        if ((functionSelected == 0) || (territoryID == "-- Select an Employee Name --"))
        {
            pnlTeamAlert.Visible = true;
            //pnlAdHocAlert.Visible = false;
            ((RadComboBox)frmAdHoc.FindControl("drpAdHocFunctionArea")).SelectedIndex = 0;
            ((TextBox)frmAdHoc.FindControl("txtName")).Text = "";
            ((TextBox)frmAdHoc.FindControl("txtEmail")).Text = "";
            ((TextBox)frmAdHoc.FindControl("txtPhone")).Text = "";
        }
        else
        {
            Campaign.UpdateCampaignTeam(campaignID, territoryID, userID);
            ((RadComboBox)frmCampaignTeam.FindControl("drpFunctionArea")).SelectedIndex = 0;
            ((RadComboBox)frmCampaignTeam.FindControl("drpEmpName")).SelectedIndex = 0;
            pnlTeamAlert.Visible = false;
            grvCampaignTeam.DataBind();
        }
    }

    /// <summary>
    /// Used to add an Ad Hoc campaign team member that the user will manually enter
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    
    protected void btnAddAdHoc_Click(object sender, EventArgs e)
    {
        string adHocTitleID = ((RadComboBox)frmAdHoc.FindControl("drpAdHocFunctionArea")).SelectedItem.Value;
        int titleID = System.Convert.ToInt32(adHocTitleID);
        int campaignID = System.Convert.ToInt32(Request.QueryString["id"]);
        string adHocName = ((TextBox)frmAdHoc.FindControl("txtName")).Text;
        string adHocEmail = ((TextBox)frmAdHoc.FindControl("txtEmail")).Text;
        string adHocPhone = ((TextBox)frmAdHoc.FindControl("txtPhone")).Text;
        int userID = Impact.User.PinsoUserID;

        if ((titleID == 0) || (adHocName == " ") || (adHocEmail == " ") || (adHocPhone == " "))
        {
            //pnlAdHocAlert.Visible = true;
            pnlTeamAlert.Visible = false;
            ((RadComboBox)frmCampaignTeam.FindControl("drpFunctionArea")).SelectedIndex = 0;
            ((RadComboBox)frmCampaignTeam.FindControl("drpEmpName")).SelectedIndex = 0;
        }
        else
        {
            Campaign.UpdateAdHocCampaignTeam(campaignID, adHocName, titleID, adHocEmail, adHocPhone, userID);
            ((RadComboBox)frmAdHoc.FindControl("drpAdHocFunctionArea")).SelectedIndex = 0;

            //pnlAdHocAlert.Visible = false;
            grvCampaignTeam.DataBind();
            grvAdHocCampaign.DataBind();
        }        

    }

    /// <summary>
    /// Used to populate the employee name drop down according to the function area selected
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    
    protected void OnFunctionAreaChanged(object sender, EventArgs e)
    {
        RadComboBox emplist = frmCampaignTeam.FindControl("drpEmpName") as RadComboBox;
        emplist.Items.Clear();
        RadComboBoxItem empname = new RadComboBoxItem();
        empname.Text = "-- Select an Employee Name --";
        emplist.Items.Add(empname);
    }
    
    /// <summary>
    /// Redirects to the page to create and send an email for a campaign team meeting
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
   
    protected void btnEmailTeam_Click(object sender, EventArgs e)
    {
        string redirectURL = "email_campaign_team.aspx?id=" + Request.QueryString["id"];

        Response.Redirect(redirectURL);
    }

    protected override void OnPreRender(EventArgs e)
    {
        ((TextBox)frmAdHoc.FindControl("txtName")).Text = "";
        ((TextBox)frmAdHoc.FindControl("txtEmail")).Text = "";
        ((TextBox)frmAdHoc.FindControl("txtPhone")).Text = "";

        base.OnPreRender(e);
    }
    /// <summary>
    /// Used to hide the delete button if the member is an AE, AD or DBM
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
 
    //protected void grvCampaignTeam_RowDataBound(Object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        if (e.Row.Cells[5].Text == "13" || e.Row.Cells[5].Text == "16" || e.Row.Cells[5].Text == "20")
    //        {
    //            e.Row.Cells[4].Text = " ";
    //        }            
    //    }
    //}


    #region IEditPage Members

    public bool Save()
    {
        if ((grvCampaignTeam.Rows.Count > 0) || (grvAdHocCampaign.Rows.Count > 0))
        {
            // if 1st time Submit, update the Phase ID = 5;  else keep the Phase ID 
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("update Campaign_Info set Phase_ID = case when Phase_ID > 5 then Phase_ID else 5 end where Campaign_ID = @Campaign_ID", cn))
                {
                    cmd.Parameters.AddWithValue("@Campaign_ID", Convert.ToInt32(Request.QueryString["id"]));
                    cn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        //frmCampaignTeam.Visible = false;
        //frmAdHoc.Visible = false;
        //grvCampaignTeam.Columns[4].Visible = false;
        //grvAdHocCampaign.Columns[6].Visible = false;
        grvCampaignTeam.DataBind();
        grvAdHocCampaign.DataBind();
        return true;
    }

    public void Reset()
    {
        
        //pnlAdHocAlert.Visible = false;
        pnlTeamAlert.Visible = false;
        frmCampaignTeam.Visible = false;
        frmAdHoc.Visible = false;
        grvCampaignTeam.DataBind();
        grvCampaignTeam.Columns[5].Visible = false;
        grvAdHocCampaign.Columns[6].Visible = false;
        ((RadComboBox)frmCampaignTeam.FindControl("drpFunctionArea")).SelectedIndex = 0;
        ((RadComboBox)frmCampaignTeam.FindControl("drpEmpName")).SelectedIndex = 0;
        ((RadComboBox)frmAdHoc.FindControl("drpAdHocFunctionArea")).SelectedIndex = 0;
        ((TextBox)frmAdHoc.FindControl("txtName")).Text = "";
        ((TextBox)frmAdHoc.FindControl("txtEmail")).Text = "";
        ((TextBox)frmAdHoc.FindControl("txtPhone")).Text = "";
    }

    public void Edit()
    {
        //pnlAdHocAlert.Visible = false;
        pnlTeamAlert.Visible = false;
        frmCampaignTeam.Visible = true;
        frmAdHoc.Visible = true;
        //grvCampaignTeam.DataBind();
        //((RadComboBox)frmCampaignTeam.FindControl("drpFunctionArea")).SelectedIndex = 0;
        //((RadComboBox)frmCampaignTeam.FindControl("drpEmpName")).SelectedIndex = 0;
        //((RadComboBox)frmAdHoc.FindControl("drpAdHocFunctionArea")).SelectedIndex = 0;
        //((TextBox)frmAdHoc.FindControl("txtName")).Text = "";
        //((TextBox)frmAdHoc.FindControl("txtEmail")).Text = "";
        //((TextBox)frmAdHoc.FindControl("txtPhone")).Text = "";        
        
        grvCampaignTeam.Columns[5].Visible = true;
        grvAdHocCampaign.Columns[6].Visible = true;
       
    }

    #endregion

   
}
