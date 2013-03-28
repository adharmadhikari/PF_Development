using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dundas.Charting.WebControl;
using System.Data;
using Impact.Campaign;

public partial class controls_DistrictRegionProfileChart : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["segment"].ToString() == "1")
        {
            BindCommercialChart();
        }
        else
        {
            BindPartDChart();
        }
        
        
    }
    /// <summary>
    /// For binding the district profile chart for a given brand in commercial segment
    /// </summary>
    private void BindCommercialChart()
    {
        DataTable dtComm = Campaign.GetSVBaseByRegionDistrictSegmentBrandID(Request.QueryString["reporttype"].ToString(), Request.QueryString["regionid"].ToString(), Request.QueryString["dist"].ToString(), Convert.ToInt32((Request.QueryString["brandid"]).ToString()), Convert.ToInt32((Request.QueryString["segment"]).ToString()));

        if (dtComm.Rows.Count > 0)
        {
            ChartComm.DataSource = dtComm;

            //Add chart title
            if (Request.QueryString["dist"].ToString() != "0")
            {
                ChartComm.Titles.Add("Top 20 " + dtComm.Rows[0]["Segment_Name"].ToString() + " Accounts in the District: " + dtComm.Rows[0]["District_Name"].ToString());

            }
            else
            {
                ChartComm.Titles.Add("Top 20 " + dtComm.Rows[0]["Segment_Name"].ToString() + " Accounts in the Region: " + dtComm.Rows[0]["Region_Name"].ToString());
            }

            Series series = ChartComm.Series[0];

            DataPoint point;

            string strXValue;
            string strYValue;

            for (int i = 0; i < dtComm.Rows.Count; i++)
            {
                if (Request.QueryString["dist"].ToString() != "0")
                {
                    strXValue = dtComm.Rows[i]["Plan_Name"].ToString() + " " + string.Format("{0:N2}", dtComm.Rows[i]["PercentBrandTrxDistrictTotal"]) + "%";
                    strYValue = dtComm.Rows[i]["PercentBrandTrxDistrictTotal"].ToString();
                }
                else
                {
                    strXValue = dtComm.Rows[i]["Plan_Name"].ToString() + " " + string.Format("{0:N2}", dtComm.Rows[i]["PercentBrandTrxRegionTotal"]) + "%";
                    strYValue = dtComm.Rows[i]["PercentBrandTrxRegionTotal"].ToString();
                }
                

                point = series.Points[series.Points.AddXY(strXValue, strYValue)];

                //make points as exploded to get the exploded chart
                point["Exploded"] = "true";

                //provide tooltip for each point
                point.ToolTip = strXValue;
            }
            //apply chart color
            ChartComm.ApplyPaletteColors();

            //color the point labels with correspond slice color
            foreach (DataPoint p in series.Points)
            {
                p.LabelBackColor = p.Color;
            }
        }
        dtComm.Dispose();
    }
    /// <summary>
    /// For binding the district profile chart for a given brand in commercial segment
    /// </summary>
    private void BindPartDChart()
    {

        DataTable dtPartD = Campaign.GetSVBaseByRegionDistrictSegmentBrandID(Request.QueryString["reporttype"].ToString(), Request.QueryString["regionid"].ToString(), Request.QueryString["dist"].ToString(), Convert.ToInt32((Request.QueryString["brandid"]).ToString()), Convert.ToInt32((Request.QueryString["segment"]).ToString()));

        if (dtPartD.Rows.Count > 0)
        {
            ChartPartD.DataSource = dtPartD;

            //Add chart title
            if (Request.QueryString["dist"].ToString() != "0")
            {
                ChartPartD.Titles.Add("Top 20 " + dtPartD.Rows[0]["Segment_Name"].ToString() + " Accounts in the District: " + dtPartD.Rows[0]["District_Name"].ToString());

            }
            else
            {
                ChartPartD.Titles.Add("Top 20 " + dtPartD.Rows[0]["Segment_Name"].ToString() + " Accounts in the Region: " + dtPartD.Rows[0]["Region_Name"].ToString());
            }

            Series series = ChartPartD.Series[0];

            DataPoint point;

            string strXValue;
            string strYValue;

            for (int i = 0; i < dtPartD.Rows.Count; i++)
            {
                if (Request.QueryString["dist"].ToString() != "0")
                {
                    strXValue = dtPartD.Rows[i]["Plan_Name"].ToString() + " " + string.Format("{0:N2}", dtPartD.Rows[i]["PercentBrandTrxDistrictTotal"]) + "%";
                    strYValue = dtPartD.Rows[i]["PercentBrandTrxDistrictTotal"].ToString();
                }
                else
                {
                    strXValue = dtPartD.Rows[i]["Plan_Name"].ToString() + " " + string.Format("{0:N2}", dtPartD.Rows[i]["PercentBrandTrxRegionTotal"]) + "%";
                    strYValue = dtPartD.Rows[i]["PercentBrandTrxRegionTotal"].ToString();
                }
                

                point = series.Points[series.Points.AddXY(strXValue, strYValue)];

                //make points as exploded to get the exploded chart
                point["Exploded"] = "true";

                //provide tooltip for each point
                point.ToolTip = strXValue;
            }
            //apply chart color
            ChartPartD.ApplyPaletteColors();

            //color the point labels with correspond slice color
            foreach (DataPoint p in series.Points)
            {
                p.LabelBackColor = p.Color;
            }

        }
        dtPartD.Dispose();

    }

}
