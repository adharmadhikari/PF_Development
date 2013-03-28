using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Configuration;
using Pinsonault.Data;
using System.Text;
using Impact.Utility;

public partial class controls_GoalsByDistrict : System.Web.UI.UserControl
{
    public Telerik.Web.UI.RadGrid PlanGrid
    {
        get { return gridView; }
    }

    public Telerik.Web.UI.RadGrid DistrictGrid
    {
        get { return gridViewDistricts; }
    }

    /// <summary>
    /// Indicates that the page should show the "actual" values along with goals (summary information is also assumed then)
    /// </summary>
    public bool ShowResults { get; set; }
    /// <summary>
    /// Indicates that the stored summary information should be displayed for baseline 
    /// </summary>
    public bool ShowSummary { get; set; }

    /// <summary>
    /// Indicates that the control is being used on the main Goals page and it is possible to update targeting and summary data (not the same as IsEdit which is actual mode of page).
    /// </summary>
    public bool AllowEdit { get; set; }

    /// <summary>
    /// Indicates if the district grid should show in "edit" mode meaning the user can update which districts are targeted.
    /// </summary>
    public bool IsEdit { get; set; }

    /// <summary>
    /// Indicates if Campaign info section should be visible (name, brand, etc)
    /// </summary>
    public bool ShowCampaignInformation
    {
        get { return panelCampaignInformation.Visible; }
        set { panelCampaignInformation.Visible = value; }
    }

    public void ResetCommands()
    {
        //first time in set dynamic grid columns which are constructed based on timeline.  ViewState properties are also set so values obtained by this method call are retained accross postbacks.
        List<int> range = buildDynamicOutput(AllowEdit, ShowSummary, ShowResults);

        //always need to reset commands they may be needed in the event of sorting or paging a grid
        setDataSourceCommands(range, AllowEdit, ShowSummary, ShowResults);
        
    }

    protected override void OnLoad(EventArgs e)
    {
        ResetCommands();

        base.OnLoad(e);
    }

