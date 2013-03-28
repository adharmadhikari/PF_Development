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
using Telerik.Web.UI;
using System.Collections;
using System.Resources;
using System.IO;

public partial class reports : System.Web.UI.Page
{
    private enum ReportType
    {
        Summary = 1,
        Details = 2
    }
    protected void OnAreaChanged(Object sender, EventArgs e)
    {
        RadComboBox regionlist = ddlRegion as RadComboBox;
        regionlist.Items.Clear();
        RadComboBoxItem regionname = new RadComboBoxItem();
        regionname.Text = Resources.Resource.Label_Any_Region;
        regionlist.Items.Add(regionname);

        RadComboBox distlist = ddlDistrict as RadComboBox;
        distlist.Items.Clear();
        RadComboBoxItem distname = new RadComboBoxItem();
        distname.Text = Resources.Resource.Label_Any_District;
        distname.Value = "0";
        distlist.Items.Add(distname);
    }
    protected void OnRegionChanged(Object sender, EventArgs e)
    {
        RadComboBox distlist = ddlDistrict as RadComboBox;
        distlist.Items.Clear();
        RadComboBoxItem distname = new RadComboBoxItem();
        distname.Text = Resources.Resource.Label_Any_District; 
        distname.Value = "0";
        distlist.Items.Add(distname);
    }
    protected void OnMCAreaChanged(Object sender, EventArgs e)
    {
        RadComboBox MCRegionList = ddlManagedMarketsRegion as RadComboBox;
        MCRegionList.Items.Clear();
        RadComboBoxItem MCRegionName = new RadComboBoxItem();
        MCRegionName.Text = Resources.Resource.Label_Any_MC_Region;
        MCRegionList.Items.Add(MCRegionName);

        RadComboBox TerritoryList = ddlManagedMarketsTerritory as RadComboBox;
        TerritoryList.Items.Clear();
        RadComboBoxItem TerritoryName = new RadComboBoxItem();
        TerritoryName.Text = Resources.Resource.Label_Any_MC_Territory;
        TerritoryName.Value = "0";
        TerritoryList.Items.Add(TerritoryName);
    }
    protected void OnMCRegionChanged(Object sender, EventArgs e)
    {
        RadComboBox TerritoryList = ddlManagedMarketsTerritory as RadComboBox;
        TerritoryList.Items.Clear();
        RadComboBoxItem TerritoryName = new RadComboBoxItem();
        TerritoryName.Text = Resources.Resource.Label_Any_MC_Territory;
        TerritoryName.Value = "0";
        TerritoryList.Items.Add(TerritoryName);
    }
    protected void OnMCTerritoryChanged(Object sender, EventArgs e)
    {
        RadComboBox AEList = ddlAccountExecutive as RadComboBox;
        AEList.Items.Clear();
        RadComboBoxItem AEName = new RadComboBoxItem();
        AEName.Text = Resources.Resource.Label_Any_AE;
        AEName.Value = "0";
        AEList.Items.Add(AEName);
    }
    /// <summary>
    /// temp function to get the excel file from server. it is only for demo. for actual export, use btnSubmit_Click
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btntempSubmit_Click(object sender, EventArgs e)
    {
        HttpContext context = HttpContext.Current;
        string strOutputFileName = context.Request.MapPath(
                Path.Combine(
                    context.Request.ApplicationPath,
                    "ExcelTemplates/SampleReportData.xls")
                .Replace(@"\", "/"));

        Impact.FileExport.ExportExcelWithFileName(context, strOutputFileName, "Test");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {        
        int iReportType = Convert.ToInt32(ddlReportType.SelectedValue);
     

        string strFilterCriteria = string.Empty;

        StringBuilder sb = new StringBuilder();
        SortedList slReportCriteria = new SortedList();
       
        //Retail Area, Region and district
        if (ddlStrategicAccount.SelectedIndex > 0)
        {
            sb.AppendFormat(" Parent_ID = '{0}' AND ", ddlStrategicAccount.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Strategic_Account , ddlStrategicAccount.SelectedItem.Text);
        }

        if (ddlArea.SelectedIndex > 0)
        {
            sb.AppendFormat(" Area_ID = '{0}' AND ", ddlArea.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Retail_Area , ddlArea.SelectedItem.Text);
        }

        if (ddlRegion.SelectedIndex > 0)
        {
            sb.AppendFormat(" Region_ID = '{0}' AND ", ddlRegion.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Retail_Region , ddlRegion.SelectedItem.Text);
        }

        if (ddlDistrict.SelectedIndex > 0)
        {
            sb.AppendFormat(" District_ID = '{0}' AND ", ddlDistrict.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_District , ddlDistrict.SelectedItem.Text);
        }

        //Managed care Area, Region and Territory
        if (ddlManagedMarketsArea.SelectedIndex > 0)
        {
            sb.AppendFormat(" MCArea_ID = '{0}' AND ", ddlManagedMarketsArea.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Managed_Care_Area  , ddlManagedMarketsArea.SelectedItem.Text);
        }

        if (ddlManagedMarketsRegion.SelectedIndex > 0)
        {
            sb.AppendFormat(" MCRegion_ID = '{0}' AND ", ddlManagedMarketsRegion.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Managed_Care_Region , ddlManagedMarketsRegion.SelectedItem.Text);
        }

        if (ddlManagedMarketsTerritory.SelectedIndex > 0)
        {
            sb.AppendFormat(" Territory_ID = '{0}' AND ", ddlManagedMarketsTerritory.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Managed_Care_Territory, ddlManagedMarketsTerritory.SelectedItem.Text);
        }

        if (ddlAccountExecutive.SelectedIndex > 0)
        {
            sb.AppendFormat(" User_ID = {0} AND ", ddlAccountExecutive.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Account_Executive, ddlAccountExecutive.SelectedItem.Text);
        }
        if (ddlBrands.SelectedIndex > 0)
        {
            sb.AppendFormat(" Brand_ID = {0} AND ", ddlBrands.SelectedValue);
            slReportCriteria.Add(Resources.Resource.Label_Brand , ddlBrands.SelectedItem.Text);
        }

        if (sb.Length > 0)
        {
            strFilterCriteria = sb.ToString();
            strFilterCriteria = strFilterCriteria.Substring(0, strFilterCriteria.Length - 4);
        }
        //get the Title and Report Criteria
        string strTitle = String.Format(" Report  {0}", ddlReportType.SelectedItem.Text);
        string strReportCriteriaHeader = Impact.FileExport.GetCriteriaDetails(strTitle, Impact.FileExport.ReportType.Excel, slReportCriteria);

        //get the date range
        List<int> range = buildDynamicOutput();
        
        string strQuery = string.Empty;
        strQuery = GetReportsSummary(range, strFilterCriteria);
        DataSet dsSummary = new DataSet();
        dsSummary = Campaign.GetPlanDistrictReports(strQuery);
        strQuery = string.Empty;
        //report is summary type
        if (iReportType == 1)
        {
            if (dsSummary.Tables[0].Rows.Count > 0)
            {
                //get report criteria for header
                Impact.FileExport.ExportExcelForReport(HttpContext.Current, "Report Summary", dsSummary, strReportCriteriaHeader, Request.QueryString, range, iReportType, null);
            }
            else
                ShowMessageBox(this, Resources.Resource.Message_No_Records, "");
           
        }
        //report is details type
        else if (iReportType == 2)
        {
            strQuery = GetReportsDetails(range, strFilterCriteria);

            DataSet dsReportDetails = new DataSet();
            dsReportDetails = Campaign.GetPlanDistrictReports(strQuery);

            if (dsReportDetails.Tables[0].Rows.Count > 0)
                Impact.FileExport.ExportExcelForReport(HttpContext.Current, "Report Details", dsReportDetails, strReportCriteriaHeader, Request.QueryString, range, iReportType, dsSummary.Tables[0]);
            else
                ShowMessageBox(this, Resources.Resource.Message_No_Records, "");

            dsReportDetails.Dispose();
        }
        dsSummary.Dispose();
      
    }

    /// <summary>
    /// for showing the alert message box
    /// </summary>
    /// <param name="senderPage"></param>
    /// <param name="alertMsg"></param>
    /// <param name="alertKey"></param>
    public static void ShowMessageBox(System.Web.UI.Page senderPage, string alertMsg, string alertKey)
    {
        ScriptManager.RegisterStartupScript(senderPage, senderPage.GetType(), alertKey, "alert('" + alertMsg + "');",true);
    }

    /// <summary>
    /// Gives the list of values required for data key filteration
    /// </summary>
    /// <returns></returns>
    List<int> buildDynamicOutput()
    {
        DateTime start = DateTime.MinValue;
        int duration = 0;      

        getTimeline(out start, out duration);

        
        List<int> values = new List<int>();

        if (duration > 0)
        {

            DateTime dt;
            string name;

            for (int i = 0; i < duration; i++)
            {
                dt = start.AddMonths(-i);

                values.Add((dt.Year * 100) + dt.Month);

                name = string.Format("{0:yyyy}{0:MM}", dt);                
            }
        }        
        return values;       

    }
    
    void getTimeline(out DateTime start, out int duration)
    {
        start = DateTime.MinValue;
        int iDataMonth=0;
        int iDataYear=0;
        duration = 0;       
        
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetBaseLine", cn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;                    

                    cn.Open();

                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            iDataYear = rdr.GetInt32(rdr.GetOrdinal("Data_Year"));
                            iDataMonth = rdr.GetInt32(rdr.GetOrdinal("Data_Month")); //10;
                            duration = rdr.GetInt32(rdr.GetOrdinal("Duration"));                           
                        }
                    }
                }
                cn.Close();
            }
           
