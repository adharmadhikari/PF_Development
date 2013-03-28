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



public partial class createcampaign_step2_tactics : System.Web.UI.Page, IEditPage
{

    int _phaseID;
    int _tacticsCount;
    int _campaignID;
    
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

        // previous step(_phaseID == 5 Team Setup) has been completed & now Tactics begin (page should be in Edit mode)
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
            // validate: at least 1 Tactic must be selected
            int rowCount = rgTactics.MasterTableView.GetItems(new GridItemType[] { GridItemType.Item, GridItemType.AlternatingItem }).Length;

            if (rowCount > 0) 
            {
                // only if current Phase ID = 5, update Phase ID = 6
                if (_phaseID == 5)
                {
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("update Campaign_Info set Phase_ID = 6 where Campaign_ID = @Campaign_ID", cn))
                        {
                            cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                            cn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                EditSelectedTactics();

                //rgTacticsReadOnly.DataBind();
                tactics.TacticGrid.DataBind();
                
                pnlEdit.Visible = false;
                pnlReadOnly.Visible = true;

                return true;
            }

            else  // at least 1 Tactic must be selected
            {
                divMsg.InnerHtml = "Please select at least 1 Tactic!";
                divMsg.Visible = true;
                return false;
            }

        }

        return true;

    }

    private void EditSelectedTactics()
    {
        foreach (GridDataItem item in rgTactics.MasterTableView.Items)
        {

            RadTextBox rtxtQty = (RadTextBox)item.FindControl("rtxtQtyEdit");
            int _qty = Convert.ToInt32(rtxtQty.Text);
            int _tacticsID = Convert.ToInt32(item.OwnerTableView.DataKeyValues[item.ItemIndex]["Tactics_ID"]);

            UpdateQty(_qty, _tacticsID, Impact.User.FullName);

        }
    }


    public void Reset()
    {
        rgTactics.DataBind();
        rgTacticsAdd.DataBind();

        tactics.TacticGrid.DataBind();
        pnlEdit.Visible = false;
        pnlReadOnly.Visible = true;
    }

    public void Edit()
    {
        pnlEdit.Visible = true;
        pnlReadOnly.Visible = false;
    }

    #endregion


    private void UpdateQty(int iQty, int iTacticsID, string strPinsoUser)
    {
        // update the Qty that is in the selected list
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateTactics", cn))
            {
                cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                cmd.Parameters.AddWithValue("@Tactic_ID", iTacticsID);
                cmd.Parameters.AddWithValue("@Qty", iQty);
                cmd.Parameters.AddWithValue("@Modified_By", strPinsoUser);
                cmd.CommandType = CommandType.StoredProcedure;

                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }


    /// <summary>
    /// Validation needed:
    /// After 1st time Submit Phase ID has already been changed to 6 in the 'Campaign_Info' table
    /// If Campaign Phase ID >=6  Then at least 1 tactic must be in the 'Campaign_Tactic_Details' table
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void rgTactics_DeleteCommand(object sender, GridCommandEventArgs e)
    {
            _tacticsCount = SelectedTacticsCount(_campaignID);

            if (_phaseID >= (int)Impact.Campaign.PhaseID.Tactics)  // means at least 1 Tactic is already saved (validation needed: can't remove all tactics)
            {

                if (_tacticsCount > 1)   // if _tacticsCount = 1: can't remove the only 1 left selected tactic
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
        int _tacticsID;
        _tacticsID = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Tactics_ID"].ToString());

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_Campaign_Tactics_SelectedList_Delete", cn))
            {
                cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                cmd.Parameters.AddWithValue("@Tactic_ID", _tacticsID);
                cmd.CommandType = CommandType.StoredProcedure;

                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        rgTacticsAdd.DataBind();
        rgTactics.DataBind();
        pnlEdit.Visible = true;
        pnlReadOnly.Visible = false;
    }


    public static int SelectedTacticsCount(int _campaignID)
    {
        int _count = 0;
        // to count # of Tactics in the selected list
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select count(*) from dbo.Campaign_Tactic_Details where Campaign_ID = @Campaign_ID", cn))
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

    protected void rgTactics_CancelCommand(object sender, EventArgs e)
    {


    }


    protected void EditQty(object sender, EventArgs e)
    {
        EditSelectedTactics();

    }
    
    protected void AddTactics(object sender, EventArgs e)
    {

        foreach (GridDataItem item in rgTacticsAdd.MasterTableView.Items)
        {
           
            RadTextBox qty = (RadTextBox)item.FindControl("rtxtQtyAdd");
           
            if (qty.Text.Trim() != null && qty.Text.Trim() != "" && Convert.ToInt32(qty.Text) > 0)
            {

                int _tacticsID = Convert.ToInt32(item.OwnerTableView.DataKeyValues[item.ItemIndex]["Tactics_ID"]);
                int iQty = Convert.ToInt32(qty.Text);

                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateTactics", cn))
                    {
                        cmd.Parameters.AddWithValue("@Campaign_ID", _campaignID);
                        cmd.Parameters.AddWithValue("@Tactic_ID", _tacticsID);
                        cmd.Parameters.AddWithValue("@Qty", iQty);
                        cmd.Parameters.AddWithValue("@Modified_By", Impact.User.FullName);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }   
        }   

        rgTacticsAdd.DataBind();
        rgTactics.DataBind();
        pnlEdit.Visible = true;
        pnlReadOnly.Visible = false;

       
    }
}