    //returns timeline information about a campaign
    void getCampaignTimeline(out DateTime start, out int duration, out string planName)
    {
        start = DateTime.MinValue;
        duration = 0;
        planName = string.Empty;

        //first page load get from DB and store in view state - on postbacks used cached values
        if ( !IsPostBack )
        {
            using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
            {
                using ( SqlCommand cmd = new SqlCommand("usp_GetCampaign_Timeline", cn) )
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", Convert.ToInt32(Request.QueryString["id"]));

                    cn.Open();

                    using ( SqlDataReader rdr = cmd.ExecuteReader() )
                    {
                        if ( rdr.Read() )
                        {
                            start = rdr.GetDateTime(rdr.GetOrdinal("Start_Date"));
                            duration = rdr.GetInt32(rdr.GetOrdinal("Campaign_Duration"));
                            planName = rdr.GetString(rdr.GetOrdinal("Campaign_Name"));
                        }
                    }
                }
            }

            ViewState["startDate"] = start;
            ViewState["duration"] = duration;
            ViewState["planName"] = planName;
        }
        else
        {
            start = (DateTime)ViewState["startDate"];
            duration = (int)ViewState["duration"];
            planName = ViewState["planName"] as string;
        }
    }



    /// <summary>
    /// Determines the date range for the campaign and updates the grids with appropriate columns.  BaselineDate, Range, & HeaderRowDetails page properties are set.
    /// </summary>
    List<int> buildDynamicOutput(bool allowEdit, bool showAsSummary, bool showCurrent)
    {
        DateTime start = DateTime.MinValue;
        int duration = 0;
        string planName;

        getCampaignTimeline(out start, out duration, out planName);

        lblPlanName.Text = planName;

        //hide checkbox when on summary or results
        if ( !allowEdit && (showAsSummary || showCurrent) )
        {
            gridViewDistricts.Columns[0].Visible = false;
            gridViewDistricts.ClientSettings.Scrolling.FrozenColumnsCount = 4;
        }
        else
            gridViewDistricts.ClientSettings.Scrolling.FrozenColumnsCount = 5;

        List<int> values = new List<int>();

        if ( duration > 0 )
        {
            GridTemplateColumn planCol = null;
            GridTemplateColumn districtCol = null;

            DateTime dt;
            string name;

            for ( int i = 0; i <= duration; i++ )
            {
                dt = start.AddMonths(i);

                values.Add((dt.Year * 100) + dt.Month);

                name = string.Format("{0:yyyy}{0:MM}", dt);

                if(i==0)
                    Page.ClientScript.RegisterHiddenField("startDateKey", name);
                
                if ( !showCurrent )
                {
                    //templates for only showing goals
                    planCol = Utility.AddColumn(gridView,  name, "~/controls/GoalsMonthHeaderTemplate.ascx", "~/controls/GoalsMonthTemplate.ascx");
                    districtCol = Utility.AddColumn(gridViewDistricts, name, "~/controls/GoalsMonthHeaderTemplate.ascx", "~/controls/GoalsMonthTemplate.ascx");
                }
                else
                {
                    //templates for showing goals and actual (current values)
                    planCol = Utility.AddColumn(gridView, name, "~/controls/GoalsMonthHeaderWithResultsTemplate.ascx", "~/controls/GoalsMonthWithResultsTemplate.ascx");
                    districtCol = Utility.AddColumn(gridViewDistricts, name, "~/controls/GoalsMonthHeaderWithResultsTemplate.ascx", "~/controls/GoalsMonthWithResultsTemplate.ascx");
                }
            }

            //if ( planCol != null ) planCol.HeaderStyle.Width = new Unit("120px");
            //if ( districtCol != null ) districtCol.HeaderStyle.Width = new Unit("300px");

        }

        return values;
    }

    /// <summary>
    /// Dynamically generates appropriate sql statements for both Plan and District level goals based on timeline.  Appropriate SQLDataSource objects will be updated by this function.
    /// </summary>
    /// <param name="allowEdit"></param>
    /// <param name="showAsSummary"></param>
    /// <param name="showCurrent"></param>
    void setDataSourceCommands(List<int> range, bool allowEdit, bool showAsSummary, bool showCurrent)
    {
        SQLUtil.MaxFragmentLength = 40;

        string baseLineViewForPlan;
        string baseLineViewForDistrict;
        
        //Determine Baseline Views
        if ( allowEdit ) //Viewing the Goals page in Step 1 after they have been saved to summary table
        {
            baseLineViewForPlan = "V_Campaign_Plan_Summary_Baseline";
            baseLineViewForDistrict = "V_Campaign_District_EditMode_Baseline";
        }
        else if ( showAsSummary || showCurrent ) //Viewing either Summary (Step 2) or Results (Step 4) page
        {
            baseLineViewForPlan = "V_Campaign_Plan_Summary_Baseline";
            baseLineViewForDistrict = "V_Campaign_District_Summary_Baseline";
        }
        else //Viewing Goals (Step 1) for the first time (summary data not saved yet - Phase ID is 3)
        {
            baseLineViewForPlan = "SV_Base_Plan";
            baseLineViewForDistrict = "V_Campaign_District_Baseline";
        }

        //Determine Goals View - (District_Name is same as District_ID but renamed because a name is used when representing all out of region districts)
        string mainViewForDistrict;
        //use summary goals for Summary and Results page OR when editing is not allowed - Goals are rolled up so only Targeted are displayed and non-targeted districts are rolled in with Out-of-Region districts
        if ( !allowEdit && (showAsSummary || showCurrent) )
            mainViewForDistrict = "V_Campaign_District_Plan_Goals_Summary";
        else //default view when opening Goals for first time or when editing - Goals are available for all districts in the plan region whether targeted or not
            mainViewForDistrict = "V_Campaign_District_Plan_Goals";

        //create dynamic sql for Plan/District level goals (reused later for Plan level)
        SQLPivotQuery<int> query = SQLPivotQuery<int>.Create(mainViewForDistrict, new string[] { "Campaign_ID", "Plan_ID", "Brand_ID", "RecordType", "District_Name", "InDistrict", "Start_Data_Key", "End_Data_Key" }, "Data_Key", range)
                .Pivot(SQLFunction.SUM, "Trx")
                .Pivot(SQLFunction.SUM, "MB_Trx")

                .InnerJoin ("V_Brands", "Brand_ID", "Brand_ID", "Brand_Name")

                .Join(new SQLLeftOuterJoin(new SQLTable(baseLineViewForDistrict, "Trx", "MB_Trx", "BaseRecordType", "Campaign_Flag_Indicator", "Data_Year", "Data_Month"))
                                    .AddRelation(new SQLRelation("Plan_ID", "Plan_ID"))
                                    .AddRelation(new SQLRelation("Brand_ID", "Brand_ID"))
                                    .AddRelation(new SQLRelation("RecordType", "BaseRecordType"))
                                    .AddRelation(new SQLRelation("District_Name", "District_Name"))
                                )
                .Where("Campaign_ID", "Campaign_ID", SQLOperator.EqualTo);
        
        if(showCurrent)
        {
            //add additional columns if showing results page
            query.Pivot(SQLFunction.SUM, "Curr_Trx");
            query.Pivot(SQLFunction.SUM, "Curr_MB_Trx");
        }

        //Need to filter out saved baseline data by campaign id - it was not added in join because it is simpler to code dynamic query this way
        if ( allowEdit || showAsSummary || showCurrent )
        {
            query.Where(baseLineViewForDistrict, "Campaign_ID", "Campaign_ID", SQLOperator.EqualTo);
        }
        
    
        //Create wrapper query for properly calculating baseline trx and mst - also calculating mst so it is correct on rolled up data
        StringBuilder sb = new StringBuilder();
        sb.Append("Select *");
        sb.Append(", case when BaseRecordType=1 then Trx else MB_Trx-Trx end as Trx");
        sb.Append(", case when MB_Trx = 0 then 0 else (convert(float,Trx)/convert(float,MB_Trx))*100 end as Mst");
        for ( int i = 0; i < range.Count; i++ )
        {
            //calculating Mst so rolled up data is correct
            sb.AppendFormat(",case when MB_Trx{0} > 0 then (convert(float,Trx{0})/convert(float,MB_Trx{0}))*100.0 else 0 end as Mst{0}", i);
            if ( showCurrent )
                sb.AppendFormat(",case when Curr_MB_Trx{0} > 0 then (convert(float,Curr_Trx{0})/convert(float,Curr_MB_Trx{0}))*100.0 else 0 end as Curr_Mst{0}", i);
        }
        sb.AppendFormat(" from ({0}) as resultsTable Order By InDistrict desc, District_Name, RecordType", query);
        //

        dsPlanDistrictGoals.SelectCommand = sb.ToString();


        //create dynamic sql for Plan level goals -        
        query = SQLPivotQuery<int>.Create("V_Campaign_Plan_Goals", new string[] { "Campaign_ID", "Plan_ID", "RecordType", "Brand_ID" }, "Data_Key", range)
                        .Pivot(SQLFunction.MAX, "Trx")
                        .Pivot(SQLFunction.MAX, "Mst")
                        
                        .InnerJoin("Plan_Mast", "Plan_ID", "Plan_ID", "Plan_Name")
                        .Join(new SQLLeftOuterJoin(new SQLTable(baseLineViewForPlan, "Brand_Trx", "MB_Trx", "Data_Year", "Data_Month"))
                                    .AddRelation(new SQLRelation("Plan_ID", "Plan_ID"))
                                    .AddRelation(new SQLRelation("Brand_ID", "Brand_ID"))
                                )

                        .InnerJoin("V_Brands", "Brand_ID", "Brand_ID", "Brand_Name")

                        .Where("Campaign_ID", "Campaign_ID", SQLOperator.EqualTo);

        //Need to filter out saved baseline data by campaign id - it was not added in join because it is simpler to code dynamic query this way
        if ( allowEdit || showAsSummary || showCurrent )
        {
            query.Where(baseLineViewForPlan, "Campaign_ID", "Campaign_ID", SQLOperator.EqualTo);
        }

        if ( showCurrent )
        {
            //add additional columns if showing results page
            query.Pivot(SQLFunction.MAX, "Curr_Trx");
            query.Pivot(SQLFunction.MAX, "Curr_Mst");
        }
        
        //Create wrapper query for calculating baseline trx and mst
        sb = new StringBuilder();
        sb.Append("Select *");
        sb.Append(", case when RecordType=1 then Brand_Trx else MB_Trx-Brand_Trx end as BaselineTrx");
        sb.Append(", case when MB_Trx > 0 then case when RecordType=1 then (convert(float,Brand_Trx)/convert(float,MB_Trx))*100 else (convert(float,MB_Trx-Brand_Trx)/convert(float,MB_Trx))*100 end else 0 end as BaselineMst");
        sb.AppendFormat(" from ({0}) as resultsTable Order By RecordType", query);
        //

        dsPlanGoals.SelectCommand = sb.ToString();
    }
}