            start = Convert.ToDateTime(string.Format("{0}/{1}/{2}", iDataMonth, "01", iDataYear));
           
    }
        
    /// <summary>
    /// for giving the report summary
    /// </summary>
    /// <param name="range"></param>
    /// <param name="strFilter"></param>
    private string GetReportsSummary(List<int> range, string strFilter)
    {
        SQLUtil.MaxFragmentLength = 40;

        string baseLineViewForPlan = "V_Campaign_Plan_Summary_Baseline";    
       
        SQLPivotQuery<int> query = SQLPivotQuery<int>.Create("V_Report_Plan_Goals", new string[] { "Campaign_ID"
            , "Plan_ID", "RecordType", "Brand_ID" ,"Latest_Trx"
            ,"EndDate_GoalTrx","Result_Curr_Trx" }, "Data_Key", range)
                        .Pivot(SQLFunction.MAX, "Trx")                      

                        .InnerJoin("Plan_Mast", "Plan_ID", "Plan_ID", "Plan_Name")
                        .Join(new SQLLeftOuterJoin(new SQLTable(baseLineViewForPlan, "Brand_Trx", "MB_Trx", "Data_Year", "Data_Month"))
                                    .AddRelation(new SQLRelation("Plan_ID", "Plan_ID"))
                                    .AddRelation(new SQLRelation("Brand_ID", "Brand_ID"))
                                    .AddRelation(new SQLRelation("Campaign_ID", "Campaign_ID"))
                                )
                        .InnerJoin("V_Brands", "Brand_ID", "Brand_ID", "Brand_Name")
                        ;
        
        query.Pivot(SQLFunction.MAX, "Curr_Trx");        

        StringBuilder sb = new StringBuilder();
        sb.Append("Select CI.Campaign_ID,UM.User_L_Name + ',' + UM.User_F_Name AS AEName");
        sb.Append(", Brand_Trx as  BaselineTrx");
        sb.AppendFormat(" ,CI.Status_ID,* from ({0}) as resultsTable ", query);
       
        sb.Append(" INNER JOIN dbo.Campaign_Info CI On resultsTable.Campaign_ID = CI.Campaign_ID and CI.Status_ID IN (2,3) ");
        sb.Append(" INNER JOIN dbo.User_Mast UM On UM.Territory_ID = CI.Territory_ID and UM.Title_ID = 1 ");

        sb.Append(" where Status_ID in (2,3)");
          if (strFilter.Length > 0)
            sb.AppendFormat(" AND CI.campaign_ID IN (Select DISTINCT campaign_ID from dbo.V_Report_Territory where {0})", strFilter);
        sb.Append(" Order By resultsTable.Campaign_ID asc ");
        return sb.ToString();
       
    }
    /// <summary>
    /// for giving the report details
    /// </summary>
    /// <param name="range"></param>
    /// <param name="strFilter"></param>
    private string GetReportsDetails(List<int> range, string strFilter)
    {
        SQLUtil.MaxFragmentLength = 40;

        string baseLineViewForDistrict = "V_Report_District_Summary_Baseline";
        string mainViewForDistrict = "V_Report_District_Details";
               
        SQLPivotQuery<int> query = SQLPivotQuery<int>.Create(mainViewForDistrict, new string[] { "Campaign_ID", "Plan_ID", "Brand_ID"
            , "District_ID"
            , "InDistrict"}, "Data_Key", range)
                .Pivot(SQLFunction.MAX, "Trx")               
                .Pivot(SQLFunction.MAX, "Mst")
                .Pivot(SQLFunction.MAX, "Curr_Trx")
                .Pivot(SQLFunction.MAX, "Curr_Mst")


                .InnerJoin("Plan_Mast", "Plan_ID", "Plan_ID", "Plan_Name")
                .Join(new SQLLeftOuterJoin(new SQLTable(baseLineViewForDistrict, "Trx", "Mst", "Campaign_Flag_Indicator", "Data_Year", "Data_Month"))
                                    .AddRelation(new SQLRelation("Plan_ID", "Plan_ID"))
                                    .AddRelation(new SQLRelation("Brand_ID", "Brand_ID"))
                                    .AddRelation(new SQLRelation("Campaign_ID", "Campaign_ID"))                               
                                    .AddRelation(new SQLRelation("District_ID", "District_ID"))
                      )               
                 .InnerJoin("V_Brands", "Brand_ID", "Brand_ID", "Brand_Name")
                 .Join(new SQLLeftOuterJoin(new SQLTable("V_Report_EndDateGoals","EndDate_GoalTrx","EndDate_GoalMst"))
                                    .AddRelation(new SQLRelation("Campaign_ID", "Campaign_ID")) 
                                    .AddRelation(new SQLRelation("District_ID", "District_ID"))
                       )
                 .Join(new SQLLeftOuterJoin(new SQLTable("V_Report_ResultTrx", "Result_Curr_Trx", "Result_Curr_Mst"))
                                    .AddRelation(new SQLRelation("Campaign_ID", "Campaign_ID"))
                                    .AddRelation(new SQLRelation("District_ID", "District_ID"))
                       )
                  .Join(new SQLLeftOuterJoin(new SQLTable("SV_Base", "Brand_Trx"))
                                   .AddRelation(new SQLRelation("Plan_ID", "Plan_ID"))
                                   .AddRelation(new SQLRelation("Brand_ID", "Brand_ID"))
                                   .AddRelation(new SQLRelation("District_ID", "District_ID"))
                        )
                  .LeftOuterJoin("V_DistrictList", "District_ID", "District_ID", "District_Name")
                                ;
       
       
             
        StringBuilder sb = new StringBuilder();
        sb.Append("Select CI.campaign_ID,CI.Status_ID,CI.Start_Date,CI.End_Date,UM.User_L_Name + ',' + UM.User_F_Name AS AEName,resultsTable.*,resultsTable.Brand_Trx As Latest_Trx");
        sb.Append(", case when resultsTable.district_ID = 'Non-Targeted' then 'Non-Targeted' else resultsTable.District_Name end as Actual_District_Name");
        sb.Append(", Plan_Name, Trx AS BaselineTrx");        
        sb.Append(", Mst as BaselineMst");
        sb.Append(", Case when Result_Curr_Mst > 0 AND EndDate_GoalMst > Mst Then ((Result_Curr_Mst - Mst)*100.00/(EndDate_GoalMst - Mst)) end AS Result_GoalPercent");
                
        for (int i = 0; i < range.Count; i++)
        {
            //calculating % to Goal
            sb.AppendFormat(",case when Curr_Mst{0} > 0 AND Mst{0} > Mst Then ((Curr_Mst{0}-Mst)*100.00/(Mst{0}- Mst)) end as Curr_Trx_GoalPercent{0}", i);            
        }
        sb.AppendFormat(" from ({0}) as resultsTable ", query);
        sb.Append(" INNER JOIN dbo.Campaign_Info CI On resultsTable.Campaign_ID = CI.Campaign_ID and CI.Status_ID IN (2,3) ");
        sb.Append(" INNER JOIN dbo.User_Mast UM On UM.Territory_ID = CI.Territory_ID and UM.Title_ID = 1 ");

       
        
        if (strFilter.Length > 0)
            sb.AppendFormat(" where CI.campaign_ID IN (Select DISTINCT campaign_ID from dbo.V_Report_Territory where {0})", strFilter);
        sb.Append(" Order By resultsTable.Campaign_ID asc,InDistrict desc ");
        return sb.ToString();       
    }
}
