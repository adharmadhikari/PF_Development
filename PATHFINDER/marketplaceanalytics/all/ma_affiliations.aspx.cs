﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Dundas.Charting.WebControl;
using System.Collections.Specialized;
using System.Data;
using PathfinderModel;
using PathfinderClientModel;
using Pinsonault.Application.MarketplaceAnalytics;
using Pinsonault.Data;

public partial class marketplaceanalytics_all_affiliations : PageBase
{
    string dataField = null;
    string tableName = null;
    string planLevelTableName = null;
    IList<string> keys = new List<string>();
    IList<string> planKeys = new List<string>();

    protected void Page_Load(object sender, EventArgs e)
    {
        //Find Grids and Charts
        GridView grid1 = (GridView)chart.FindControl("grid1").FindControl("gridTemplate");
        GridView grid2 = (GridView)chart.FindControl("grid2").FindControl("gridTemplate");
        GridView grid3 = (GridView)chart.FindControl("grid3").FindControl("gridTemplate");

        Chart chart1 = (Chart)chart.FindControl("chartDisplay1").FindControl("chart");
        Chart chart2 = (Chart)chart.FindControl("chartDisplay2").FindControl("chart");
        Chart chart3 = (Chart)chart.FindControl("chartDisplay3").FindControl("chart");

        chart1.Visible = false;
        chart2.Visible = false;
        chart3.Visible = false;

        NameValueCollection queryValues = new NameValueCollection(Request.QueryString);

        string timeFrame;
        bool isMonth;
        string dataYear;
        //DataSet ds = new DataSet();
        IEnumerable<GenericDataRecord> g = null;
        IList<int> timeFrameVals = new List<int>();

        //Add keys for query
        keys.Add("Product_ID");
        keys.Add("Drug_ID");
        keys.Add("Thera_ID");
        //keys.Add("Segment_ID");
        //keys.Add("Data_Year");
        //keys.Add("Product_Name");
        //keys.Add("Geography_ID");

        //add keys for plan level details
        planKeys.Add("Product_ID");
        //planKeys.Add("Drug_ID");        
        //keys.Add("Data_Year");
        //keys.Add("Product_Name");
        
        dataYear = queryValues["Year_Selection"];

        //Check which type of timeframe to query by as well as Calendar or Rolling
        if (string.Compare(queryValues["Calendar_Rolling"], "Calendar", true) == 0)
        {
            //Add year to keys
            keys.Add("Data_Year");

            //Calendar
            if (string.IsNullOrEmpty(queryValues["Quarter_Selection"]))
            {
                timeFrame = queryValues["Month_Selection"]; //The timeframe is month based
                isMonth = true;
                dataField = "Data_Month";
                //tableName = "MS_Monthly";
                tableName = "V_MS_Monthly_PlanSummary";
                planLevelTableName = "V_MS_Monthly_PlanSummary";//"V_MS_PlanAffiliation";//"MS_Monthly_Base";
            }
            else
            {
                timeFrame = queryValues["Quarter_Selection"]; //The timeframe is quarter based
                isMonth = false;
                dataField = "Data_Quarter";
                //tableName = "MS_Quarterly";
                tableName = "V_MS_Quarterly_PlanSummary";
                planLevelTableName = "V_MS_Quarterly_PlanSummary";
            }
        }
        else
        { 
            timeFrame = queryValues["Rolling_Selection"]; //The timeframe is rolling quarter based
            isMonth = false;
            dataField = "Data_Quarter";
            //tableName = "MS_Rolling_Quarterly";
            tableName = "V_MS_Rolling_Quart_PlanSummary";
            planLevelTableName = "V_MS_Rolling_Quart_PlanSummary";
        }

        MarketplaceAnalyticsProvider ma = new MarketplaceAnalyticsProvider();

        if (!string.IsNullOrEmpty(timeFrame))
        {
            //Add time frame values to a list for processing
            if (timeFrame.IndexOf(',') > -1)
            {
                string[] timeFrameArr = timeFrame.Split(',');

                foreach (string s in timeFrameArr)
                    timeFrameVals.Add(Convert.ToInt32(s));
            }
            else
                timeFrameVals.Add(Convert.ToInt32(timeFrame));
               
                // include the flag if report needs affilation report logic
            queryValues.Add("Is_AffilationReport", "1");

                //Get National data
                //g = ma.GetData(timeFrameVals, isMonth, dataYear, "US", tableName, dataField, keys, false, null, queryValues);
            g = ma.GetPlanData(timeFrameVals, isMonth, dataYear, tableName, dataField, planKeys, false, null, queryValues, true);

            if (g.Count() > 0)
            {
                chart1.Visible = true;
                ma.ProcessGrid(grid1, isMonth, g, timeFrameVals, queryValues);
                ma.ProcessChart(timeFrameVals, chart1, isMonth, g, "affiliation", dataYear, queryValues);
            }

            //Get plan level data
            g = ma.GetPlanData(timeFrameVals, isMonth, dataYear, planLevelTableName, dataField, planKeys, false, null, queryValues, false);

            if (g.Count() > 0)
            {
                chart2.Visible = true;
                ma.ProcessGrid(grid2, isMonth, g, timeFrameVals, queryValues);
                ma.ProcessChart(timeFrameVals, chart2, isMonth, g, "affiliation", dataYear, queryValues);
            }           
          
        }
    }
}
