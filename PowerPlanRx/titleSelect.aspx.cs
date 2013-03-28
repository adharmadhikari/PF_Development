using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


public partial class titleSelect : System.Web.UI.Page
{
    protected override void OnInit(EventArgs e)
    {
        Impact.User.CheckSession();

        base.OnInit(e);
    }
    protected void OnTitleSelected(object sender, EventArgs e)
    {
        string titleID = dlTitles.SelectedValue;

        string redirect = Request.QueryString["ReturnUrl"];
        if ( string.IsNullOrEmpty(redirect) )
            redirect = "~/home.aspx";

        if(!string.IsNullOrEmpty(titleID))
        {
            string[] vals = titleID.Split('|');

            Session["titleID"] = Convert.ToInt32(vals[0]);
            Session["territoryID"] = vals[1];
            Session["pinsoUserID"] = Convert.ToInt32(vals[2]);
            //Session["districtID"] = vals[3];
            //Session["regionID"] = vals[4];

            Response.Redirect(redirect);
        }
    }
}
