using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Pinsonault.Data;
using System.Data;
using System.Text;
using Telerik.Web.UI;



public partial class createcampaign_step1_goals : System.Web.UI.Page, IEditPage
{
    protected override void OnLoad(EventArgs e)
    {

        goals.AllowEdit = ((MasterPage)Master).CanEdit && ((MasterPage)Master).PhaseID > 3;
        goals.IsEdit = ((MasterPage)Master).PhaseID == 3;  //If Goals have not been submitted once then force edit mode
        goals.ShowSummary = goals.AllowEdit;
        
        base.OnLoad(e);
    }

    #region IEditPage Members

    public bool Save()
    {
        using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
        {
            cn.Open();

            //Only save status the first time Goals are saved
            if ( ((MasterPage)Master).PhaseID == 3 )
            {
                using ( SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateGoals", cn) )
                {
                    cmd.Parameters.AddWithValue("@Campaign_ID", Request.QueryString["id"]);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();
                }
            }

            //Insert or Updates Plan Summary records for a campaign.  This saves Baseline data only (Month 0)
            using ( SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateGoalsSummaryForPlan", cn) )
            {
                GridItem[] items = goals.PlanGrid.MasterTableView.GetItems(GridItemType.Item);
                
                GridDataItem dataItem;

                if(items.Length > 0)
                {                    
                    dataItem = items[0] as GridDataItem;
                    if ( dataItem != null )
                    {                       
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Campaign_ID", dataItem.GetDataKeyValue("Campaign_ID")); 
                        cmd.Parameters.AddWithValue("@Trx", dataItem.GetDataKeyValue("BaselineTrx")); 
                        cmd.Parameters.AddWithValue("@Mst", Convert.ToDecimal(dataItem.GetDataKeyValue("BaselineMst"))); 
                        cmd.Parameters.AddWithValue("@MBTrx", dataItem.GetDataKeyValue("MB_Trx")); 
                        cmd.Parameters.AddWithValue("@Data_Year", dataItem.GetDataKeyValue("Data_Year")); 
                        cmd.Parameters.AddWithValue("@Data_Month", dataItem.GetDataKeyValue("Data_Month")); 
                        cmd.Parameters.AddWithValue("@UserName", Impact.User.FullName);

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            //Insert or Updates District Summary records for a campaign.  This saves Baseline data only (Month 0).  It also stores Targeted flag (non-targeted are also stored)
            using (SqlCommand cmd = new SqlCommand("usp_Campaign_UpdateGoalsSummaryForDistrict", cn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                Telerik.Web.UI.GridDataItem dataItem;
                CheckBox chkTargeted;
                bool selected;

                //process for every other row since grid displays Novo Brand and Competitors in alternating manor.  Each pair represents a single district that can be targeted (alternate rows are excluded)
                GridItem[] items = goals.DistrictGrid.MasterTableView.GetItems(GridItemType.Item);
                for ( int i = 0; i < items.Length; i ++ ) 
                {
                    chkTargeted = items[i].FindControl("chkTargeted") as CheckBox;                    

                    dataItem = items[i] as GridDataItem;
                    if ( dataItem != null)
                    {
                        if ( chkTargeted != null )
                            selected = chkTargeted.Checked;
                        else
                            selected = false;

                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Campaign_ID", dataItem.GetDataKeyValue("Campaign_ID")); 
                        cmd.Parameters.AddWithValue("@District_ID", dataItem.GetDataKeyValue("District_Name")); 
                        cmd.Parameters.AddWithValue("@Trx", dataItem.GetDataKeyValue("Trx")); 
                        cmd.Parameters.AddWithValue("@Mst", Convert.ToDecimal(dataItem.GetDataKeyValue("Mst"))); 
                        cmd.Parameters.AddWithValue("@MBTrx", dataItem.GetDataKeyValue("MB_Trx")); 
                        cmd.Parameters.AddWithValue("@Data_Year", dataItem.GetDataKeyValue("Data_Year")); 
                        cmd.Parameters.AddWithValue("@Data_Month", dataItem.GetDataKeyValue("Data_Month")); 
                        cmd.Parameters.AddWithValue("@IsTargeted", selected);
                        cmd.Parameters.AddWithValue("@UserName", Impact.User.FullName);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
        
        goals.IsEdit = false;


        goals.AllowEdit = true;

        goals.ResetCommands();

        //need to rebind to support dynamically generated template columns
        goals.PlanGrid.DataBind();
        goals.DistrictGrid.DataBind();

        return true;
    }

    public void Reset()
    {
        //don't reset if PhaseID is 3 (meaning AE has not submitted Goals once)
        goals.IsEdit = ((MasterPage)Master).PhaseID == 3;

        //need to rebind to support dynamically generated template columns
        goals.PlanGrid.DataBind();
        goals.DistrictGrid.DataBind();
    }

    public void Edit()
    {
        goals.IsEdit = true;

        //need to rebind to support dynamically generated template columns
        goals.PlanGrid.DataBind();
        goals.DistrictGrid.DataBind();
    }

    #endregion
}
