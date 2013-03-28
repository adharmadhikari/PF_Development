using System;
using Dundas.Charting.WebControl;
using System.Configuration;
using System.IO;
using System.Data;
using Impact.Campaign;

public partial class controls_DistrictProfile_PartD : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {        
         DataTable dtComm = Campaign.GetSVBaseByDistrictSegmentBrandID(Request.QueryString["dist"].ToString(), Convert.ToInt32((Request.QueryString["brandid"]).ToString()), (int)SegmentID.PartD);

        if (dtComm.Rows.Count > 0)
        {
            ChartPartD.DataSource = dtComm;

            //Add chart title
            ChartPartD.Titles.Add("Top 20 Medicare Part D Accounts in the District: " + dtComm.Rows[0]["District_Name"].ToString());
            Series series = ChartPartD.Series[0];
            
            DataPoint point;

            string strXValue;
            string strYValue;
           
            for (int i = 0; i < dtComm.Rows.Count; i++)
            {
                strXValue = dtComm.Rows[i]["Plan_Name"].ToString()+ " "  + string.Format("{0:N2}",dtComm.Rows[i]["PercentBrandTrxDistrictTotal"]) + "%";
                strYValue = dtComm.Rows[i]["PercentBrandTrxDistrictTotal"].ToString();

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
        dtComm.Dispose();
    }
}
