using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.Sql;
using System.Data.SqlClient;
using System.ComponentModel;
using Telerik.Web.UI;
using Dundas.Charting.WebControl;

public partial class CampaignOpportunityAssessments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        int campaignid = Convert.ToInt32(Request.QueryString["id"].ToString());
        int brandcount = GetCompetetorBrandnum(campaignid);
        buildDynamicColumns(brandcount);
        GridView1.DataBind();
        Build_Bubble_Chart(campaignid);
      
    }
    void buildDynamicColumns(int total_Brands)
    {

        GridTemplateColumn column;
        string name;
        //hide existing columns since they may not be needed

        for (int i = 5; i < GridView1.Columns.Count; i++)
        {
            GridView1.Columns[i].Visible = false;
        }

        //make sure template columns are generated for each brand and set visible

        for (int i = total_Brands + 1; i > 0; i--)
        {

            name = string.Format("brand{0}", i);
            column = Impact.Utility.Utility.AddColumn(GridView1, name, "~/controls/opportunityBrandHeaderTemplate.ascx", "~/controls/opportunityBrandTemplate.ascx");
            column.Visible = true;

        }

    }
    public void Build_Bubble_Chart(int campaign_id)
    {
        Chart1.Series["Novo Brand"].Type = SeriesChartType.Bubble;
        //Chart1.Series["Novo Brand"].Color = System.Drawing.Color.Red;  //for all bubble in the series
        Chart1.Series["Novo Brand"].MarkerStyle = (MarkerStyle)MarkerStyle.Parse(typeof(MarkerStyle), "Circle");
        Chart1.Series["Novo Brand"].YValuesPerPoint = 2;
        Chart1.Series["Novo Brand"]["LabelStyle"] = "center";
        Chart1.ChartAreas[0].AxisY.LabelStyle.Format = "0,000";

        //**************** Custom Legend Section *********************
        // Create new custom legend item.
        LegendItem customLegendItem1 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem1.Style = LegendImageStyle.Marker;
        customLegendItem1.Color = System.Drawing.Color.SkyBlue;
        customLegendItem1.MarkerSize = 50;
        customLegendItem1.Name = "1st Tier";
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem1);

        // Create new custom legend item.
        LegendItem customLegendItem2 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem2.Style = LegendImageStyle.Marker;
        customLegendItem2.Color = System.Drawing.Color.Green;
        customLegendItem2.MarkerSize = 50;
        customLegendItem2.Name = "2nd Tier";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem2);

        // Create new custom legend item.
        LegendItem customLegendItem3 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem3.Style = LegendImageStyle.Marker;
        customLegendItem3.Color = System.Drawing.Color.Yellow;
        customLegendItem3.MarkerSize = 50;
        customLegendItem3.Name = "3rd Tier";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem3);

        // Create new custom legend item.
        LegendItem customLegendItem4 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem4.Style = LegendImageStyle.Marker;
        customLegendItem4.Color = System.Drawing.Color.Purple;
        customLegendItem4.MarkerSize = 50;
        customLegendItem4.Name = "4th Tier";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem4);

        // Create new custom legend item.
        LegendItem customLegendItem5 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem5.Style = LegendImageStyle.Marker;
        customLegendItem5.Color = System.Drawing.Color.Pink;
        customLegendItem5.MarkerSize = 50;
        customLegendItem5.Name = "5th Tier";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem5);

        // Create new custom legend item.
        LegendItem customLegendItem6 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem6.Style = LegendImageStyle.Marker;
        customLegendItem6.Color = System.Drawing.Color.Brown;
        customLegendItem6.MarkerSize = 50;
        customLegendItem6.Name = "Medical";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem6);

        // Create new custom legend item.
        LegendItem customLegendItem7 = new LegendItem();
        // Set the style and color of the custom legend item.
        customLegendItem7.Style = LegendImageStyle.Marker;
        customLegendItem7.Color = System.Drawing.Color.Red;
        customLegendItem7.MarkerSize = 50;
        customLegendItem7.Name = "Not Covered";
        // Add this custom legend item to the chart.
        Chart1.Legends["Legend1"].CustomItems.Add(customLegendItem7);
        //*************************************************************************

        SqlDataReader MyReader;
        // Create Instance of Connection and Command Object
        SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
        SqlCommand myCommand = new SqlCommand("usp_Get_Campaign_Opportunity_Data_Archived", myConnection);

        // Mark the Command as a SPROC
        myCommand.CommandType = CommandType.StoredProcedure;
        // Add Parameters to SPROC

        SqlParameter parameter_campaign_id = new SqlParameter("@Campaign_ID", SqlDbType.Int, 4);
        parameter_campaign_id.Value = campaign_id;
        myCommand.Parameters.Add(parameter_campaign_id);

       

        try
        {
            myConnection.Open();
            MyReader = myCommand.ExecuteReader();
            //Chart1.Series["Novo Brand"].Points.DataBind(MyReader, "X", "Y,Z", "Label=L");
            // X for X Axle, Y for Y Axle, Z for Bubble size and L for Bubble's text Label
            //Chart1.Series["Novo Brand"].Points.DataBind(MyReader, "BMST0", "MB_Trx,Pharmacy_Lives", "Label=Ranking");

            Series NVSeries = Chart1.Series["Novo Brand"];
            DataPoint Bubblepoint;

            if (MyReader.HasRows)
            {

                while (MyReader.Read())
                {
                    if (MyReader["BMST0"] != null && MyReader["MB_Trx"] != null && MyReader["BTX0"] != null)
                    {
                        string xvalue = MyReader["BMST0"].ToString();
                        string yvalue = MyReader["MB_Trx"].ToString();
                        //string zvalue = MyReader["BTX0"].ToString();
                        string zvalue = MyReader["Pharmacy_Lives"].ToString();
                        

                        //string zvalue = MyReader["Pharmacy_Lives"].ToString();
                        Bubblepoint = NVSeries.Points[NVSeries.Points.AddXY(xvalue, yvalue, zvalue)];
                        // BMST0 for X Axle, MB_Trx for Y Axle, Pharmacy_Lives for Bubble size
                                               
                        Bubblepoint.Label = MyReader["Ranking"].ToString();
                        Bubblepoint.ToolTip = "Rank:" + MyReader["Ranking"].ToString() + " Covered Lives:" + String.Format("{0:0,000}", MyReader["Pharmacy_Lives"]);

                        if (MyReader["Tier0"].ToString() == "1")
                        {
                            Bubblepoint.Color = System.Drawing.Color.SkyBlue;
                        }
                        else if (MyReader["Tier0"].ToString() == "2")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Green;
                        }
                        else if (MyReader["Tier0"].ToString() == "3")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Yellow;
                        }
                        else if (MyReader["Tier0"].ToString() == "4")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Purple;
                        }
                        else if (MyReader["Tier0"].ToString() == "5")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Pink;
                        }
                        else if (MyReader["Tier0"].ToString() == "F")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Brown;
                        }
                        else if (MyReader["Tier0"].ToString() == "M")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Brown;
                        }
                        else if (MyReader["Tier0"].ToString() == "NC")
                        {
                            Bubblepoint.Color = System.Drawing.Color.Red;
                        }
                        else
                        {
                            Bubblepoint.Color = System.Drawing.Color.White;
                        }

                    }
                }
            }
            myConnection.Close();

        }
        finally
        {
            if (myConnection != null) myConnection.Dispose();
            if (myCommand != null) myCommand.Dispose();

        }
    }
    public int GetCompetetorBrandnum(int Campaignid)
    {
        // Create Instance of Connection and Command Object
        SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
        SqlCommand myCommand = new SqlCommand("usp_GetCompetetorBrandnum", myConnection);

        // Mark the Command as a SPROC
        myCommand.CommandType = CommandType.StoredProcedure;

        SqlParameter parameter_Campaignid = new SqlParameter("@Campaign_ID", SqlDbType.Int, 4);
        parameter_Campaignid.Value = Campaignid;
        myCommand.Parameters.Add(parameter_Campaignid);

        SqlParameter parameterBrandID = new SqlParameter("@Brand_Count", SqlDbType.Int, 4);
        parameterBrandID.Direction = ParameterDirection.Output;
        myCommand.Parameters.Add(parameterBrandID);

        try
        {
            myConnection.Open();
            myCommand.ExecuteNonQuery();
            myConnection.Close();
            // Calculate the CustomerID using Output Param from SPROC
            int BrandId = (int)parameterBrandID.Value;

            return BrandId;
        }
        finally
        {
            if (myConnection != null) myConnection.Dispose();
            if (myCommand != null) myCommand.Dispose();
        }
    }
}
