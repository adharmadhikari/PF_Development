using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;

public partial class adminmanagetactics : System.Web.UI.Page
{
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

    protected void OnCancel(object sender, EventArgs args)
    {
        EditMode = false;
        radGrid.DataBind();
    }

    protected void OnEdit(object sender, EventArgs args)
    {
        EditMode = true;
        radGrid.DataBind();
    }

    protected void OnSave(object sender, EventArgs args)
    {
        int id;
        int? brandID = null;
        
        if( rcbBrand.SelectedIndex > 0 )
            brandID = Convert.ToInt32(rcbBrand.SelectedValue);

        SqlConnection cn = null;
        SqlCommand cmd = null;
        SqlTransaction tran = null;

        try
        {
            cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
            cn.Open();
            
            tran = cn.BeginTransaction();
            cmd = new SqlCommand("usp_Admin_UpdateTactic", cn, tran);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            
            foreach ( GridDataItem item in radGrid.Items )
            {
                //if ( !(bool)item.GetDataKeyValue("UpdatePending") )
                //{
                    id = Convert.ToInt32(item.GetDataKeyValue("Tactics_ID"));
                
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Tactics_ID", id);
                    cmd.Parameters.AddWithValue("@Tactic_Update_ID", item.GetDataKeyValue("Tactic_Update_ID"));
                    cmd.Parameters.AddWithValue("@Brand_ID", brandID);
                    cmd.Parameters.AddWithValue("@Tactics_Name", ((TextBox)item.FindControl("txtName")).Text);
                    cmd.Parameters.AddWithValue("@Tactics_Description", ((TextBox)item.FindControl("txtDescription")).Text);
                    cmd.Parameters.AddWithValue("@userName", Impact.User.FullName);

                    cmd.ExecuteNonQuery();
                //}
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

        EditMode = false;

        radGrid.DataBind();
    }

    protected override void OnPreRender(EventArgs e)
    {
        btnEdit.Visible = !EditMode;
        btnSave.Visible = EditMode;
        btnCancel.Visible = EditMode;

        base.OnPreRender(e);
    }
}
