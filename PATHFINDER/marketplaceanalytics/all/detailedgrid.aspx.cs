﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Data;
using PathfinderModel;
using System.Collections;
using Pinsonault.Application.MarketplaceAnalytics;
using Pinsonault.Data;

public partial class marketplaceanalytics_all_detailedgrid : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        NameValueCollection queryValues = new NameValueCollection(Request.QueryString);
        string dataField = null;
        string tableName = null;
        IList<string> keys = new List<string>();
        string timeFrame;
        bool isMonth;
        string dataYear;
        int? productID = null;
        int rollup;
        IEnumerable<GenericDataRecord> g = null;

        //Add keys for query
        keys.Add("Product_ID");
        keys.Add("Drug_ID");
        keys.Add("Thera_ID");
        keys.Add("Segment_ID");
        keys.Add("Segment_Name");
        keys.Add("Geography_ID");
        keys.Add("Plan_ID");

        dataYear = queryValues["Year_Selection"];
        rollup = Convert.ToInt32(queryValues["Rollup_Type"]);

        int geographyType = Convert.ToInt32(queryValues["Geography_Type"]);

        if (!string.IsNullOrEmpty(queryValues["Product_ID"]))
        {
            if (queryValues["Product_ID"].IndexOf(',') == -1)
                productID = Convert.ToInt32(queryValues["Product_ID"]);
        }

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

                //If Account Manager is selected with no Top X Plans, filter by Territory
                if (geographyType == 3)
                    tableName = "MS_Monthly_By_Territory";
                else
                    tableName = "MS_Monthly";
            }
            else
            {
                timeFrame = queryValues["Quarter_Selection"]; //The timeframe is quarter based
                isMonth = false;
                dataField = "Data_Quarter";

                //If Account Manager is selected with no Top X Plans, filter by Territory
                if (geographyType == 3)
                    tableName = "MS_Quarterly_By_Territory";
                else
                    tableName = "MS_Quarterly";
            }
        }
        else
        {
            timeFrame = queryValues["Rolling_Selection"]; //The timeframe is rolling quarter based
            isMonth = false;
            dataField = "Data_Quarter";

            //If Account Manager is selected with no Top X Plans, filter by Territory
            if (geographyType == 3)
                tableName = "MS_Rolling_Quarterly_By_Territory";
            else
                tableName = "MS_Rolling_Quarterly";
        }

        MarketplaceAnalyticsProvider ma = new MarketplaceAnalyticsProvider();

        if (!string.IsNullOrEmpty(timeFrame))
        {
            //Add time frame values to a list for processing
            IList<int> timeFrameVals = new List<int>();
            if (timeFrame.IndexOf(',') > -1)
            {
                string[] timeFrameArr = timeFrame.Split(',');

                foreach (string s in timeFrameArr)
                    timeFrameVals.Add(Convert.ToInt32(s));
            }
            else
                timeFrameVals.Add(Convert.ToInt32(timeFrame));

            //Logic for Segment column - only show if 'Combined' option is selected
            if (queryValues["Section_ID"] != "-1")
                detailedGrid.Columns[3].Visible = false;

            //Hide Lives, Tier, Co-Pay and Restrictions columns if 'Employer' or 'Other' is selected
            if (queryValues["Section_ID"] == "14" || queryValues["Section_ID"] == "8")
            {
                detailedGrid.Columns[2].Visible = false;
                detailedGrid.Columns[5].Visible = false;
                detailedGrid.Columns[6].Visible = false;
                detailedGrid.Columns[7].Visible = false;
            }

            //Check if page count is needed
            bool getPageCount = false;
            NameValueCollection n = null;

            if ((!string.IsNullOrEmpty(queryValues["RequestPageCount"])) && (Convert.ToBoolean(queryValues["RequestPageCount"]) == true))
            {
                n = new NameValueCollection(queryValues);
                getPageCount = true;
                n["PagingEnabled"] = "false";
            }

            //Get data
            if (string.Compare(queryValues["Selection_Clicked"], "1") == 0)
            {
                g = ma.GetData(timeFrameVals, isMonth, dataYear, "US", tableName.Replace("_By_Territory", ""), dataField, keys, true, productID, queryValues);

                ma.ProcessGrid(detailedGrid, isMonth, g, timeFrameVals, queryValues);

                if (getPageCount)
                    g = ma.GetData(timeFrameVals, isMonth, dataYear, "US", tableName.Replace("_By_Territory", ""), dataField, keys, true, productID, n);
            }
            if (string.Compare(queryValues["Selection_Clicked"], "2") == 0)
            {
                string queryType = string.Empty;

                if (geographyType == 2)
                    queryType = "Region_ID";
                else
                    queryType = "Territory_ID";

                g = ma.GetData(timeFrameVals, isMonth, dataYear, queryValues[queryType], tableName, dataField, keys, true, productID, queryValues);

                ma.ProcessGrid(detailedGrid, isMonth, g, timeFrameVals, queryValues);

                if (getPageCount)
                    g = ma.GetData(timeFrameVals, isMonth, dataYear, queryValues[queryType], tableName, dataField, keys, true, productID, n);
            }
            if (string.Compare(queryValues["Selection_Clicked"], "3") == 0)
            {
                g = ma.GetData(timeFrameVals, isMonth, dataYear, queryValues["State_ID"], tableName, dataField, keys, true, productID, queryValues);

                ma.ProcessGrid(detailedGrid, isMonth, g, timeFrameVals, queryValues);

                if (getPageCount)
                    g = ma.GetData(timeFrameVals, isMonth, dataYear, queryValues["State_ID"], tableName, dataField, keys, true, productID, n);
            }
        }

        gridCount.Text = g.FirstOrDefault().GetValue(0).ToString();
    }

    protected void detailedGrid_PreRender(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;

        //This replaces <td> with <th> and adds the scope attribute
        gv.UseAccessibleHeader = true;

        //This will add the <thead> and <tbody> elements
        GridViewRow hdr = gv.HeaderRow;

        if (hdr != null)
            gv.HeaderRow.TableSection = TableRowSection.TableHeader;

    }

    protected void detailedGrid_DataBound(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;
        MarketplaceAnalyticsProvider ma = new MarketplaceAnalyticsProvider();

        //Specify column index that needs merging
        ma.GroupRows(gv, 3);
        ma.GroupRows(gv, 2);
        ma.GroupRows(gv, 1);
        ma.GroupRows(gv, 0);
    }

    protected string CheckRestriction(object PA, object QL, object ST)
    {
        IList<string> restrictions = new List<string>();

        if ((!string.IsNullOrEmpty(PA.ToString())))
            restrictions.Add("PA");
        if ((!string.IsNullOrEmpty(QL.ToString())))
            restrictions.Add("QL");
        if ((!string.IsNullOrEmpty(ST.ToString())))
            restrictions.Add("ST");

        string concatRestrictions = "";

        if (restrictions.Count > 0)
            concatRestrictions = string.Join(",", restrictions.ToArray());

        return concatRestrictions;
        //if ((!string.IsNullOrEmpty(restriction.ToString()) && Convert.ToBoolean(restriction) == true))
        //    return true;
        //else
        //    return false;
    }

}
