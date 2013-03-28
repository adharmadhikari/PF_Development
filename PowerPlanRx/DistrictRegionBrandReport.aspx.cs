using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Impact.Campaign;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Pinsonault.Data;
using System.Text;
using Impact.Utility;
using Telerik.Web.UI;

public partial class DistrictRegionBrandReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["brandid"].ToString() == "0")
        {
            pnlResult.Visible = false;
        }
        else
        {
            pnlResult.Visible = true;
        }

        //give the export page url        
        hdnQString.Value = string.Format("Export.aspx{0}", Request.Url.Query);
    }

    protected override void OnPreRender(EventArgs e)
    {
        //reset selected controls to previous value manually since we are not using proper postback method
        if ( !Page.IsPostBack )
        {
            string val;
            
            val = Request["reporttype"];
            if (!string.IsNullOrEmpty(val)) ddlReportType.SelectedValue = val;
            val = Request["segment"];
            if (!string.IsNullOrEmpty(val)) ddlSegment.SelectedValue = val;
            val = Request["dist"];
            if ( !string.IsNullOrEmpty(val) ) ddlDistrict.SelectedValue = val;
            val = Request["regionid"];
            if ( !string.IsNullOrEmpty(val) ) ddlRegion.SelectedValue = val;
            val = Request["brandid"];
            if ( !string.IsNullOrEmpty(val) ) ddlBrands.SelectedValue = val;
            val = Request["areaid"];
            if ( !string.IsNullOrEmpty(val) ) ddlArea.SelectedValue = val;
        }
        base.OnPreRender(e);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string reportType = ddlReportType.SelectedValue;
        int brandID = ddlBrands.SelectedIndex;
        string segment = ddlSegment.SelectedValue;
        string retailAreaID = ddlArea.SelectedValue;
        string retailRegionID = ddlRegion.SelectedValue;
        string districtID = ddlDistrict.SelectedValue;
       

        string redirectURL = "DistrictRegionBrandReport.aspx?reporttype=" + reportType + "&brandid=" + brandID + "&segment=" + segment + "&areaid=" + retailAreaID + "&regionid=" + retailRegionID + "&dist=" + districtID;    
        Response.Redirect(redirectURL);
        
    }

    protected void OnAreaChanged(Object sender, EventArgs e)
    {
        RadComboBox regionlist = ddlRegion as RadComboBox;
        regionlist.Items.Clear();
        RadComboBoxItem regionname = new RadComboBoxItem();
        regionname.Text = "-- Any Region --";
        regionname.Value = "0";
        regionlist.Items.Add(regionname);

        RadComboBox distlist = ddlDistrict as RadComboBox;
        distlist.Items.Clear();
        RadComboBoxItem distname = new RadComboBoxItem();
        distname.Text = "-- Any District --";
        distname.Value = "0";
        distlist.Items.Add(distname);
    }


    protected void OnRegionChanged(Object sender, EventArgs e)
    {        
        RadComboBox distlist = ddlDistrict as RadComboBox;
        distlist.Items.Clear();
        RadComboBoxItem distname = new RadComboBoxItem();
        distname.Text = "-- Any District --";
        distname.Value = "0";
        distlist.Items.Add(distname);
    }



}
