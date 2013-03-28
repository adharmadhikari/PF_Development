using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlTypes;
using Impact.Campaign;
using Telerik.Web.UI;

public partial class createcampaign_step1_profile : System.Web.UI.Page, IEditPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //check if CampaignID or id is not present in the querystring, redirect it back to previous page.
        if (string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            Response.Redirect(Request.ServerVariables["HTTP_REFERER"]);
        }
     
        if (!Page.IsPostBack)
        {
            GetCampaignProductInfo();
            if (((MasterPage)this.Master).IsPageEditable) 
            {
                pnlReadonly.Visible = false;
                pnlEdit.Visible = true;
            }
        }  
       
    }
    /// <summary>
    /// This function gets the Campaign info and binds the datalist control to database values
    /// </summary>
    private void GetCampaignProductInfo()
    {
        int iCampaignID = System.Convert.ToInt32(Request.QueryString["id"]);

        DataTable dtCampaignProduct = Campaign.GetCampaignProductFormulary(iCampaignID);

        dlCampaignProdInfo.DataSource = dtCampaignProduct;
        dlCampaignProdInfo.DataBind();

        foreach (DataListItem item in dlCampaignProdInfo.Items)
        {
            Label Product_PA = (Label)item.FindControl("Product_PA");
            Label Product_QL = (Label)item.FindControl("Product_QL");
            Label Product_ST = (Label)item.FindControl("Product_ST");

            TextBox txtProduct_QL_Comment = (TextBox)item.FindControl("txtProduct_QL_Comment");

            RadComboBox ddlProduct_PA_Comment = (RadComboBox)item.FindControl("ddlProduct_PA_Comment");
            Label Product_PA_Comment = (Label)item.FindControl("Product_PA_Comment");

            RadComboBox ddlProduct_ST_Comment = (RadComboBox)item.FindControl("ddlProduct_ST_Comment");
            Label Product_ST_Comment = (Label)item.FindControl("Product_ST_Comment");

            Label CampaignID = (Label)item.FindControl("CampaignID");
            Label Product_ID = (Label)item.FindControl("Product_ID");

            //get the QL link button url    
            HyperLink hypQL = (HyperLink)item.FindControl("hypQL");
            hypQL.NavigateUrl = "javascript:OpenQLCommentWindow('" + txtProduct_QL_Comment.ClientID + "')";

            //get the selected value of PA comments as per the Product_PA_Comment's PACommentID value 
            if ((Product_PA_Comment.Text == "0") || (Product_PA_Comment.Text == null))
            {
                ddlProduct_PA_Comment.Items.FindItemByValue("0").Selected = true;
            }
            else
            {
                ddlProduct_PA_Comment.Items.FindItemByValue(Product_PA_Comment.Text).Selected = true;
            }

            ////get the selected value of ST comments from database
            if ((Product_ST_Comment.Text == "0") || (Product_ST_Comment.Text == null))
            {
                ddlProduct_ST_Comment.Items.FindItemByValue("0").Selected = true;
            }
            else
            {
                ddlProduct_ST_Comment.Items.FindItemByValue(Product_ST_Comment.Text).Selected = true;
            }

            //make the comments field as readonly if the corresponding database value = "N" or false

            if (Product_PA.Text == "N")
            { ddlProduct_PA_Comment.Enabled = false; }

            if (Product_QL.Text == "N")
            {
                txtProduct_QL_Comment.Enabled = false;
                hypQL.Enabled = false;
            }

            if (Product_ST.Text == "N")
            { ddlProduct_ST_Comment.Enabled = false; }

        }
    }
    /// <summary>
    /// This function redirects the user to Campaign Rational selection page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lbtnRational_Click(object sender, EventArgs e)
    {
        string strPlanID = ((Label)frmPlanInfo.FindControl("lblPlanID")).Text;
        string strBrandID = ((Label)frmPlanInfo.FindControl("lblBrandID")).Text;
        string strRedirectURL = "Campaign_Rationale.aspx?Plan_ID=" + strPlanID + "&Brand_ID=" + strBrandID + "&id=" + Request.QueryString["id"].ToString();

        Response.Redirect(strRedirectURL);
    }

    /// <summary>
    /// For updating the campaign plan profile and Product formulary details
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public bool Save()
    {
        if (Campaign.IsCampaignActive(System.Convert.ToInt32(Request.QueryString["id"])))
        {
            UpdateCampaignPlanInfo();
            UpdateCampaignProductFormulary();
            frmPlanInfoReadOnly.DataBind();
            dlProdInfoReadOnly.DataBind();
            pnlEdit.Visible = false;
            pnlReadonly.Visible = true;
        }
        return true;
    }
    /// <summary>
    /// resets the control values from datbase
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void Reset()
    {       
        frmCampaignInfo.DataBind();
        frmPlanInfo.DataBind();
        GetCampaignProductInfo();
        pnlReadonly.Visible = true;
        pnlEdit.Visible = false;
    }
    /// <summary>
    /// For editing the campaign
    /// </summary>
    public void Edit()
    {
        pnlReadonly.Visible = false;
        pnlEdit.Visible = true;
    }
    /// <summary>
    /// For updating the campaign plan info
    /// </summary>
    private void UpdateCampaignPlanInfo()
    {
        int iCampaignID = System.Convert.ToInt32(Request.QueryString["id"]);

        string strTotalLives = ((TextBox)frmPlanInfo.FindControl("txtPlanTotalLives")).Text;
        int? iTotalLives = null;
        if (strTotalLives != string.Empty) iTotalLives = Convert.ToInt32(strTotalLives.Replace(",", ""));


        string strPharmacylives = ((TextBox)frmPlanInfo.FindControl("txtPlanPharmacyLives")).Text;
        int? iPharmacylives = null;
        if (strPharmacylives != string.Empty) iPharmacylives = Convert.ToInt32(strPharmacylives.Replace(",", ""));

        bool bFormulary_Change_Status = ((RadioButton)frmPlanInfo.FindControl("radFChangeYes")).Checked;
        System.Data.SqlTypes.SqlDateTime dtFormulary_Change_Eff_Date = SqlDateTime.Null;
        string strEffDate = ((TextBox)frmPlanInfo.FindControl("txtEffectiveDate")).Text;
        if (strEffDate != "")
        { dtFormulary_Change_Eff_Date = System.Convert.ToDateTime(strEffDate); }

        bool bPlan_Participation_PT = ((RadioButton)frmPlanInfo.FindControl("radParticipationYes")).Checked;
        string strPlan_Penetrate_Region = ((TextBox)frmPlanInfo.FindControl("txtPlanPenetration")).Text;
        string strContract_Share_Goal = ((TextBox)frmPlanInfo.FindControl("txtContractShareGoal")).Text;

        string strKey_Employers = ((TextBox)frmPlanInfo.FindControl("txtKeyEmployers")).Text;
        string strAffiliated_Phys_Groups = ((TextBox)frmPlanInfo.FindControl("txtAffPhyGroups")).Text;
        string strNational_Account_Affiliates = ((TextBox)frmPlanInfo.FindControl("txtNationalAccAff")).Text;
        string strPBM_Affiliation = ((TextBox)frmPlanInfo.FindControl("txtPBMAffiliation")).Text;

        string strOther_Facts1 = ((TextBox)frmPlanInfo.FindControl("txtKEOtherFacts")).Text;
        string strOther_Facts2 = ((TextBox)frmPlanInfo.FindControl("txtAffPhyGroupOtherFacts")).Text;
        string strOther_Facts3 = ((TextBox)frmPlanInfo.FindControl("txtNationalAccAffOtherfacts")).Text;
        string strOther_Facts4 = ((TextBox)frmPlanInfo.FindControl("txtPBMAffOtherFacts")).Text;
        string strPinsoUserID = Session["pinsoUserID"].ToString();

        //update campaign product formulary
        Campaign.UpdateCampaignPlanInfo(iCampaignID, iTotalLives, iPharmacylives, bFormulary_Change_Status, dtFormulary_Change_Eff_Date,
            bPlan_Participation_PT, strKey_Employers, strAffiliated_Phys_Groups, strNational_Account_Affiliates, strPBM_Affiliation, strPlan_Penetrate_Region, strContract_Share_Goal, strOther_Facts1, strOther_Facts2, strOther_Facts3, strOther_Facts4, strPinsoUserID);

    }
    /// <summary>
    /// For updating the contents in datalist i.e for updating the campaign product formulary table
    /// </summary>
    private void UpdateCampaignProductFormulary()
    {
        //assign the label controls for datalist
        foreach (DataListItem item in dlCampaignProdInfo.Items)
        {
            Label CampaignID = (Label)item.FindControl("CampaignID");
            Label Product_ID = (Label)item.FindControl("Product_ID");
            Label Product_PA_Comment = (Label)item.FindControl("Product_PA_Comment");
            Label Product_ST_Comment = (Label)item.FindControl("Product_ST_Comment");
            Label txtProduct_Tier = (Label)item.FindControl("txtProduct_Tier");
            Label txtProduct_Copay = (Label)item.FindControl("txtProduct_Copay");
            TextBox txtProduct_QL_Comment = (TextBox)item.FindControl("txtProduct_QL_Comment");
            RadComboBox ddlProduct_PA_Comment = (RadComboBox)item.FindControl("ddlProduct_PA_Comment");
            RadComboBox ddlProduct_ST_Comment = (RadComboBox)item.FindControl("ddlProduct_ST_Comment");

            //get the selected value and update 
            string strProduct_PA_Comment = "";
            string strProduct_ST_Comment = "";

            int iCampaignID = System.Convert.ToInt32(CampaignID.Text);
            int iProductID = System.Convert.ToInt32(Product_ID.Text);
            string strProduct_Tier = txtProduct_Tier.Text;
            string strProduct_Copay = txtProduct_Copay.Text;
            if (!ddlProduct_PA_Comment.Items.FindItemByValue("0").Selected)
            {
                strProduct_PA_Comment = ddlProduct_PA_Comment.SelectedItem.Text;
            }
            string strProduct_QL_Comment = txtProduct_QL_Comment.Text;
            if (!ddlProduct_ST_Comment.Items.FindItemByValue("0").Selected)
            {
                strProduct_ST_Comment = ddlProduct_ST_Comment.SelectedItem.Text;
            }

            //update campaign product formulary
            Campaign.UpdateCampaignProductFormulary(iCampaignID, iProductID, strProduct_Tier, strProduct_Copay, strProduct_PA_Comment, strProduct_QL_Comment, strProduct_ST_Comment, Session["pinsoUserID"].ToString());

        }
    }   

}
