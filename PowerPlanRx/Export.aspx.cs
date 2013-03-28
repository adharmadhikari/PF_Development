using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Reflection;
using System.Configuration;
using System.Data;
using Impact.Campaign;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;
using System.Collections.Specialized;

/// <summary>
/// This page is being used for excel export and pdf export functionality. 
/// </summary>

public partial class Export : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext.Current.Response.AddHeader("p3p", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");

        try
        {
            string strFileName = "";
            //get the cookie's name and value 
            string strCookieName = "", strCookieValue = "";
            strCookieName = Request.Cookies[".POWERPLANRX"].Name;
            strCookieValue = Request.Cookies[".POWERPLANRX"].Value;

            //get the server and port for local url
            string strServerName = Request.ServerVariables["LOCAL_ADDR"];
            string strPort = Request.ServerVariables["SERVER_PORT"];

            string strPagename = Request.QueryString["page"].ToString().ToLower();
            string strExportType = Request.QueryString["type"].ToString().ToLower();

            switch (strPagename)
            {
                case "districtprofiletrxchart":
                    {
                        if (strExportType == "pdf")
                        {
                            strFileName = "BrandSharedVolume";

                            string strUrl = string.Format("http://{0}:{1}{2}?{3}"
                                                                        , strServerName
                                                                        , strPort
                                                                        , Request.Url.AbsolutePath.Replace("Export.aspx", "DistrictProfileTrxChartPDF.aspx")
                                                                        , Request.QueryString);
                            Impact.FileExport.ExportToPDF(strUrl, strCookieName, strCookieValue, strFileName);
                        }
                    }
                    break;


                case "districtregionbrandreport":
                    {
                        if (strExportType == "pdf")
                        {
                            strFileName = "DistrictRegionProfileReport";

                            string strUrl = string.Format("http://{0}:{1}{2}?{3}"
                                                                        , strServerName
                                                                        , strPort
                                                                        , Request.Url.AbsolutePath.Replace("Export.aspx", "DistrictRegionBrandReportPDF.aspx")
                                                                        , Request.QueryString);
                            Impact.FileExport.ExportToPDF(strUrl, strCookieName, strCookieValue, strFileName);
                        }
                        else if (strExportType == "excel")
                        {
                            string strReportName = "District Region Profile Report";
                            string strHeader = string.Empty;
                            SortedList slReportCriteria = new SortedList();

                            DataSet dsReport = Campaign.dsSVBaseByRegionDistrictSegmentBrandID(Request.QueryString["reporttype"].ToString(), Request.QueryString["regionid"].ToString(), Request.QueryString["dist"].ToString(), Convert.ToInt32((Request.QueryString["brandid"]).ToString()), Convert.ToInt32((Request.QueryString["segment"]).ToString()));
                            HttpContext ctx = HttpContext.Current;

                            DataRow drReport = dsReport.Tables[0].Rows[0];

                            if (Request.QueryString["dist"].ToString() == "0")
                            {
                                slReportCriteria.Add("Region", drReport["Region_ID"].ToString() + " " + drReport["Region_Name"].ToString());
                            }
                            else
                            {
                                slReportCriteria.Add("District", drReport["District_ID"].ToString() + " " + drReport["District_Name"].ToString());
                            }
                            slReportCriteria.Add("Brand", drReport["Brand_Name"].ToString());
                            slReportCriteria.Add("Segment", drReport["Segment_Name"].ToString());

                            strHeader = Impact.FileExport.GetCriteriaDetails("District Region Profile Report", Impact.FileExport.ReportType.Excel, slReportCriteria);

                            if (Request.QueryString["reporttype"].ToString() == "1")
                            {
                                if (Request.QueryString["dist"].ToString() == "0")
                                {

                                    Impact.FileExport.ExportExcelForReport(ctx, strReportName, dsReport, strHeader, Request.QueryString, null, (int)Impact.FileExport.ExcelReportType.RegionSingleBrand, null);
                                }
                                else
                                {
                                    Impact.FileExport.ExportExcelForReport(ctx, strReportName, dsReport, strHeader, Request.QueryString, null, (int)Impact.FileExport.ExcelReportType.DistrictSingleBrand, null);
                                }
                            }
                            else
                            {
                                if (Request.QueryString["dist"].ToString() == "0")
                                {
                                    Impact.FileExport.ExportExcelForReport(ctx, strReportName, dsReport, strHeader, Request.QueryString, null, (int)Impact.FileExport.ExcelReportType.RegionGroup, null);
                                }
                                else
                                {
                                    Impact.FileExport.ExportExcelForReport(ctx, strReportName, dsReport, strHeader, Request.QueryString, null, (int)Impact.FileExport.ExcelReportType.DistrictGroup, null);
                                }
                            }

                        }
                    }
                    break;

                case "physicians":
                    {
                        if (strExportType == "pdf")
                        {
                            strFileName = "PhysiciansList";

                            string strUrl = string.Format("http://{0}:{1}{2}?{3}"
                                                   , strServerName
                                                   , strPort
                                                   , Request.Url.AbsolutePath.Replace("Export.aspx", "PhysiciansPDF.aspx")
                                                   , Request.QueryString);

                            Impact.FileExport.ExportToPDF(strUrl, strCookieName, strCookieValue, strFileName);
                        }
                        else if (strExportType == "excel")
                        {
                            string strReportName = "Physicians List";
                            string strHeader = string.Empty;
                            SortedList slReportCriteria = new SortedList();

                            DataSet dsPhys = Campaign.GetPhysList(Request.QueryString["dist"].ToString(), Convert.ToInt32(Request.QueryString["id"]));
                            HttpContext ctx = HttpContext.Current;

                            DataRow drPhys = dsPhys.Tables[0].Rows[0];
                            slReportCriteria.Add("District", drPhys["District_ID"].ToString() + " " + drPhys["District_Name"].ToString());
                            slReportCriteria.Add("Brand", drPhys["Brand_Name"].ToString());
                            slReportCriteria.Add("Plan Name", drPhys["Plan_Name"].ToString());

                            slReportCriteria.Add("Data Month", string.Format("{0}/{1}", drPhys["Data_Month"].ToString(), drPhys["Data_Year"].ToString()));

                            strHeader = Impact.FileExport.GetCriteriaDetails("Physician List", Impact.FileExport.ReportType.Excel, slReportCriteria);

                            Impact.FileExport.ExportExcelForReport(ctx, strReportName, dsPhys, strHeader, Request.QueryString, null, (int)Impact.FileExport.ExcelReportType.PhysicianList, null);
                        }
                    }
                    break;
            }
           

            
           
        }
        catch(Exception ex)
        {
            //handle exception
            throw ex;
        }
          
    }   
}
