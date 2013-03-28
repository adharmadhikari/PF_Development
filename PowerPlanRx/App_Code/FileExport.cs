using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Persits.PDF;
using System.IO;
using System.Data;
using System.Collections;
using System.Web.UI;
using System.Text;
using System.Collections.Specialized;

namespace Impact
{
    /// <summary>
    /// This class has different methods for FileExport i.e. PDF export etc.
    /// </summary>
    public class FileExport
    {
        public enum ReportType
        {
            Print,
            Excel,
            PDF
        }
        public enum ExcelReportType
        {
           Summary = 1,
           Details = 2,
           PhysicianList = 3,
           RegionSingleBrand = 4,
           DistrictSingleBrand = 5,
           RegionGroup = 6,
           DistrictGroup = 7

        }
        /// <summary>
        /// For exporting a PDF file from a given url
        /// </summary>
        /// <param name="strUrl"></param>
        /// <param name="strCookieName"></param>
        /// <param name="strCookieValue"></param>
        /// <param name="strFileName"></param>
        public static void ExportToPDF(string strUrl, string strCookieName, string strCookieValue, string strFileName)
        {
            PdfManager objPdf = new PdfManager();
            PdfDocument objDoc = objPdf.CreateDocument();
           
            objDoc.ImportFromUrl(strUrl, "landscape=true,LeftMargin=36,RightMargin=36,TopMargin=36,BottomMargin=36", "Cookie:" + strCookieName, strCookieValue);

            objDoc.SaveHttp("attachment;filename=" + strFileName + ".pdf");
        }   
        public static void ExportExcelForReport(HttpContext context, string strReportName, DataSet dsReportSet, string strHeader, NameValueCollection QueryString, IList<int> MonthListDesc, int iReportType, DataTable dtReportSummary)
        {
            HttpRequest request = context.Request;
            HttpResponse response = context.Response;
            
            try
            {
                using (ExporterBase exporter = ExporterBase.CreateInstance<StandardExcelExporter>(strReportName, dsReportSet))
                {
                    exporter.ProtectOutputFile = true;
                    String outputFile = exporter.ExportToFileWithFormat(strHeader, strReportName, dsReportSet, QueryString, MonthListDesc, iReportType, dtReportSummary);

                    // Send response data and headers
                    response.ContentType = "application/x-excel";
                    response.AddHeader("Content-Disposition",
                        String.Format("attachment; filename=\"{0}-{1}.xls\"",
                            strReportName, Guid.NewGuid().ToString()));
                    response.AddHeader("Pragma", "no-cache");
                    response.TransmitFile(outputFile);

                    // Direct calls to File.Delete can cause hangs.
                    AppShutdownExecutor.Enqueue(
                        delegate()
                        {
                            File.Delete(outputFile);
                        }
                    );
                }
            }
            catch (Exception ex)
            {
                //handle exception
            }

            finally { }
        }
        /// <summary>
        /// for exporting an excel file with file name
        /// </summary>
        /// <param name="context"></param>
        /// <param name="outputFile">file name, which needs to be displayed with path info</param>
        /// <param name="strReportName">sample report name</param>
        public static void ExportExcelWithFileName(HttpContext context, string outputFile, string strReportName)
        {
            HttpRequest request = context.Request;
            HttpResponse response = context.Response;

            try
            {       
                // Send response data and headers
                response.ContentType = "application/x-excel";
                response.AddHeader("Content-Disposition",
                        String.Format("attachment; filename=\"{0}-{1}.xls\"",
                            strReportName, Guid.NewGuid().ToString()));
                response.AddHeader("Pragma", "no-cache");
                response.TransmitFile(outputFile);

                // Direct calls to File.Delete can cause hangs.
                AppShutdownExecutor.Enqueue(
                    delegate()
                    {
                        File.Delete(outputFile);
                    }
                );
                
            }
            catch (Exception ex)
            {
                //handle exception
            }

            finally { }
        }

        /// <summary>
        /// This function gives the Report Criteria as per the report type in string format. It is being used for getting report headers.
        /// </summary>
        /// <param name="Title"></param>
        /// <param name="rptType"></param>       
        /// <param name="slCriteriaList"></param>
        /// <returns></returns>
       
        public static string GetCriteriaDetails(string Title, ReportType rptType, SortedList slCriteriaList)
        {
            const String divider = ";  ";
            string strLineBreak = "\n";
            if (rptType == ReportType.Print)
            {
                strLineBreak = "<br/>";
            }
            StringBuilder header = new StringBuilder();
            header.Append("Report Details" + strLineBreak);

            // Title/Name
            String documentTitle = String.IsNullOrEmpty(Title) ? "Untitled" : Title;

            header.Append(String.Format("Name - {0} {1}", documentTitle, strLineBreak));

            // Criteria
            if (slCriteriaList.Keys.Count > 0)
            {
                StringBuilder criteriaBuilder = new StringBuilder();

                for (int iListItem = 0; iListItem < slCriteriaList.Keys.Count ; iListItem++)
                {
                    criteriaBuilder.Append(slCriteriaList.GetKey(iListItem));
                    criteriaBuilder.Append(": ");
                    criteriaBuilder.Append(slCriteriaList[slCriteriaList.GetKey(iListItem)]);
                    criteriaBuilder.Append(divider);
                    criteriaBuilder.Append(strLineBreak);
                }
                if (criteriaBuilder.Length - divider.Length >= divider.Length)
                    criteriaBuilder.Remove(criteriaBuilder.Length - divider.Length, divider.Length);
                header.Append(String.Format("Criteria - {0} {1}", criteriaBuilder.ToString(), strLineBreak));
            }           
            return header.ToString();
        }
        /// <summary>
        /// This function is for getting all the information related with all images (querystring having img(index) from querystring
        /// we need to pass image url, width and height in querystring
        /// </summary>
        /// <param name="request"></param>
        /// <returns>name value collection for images properties like url, Width, Height</returns>
        public static IList<NameValueCollection> ExtractImagesFromRequest(NameValueCollection request)
        {
            List<NameValueCollection> data = new List<NameValueCollection>();
            NameValueCollection col;
            Uri uri;

            string formData = null;
            int i = 0;

            while (i == 0 || formData != null)
            {
                formData = request[string.Format("img{0}", i)];
                if (!string.IsNullOrEmpty(formData))
                {
                    col = HttpUtility.ParseQueryString(formData);
                    if (!string.IsNullOrEmpty(col["url"]))
                    {
                        uri = new Uri(col["url"]);
                        col["path"] = HttpContext.Current.Server.MapPath(uri.LocalPath);

                        if (string.IsNullOrEmpty(col["Width"]))
                            col["Width"] = "900";
                        if (string.IsNullOrEmpty(col["Height"]))
                            col["Height"] = "300";

                        data.Add(col);
                    }
                }
                i++;
            }

            return data;
        }
    }
}
