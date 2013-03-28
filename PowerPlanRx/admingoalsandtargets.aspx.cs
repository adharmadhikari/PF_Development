using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Configuration;

public partial class admingoalsandtargets : System.Web.UI.Page
{
    protected bool EditMode
    {
        get
        {
            object mode = ViewState["editMode"];
            if(mode != null)
                return (bool)mode;

            return false;
        }
        set { ViewState["editMode"] = value; }
    }

    protected void OnEditPlans(object sender, EventArgs args)
    {
        EditMode = true;
        EditModeDistricts = false;

        hSelectedPlanID.Value = "";

        gridPlans.DataBind();
    }

    protected void OnCancel(object sender, EventArgs args)
    {
        EditMode = false;
        EditModeDistricts = false;

        gridPlans.DataBind();
        gridDistricts.DataBind();
    }

    protected void OnSavePlans(object sender, EventArgs args)
    {
        EditMode = false;
        EditModeDistricts = false;

        hSelectedPlanID.Value = "";

        saveGoals(gridPlans, false);

        gridPlans.DataBind();
    }


    void saveGoals(RadGrid grid, bool districtGoals)
    {
        SqlConnection cn = null;
        SqlCommand cmd = null;
        SqlTransaction tran = null;
        try
        {
            TextBox textBoxTrx;
            int trx;
            int mb;
            decimal mst;

            cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
            cn.Open();
            tran = cn.BeginTransaction();
            cmd = new SqlCommand("usp_Admin_UpdatePlanGoals", cn, tran);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;

            foreach ( GridDataItem item in grid.Items )
            {
                mb = Convert.ToInt32(item.GetDataKeyValue("MB_Trx"));

                if ( mb > 0 )
                {
                    textBoxTrx = item.FindControl("txtBrandTrx") as TextBox;

                    trx = Convert.ToInt32(textBoxTrx.Text);

                    mst = (trx / Convert.ToDecimal(mb)) * 100M;

                    cmd.Parameters.Clear();

                    cmd.Parameters.AddWithValue("@PlanID", item.GetDataKeyValue("Plan_ID"));
                    cmd.Parameters.AddWithValue("@BrandID", item.GetDataKeyValue("Brand_ID"));
                    cmd.Parameters.AddWithValue("@DataYear", item.GetDataKeyValue("Data_Year"));
                    cmd.Parameters.AddWithValue("@DataMonth", item.GetDataKeyValue("Data_Month"));
                    cmd.Parameters.AddWithValue("@userName", Impact.User.FullName);
                    if(districtGoals)
                        cmd.Parameters.AddWithValue("@DistrictID", item.GetDataKeyValue("District_ID"));
                    cmd.Parameters.AddWithValue("@Trx", trx);
                    cmd.Parameters.AddWithValue("@Mst", mst);

                    cmd.ExecuteNonQuery();
                }
            }

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
    }

    protected bool EditModeDistricts
    {
        get
        {
            object mode = ViewState["editModeDistricts"];
            if ( mode != null )
                return (bool)mode;

            return false;
        }
        set { ViewState["editModeDistricts"] = value; }
    }

    protected void OnEditDistricts(object sender, EventArgs args)
    {
        EditModeDistricts = true;

        gridDistricts.DataBind();
    }

    protected void OnSaveDistricts(object sender, EventArgs args)
    {
        EditModeDistricts = false;

        saveGoals(gridDistricts, true);

        gridDistricts.DataBind();
    }

    protected void OnSelectedPlanChanged(object sender, EventArgs args)
    {
        if ( EditMode )
        {
            EditMode = false;
            gridPlans.DataBind();
        }

        EditModeDistricts = false;
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs args)
    {
        hSelectedPlanID.Value = "";
    }

    protected override void OnPreRender(EventArgs e)
    {
        //if a plan is selected make sure it is sticky 
        string planID = hSelectedPlanID.Value;
        if ( !string.IsNullOrEmpty(planID) )
        {
            Telerik.Web.UI.GridDataItem item = gridPlans.MasterTableView.FindItemByKeyValue("Plan_ID", planID);
            if ( item != null )
                item.Selected = true;

            panelDistrictButtons.Visible = true;
        }
        else
        {
            panelDistrictButtons.Visible = false;
        }

        btnEditPlans.Visible = !EditMode;
        btnSavePlans.Visible = EditMode;
        btnEditDistricts.Visible = !EditModeDistricts;
        btnSaveDistricts.Visible = EditModeDistricts;
        btnCancel1.Visible = EditMode;
        btnCancel2.Visible = EditModeDistricts;

        base.OnPreRender(e);
    }
}
