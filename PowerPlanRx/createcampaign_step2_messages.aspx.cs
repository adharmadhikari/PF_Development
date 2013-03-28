using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Configuration;
using Pinsonault.Data;
using System.Data;
using System.Text;
using Telerik.Web.UI;
using Impact;
using Impact.Campaign;

public partial class createcampaign_step2_messages : System.Web.UI.Page, IEditPage
{
    int _phaseID;
    int _messageCount;
    int _campaignID;
    //string strCampaignName;

    protected void Page_Load(object sender, EventArgs e)
    {
        _phaseID = ((MasterPage)this.Master).PhaseID;
        hPhaseID.Value = _phaseID.ToString();

        divMsg.InnerHtml = "";
        divMsg.Visible = false;

        //check if CampaignID or id is not present in the querystring, redirect it back to previous page.
        if (string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            Response.Redirect(Request.ServerVariables["HTTP_REFERER"]);
        }
        else
        {
            _campaignID = Convert.ToInt32(Request.QueryString["id"]);
        }

        // previous step(_phaseID == 6 Tactics) has been completed & now Message begin (page should be in Edit mode)

        if (!Page.IsPostBack)
        {
            GetCampaignName();

            if (((MasterPage)this.Master).IsPageEditable && ((MasterPage)Master).CanEdit)
            {
                pnlReadOnly.Visible = false;
                pnlEdit.Visible = true;
            }
        }

        divCampaignName.InnerHtml = "Campaign Name: " + ViewState["CampaignName"];
        divCampaignName.Visible = true;
       


    }

    private void GetCampaignName()
    {
        // to get Campaign Name
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select Campaign_Name from campaign_info where Campaign_ID = @Campaign_ID", cn))
            {
                cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        ViewState["CampaignName"] = dr.GetString(0);
                    }
                }
                cn.Close();
            }
        }
    }

   
    #region IEditPage
    public bool Save()
    {
        if (Campaign.IsCampaignActive(System.Convert.ToInt32(Request.QueryString["id"])))
        {
            // validate: at least 1 Message must be selected
            int rowCount = rgMessage.MasterTableView.GetItems(new GridItemType[] { GridItemType.Item, GridItemType.AlternatingItem }).Length;

            if (rowCount > 0)
            {
                 // only if current Phase ID = 6, update Phase ID = 7
                if (_phaseID == 6)
                {
                    // if 1st time Submit, update the Phase ID = 6;  else keep the Phase ID 
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("update Campaign_Info set Phase_ID = 7 where Campaign_ID = @Campaign_ID", cn))
                        {
                            cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                            cn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                messages.MessageGrid.DataBind();
                pnlEdit.Visible = false;
                pnlReadOnly.Visible = true;

                return true;
            }

            else  // at least 1 Message must be selected
            {
                divMsg.InnerHtml = "Please select at least 1 Message!";
                divMsg.Visible = true;
                return false;
            }
        }

        return true;

    }

    public void Reset()
    {
        rgMessage.DataBind();
        rgMessageAdd.DataBind();
        
        messages.MessageGrid.DataBind();
        pnlEdit.Visible = false;
        pnlReadOnly.Visible = true;

    }

    public void Edit()
    {
        pnlEdit.Visible = true;
        pnlReadOnly.Visible = false;
    }

    #endregion


    /// <summary>
    /// Validation needed:
    /// After 1st time Submit Phase ID has already been changed to 7 in the 'Campaign_Info' table
    /// If Campaign Phase ID >=7  Then at least 1 message must be in the 'Campaign_Message_Details' table
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rgMessage_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        _messageCount = SelectedMessageCount(_campaignID);

        if (_phaseID >= (int)Impact.Campaign.PhaseID.Messages)  // means at least 1 Message is already saved (validation needed: can't remove all Message)
        {
            if (_messageCount > 1)   // if _tacticsCount = 1: can't remove the only 1 left selected tactic
            {
                DeleteIt(e);
            }
        }
        else    // delete last row available anytime if it 's before the 1st time submit
        {
            DeleteIt(e);
        }

    }

    private void DeleteIt(GridCommandEventArgs e)
    {
        int iMessageID;
        iMessageID = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Message_ID"].ToString());

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Campaign_Messages_SelectedList_Delete", cn))
            {
                cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                cmd.Parameters.AddWithValue("@Message_ID", iMessageID);
                cmd.CommandType = CommandType.StoredProcedure;

                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        rgMessageAdd.DataBind();
        rgMessage.DataBind();
        pnlEdit.Visible = true;
        pnlReadOnly.Visible = false;
    }


    public static int SelectedMessageCount(int _campaignID)
    {
        int _count = 0;
        // to count # of Message in the selected list
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select count(*) from dbo.Campaign_Message_Details where Campaign_ID = @Campaign_ID", cn))
            {
                cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                cn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        _count = dr.GetInt32(0);
                    }
                }
                cn.Close();

            }
        }
        return _count;
    }

    protected void rgMessage_CancelCommand(object sender, EventArgs e)
    {


    }

    protected void AddMessage(object sender, EventArgs e)
    {

         string strPinsoUserID = Session["pinsoUserID"].ToString();

            foreach (GridDataItem item in rgMessageAdd.MasterTableView.Items)
            {
                CheckBox chkMessage = (CheckBox)item.FindControl("chkMessage");
                if (chkMessage.Checked)
                {
                    int iMessageID = Convert.ToInt32(item.OwnerTableView.DataKeyValues[item.ItemIndex]["Message_ID"]);

                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateMessages", cn))
                        {
                            cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                            cmd.Parameters.AddWithValue("@Message_ID", iMessageID);
                            cmd.Parameters.AddWithValue("@Modified_By", "silvia");
                            cmd.CommandType = CommandType.StoredProcedure;

                            cn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }   
            }   

            rgMessageAdd.DataBind();
            rgMessage.DataBind();
            pnlEdit.Visible = true;
            pnlReadOnly.Visible = false;

    }

   
}
