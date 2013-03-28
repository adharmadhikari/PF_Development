using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Web.UI;
using Microsoft.Office.Interop.Excel;
using Excel = Microsoft.Office.Interop.Excel;
using System.Diagnostics;
using System.Configuration;
using System.Data;
using log4net;
using System.Collections.Specialized;
using Impact;
using System.Data.SqlClient;

namespace Impact
{
    /// <summary>
    /// Standard reports Excel exporter.
    /// Transforms input to a shared document template using specialized formatting logic.
    /// This class is thread safe.
    /// </summary>
    public class StandardExcelExporter : ExcelExporter
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(StandardExcelExporter));

        /// <summary>
        /// Excel template file to use. This can be in XLS, XLSX, or XLT format.
        /// IMPORTANT: Note that when this file changes, CreateExcelFile() function needs to match what the file contains.
        /// </summary>
        private readonly String _templateFile;

        /// <summary>
        /// Row offset where column header names appear
        /// </summary>
        private readonly int _columnHeaderRowOffset = 2;

        public StandardExcelExporter()
        {
            HttpContext ctx = HttpContext.Current;
            if (ctx == null)
            {
                log.Error("Unable to obtain current HttpContext.");
                throw new ArgumentException("Unable to obtain current HttpContext");
            }

            _templateFile = ctx.Request.MapPath(
                Path.Combine(
                    ctx.Request.ApplicationPath,
                    "ExcelTemplates/StandardExcelExporter_Template.xlt")
                .Replace(@"\", "/"));
            log.Debug(String.Format("Using Excel template file \"{0}\".", _templateFile));
        }

        private void UpdateHeaders(Excel.Worksheet worksheet, string ReportName, string strHeader)
        {
            log.Debug("Updating headers...");

            worksheet.Name = ReportName;
            string strExcelCriteria = strHeader;
            log.Debug(String.Concat("Report criteria:\n", strExcelCriteria));
            ((TextBox)worksheet.TextBoxes(1)).Text = strExcelCriteria;
        }
               
        /// <summary>
        /// for getting the column name in excel as per the cell number
        /// </summary>
        /// <param name="intCol"></param>
        /// <returns>ColumnName</returns>
        static string ColumnName(int intCol)
        {
            int dividend = intCol ;
            if (dividend == 0)
                dividend = 1;
            string columnName = String.Empty; 
            int modulo; 
         
            while (dividend > 0) 
            { 
                modulo = (dividend - 1) % 26; 
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName; 
                dividend = (int)((dividend - modulo) / 26); 
            }           
            return columnName; 
        }

        /// <summary>
        /// Formats an alphanumeric cell name based on the given integer x/y coordinates.
        /// </summary>
        /// <param name="row"></param>
        /// <param name="col"></param>
        /// <returns></returns>
        private static String FormatCellName(int row, int col)
        {           
            return String.Concat(ColumnName(col), row);
        }
        /// <summary>
        /// insert the image in excel sheet
        /// </summary>
        /// <param name="worksheet">Worksheet</param>
        /// <param name="strImagePath">Image Path</param>
        /// <param name="Width">Image Width</param>
        /// <param name="Height">Image Height</param>
        private void InsertImage(Excel.Worksheet worksheet, string strImagePath, float Width,float Height)
        {
            log.Debug("Inserting image...");
            worksheet.Shapes.AddPicture(
                strImagePath,
                Microsoft.Office.Core.MsoTriState.msoFalse,
                Microsoft.Office.Core.MsoTriState.msoTrue,
                0F,
                160F,
                Width,   
                Height);
        }
        /// <summary>
        /// this function inserts the records in to excel sheet from a datatable
        /// </summary>
        /// <param name="worksheet">Worksheet</param>
        /// <param name="dtReportTable">report datatable</param>
        private void UpdateTable(Excel.Worksheet worksheet, System.Data.DataTable dtReportTable)
        {
            log.Debug("Table compilation started.");
            DateTime startTime = DateTime.Now;

            // Populate and style column headers
            int y = 0;

            Excel.Range range = worksheet.get_Range(
               FormatCellName(_columnHeaderRowOffset, 0),
               FormatCellName(_columnHeaderRowOffset, dtReportTable.Columns.Count - 1));
            range.WrapText = true;
            
            Object[,] cells = new Object[1, dtReportTable.Columns.Count];
           
            for (int iColumn = 0; iColumn < dtReportTable.Columns.Count; iColumn++)
            {
                cells[0, y] = dtReportTable.Columns[iColumn].ColumnName;
                if (dtReportTable.Columns[iColumn] != null)
                {
                    // Width adjustment needs to be made to column.
                    string cellName = FormatCellName(_columnHeaderRowOffset, y);
                    Excel.Range cell = worksheet.get_Range(cellName, cellName);
                  
                    Marshal.ReleaseComObject(cell);
                }
                y++;
            }
            range.set_Value(Missing.Value, cells);
            range.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.LightGray);
            range.Borders.Color = ColorTranslator.ToWin32(Color.FromArgb(51, 51, 153));
            Marshal.ReleaseComObject(range);

            // Populate and style rows
            int x = 0, rowBeginOffset = _columnHeaderRowOffset + 1;
            int totalCount = 0;
            for (int iRow = 0; iRow < dtReportTable.Rows.Count; iRow++)
            {
                ++totalCount;

                range = worksheet.get_Range(
                    FormatCellName(rowBeginOffset, 0),
                    FormatCellName(rowBeginOffset + totalCount, dtReportTable.Columns.Count - 1));
                cells = new Object[rowBeginOffset + totalCount, dtReportTable.Columns.Count];
            }
            for (int iRow = 0; iRow < dtReportTable.Rows.Count; iRow++)
            {
                ++x;
                y = 0;               
                for(int iCol = 0 ; iCol< dtReportTable.Columns.Count ; iCol++)
                {
                    cells[x - 1, y++] = dtReportTable.Rows[iRow].ItemArray[iCol]; //propValue;
                }
            }
            range.set_Value(Missing.Value, cells);
            range.WrapText = true;
            range.Borders.Color = ColorTranslator.ToWin32(Color.Black);
            Marshal.ReleaseComObject(range);

            TimeSpan interval = startTime - DateTime.Now;
            log.Debug(String.Format("Table compilation completed in {0}.", interval));
        }
        private void UpdateTableFormatted(Excel.Worksheet worksheet, System.Data.DataTable dtReportTable, IList<int> MonthListDesc, int iReportType, System.Data.DataTable dtReportSummary)
        {
            try
            {
                log.Debug("Table compilation started.");
                DateTime startTime = DateTime.Now;
                int icolumnHeaderRowOffset = _columnHeaderRowOffset;

                int iHeaderRow1 = 0; //Optional first row for header (used in report summary and details)
                int iHeaderRow2 = 0; //Optional second row for header (used in report summary and details)
                int iHeaderRowTableColumns = 1; //Header row having translated column name; applicable for all reports 

                switch (iReportType)
                {
                    case 1: //Report Summary
                        iHeaderRow1 = 1;
                        iHeaderRow2 = 0;
                        iHeaderRowTableColumns = 2;
                        break;
                    case 2: //Report Details
                        iHeaderRow1 = 1;
                        iHeaderRow2 = 2;
                        iHeaderRowTableColumns = 3;
                        break;

                }
                //get the translated name of required columns from Lkp_Excel_ImpactReportTemplate table
                System.Data.DataTable dtRequiredReportTable_Columns = Campaign.Campaign.GetReportTemplate(iReportType, iHeaderRowTableColumns);

                Excel.Range range = worksheet.get_Range(
                      FormatCellName(icolumnHeaderRowOffset, 0),
                      FormatCellName(icolumnHeaderRowOffset, dtRequiredReportTable_Columns.Rows.Count));
                range.WrapText = true;

                Object[,] cells = new Object[1, dtRequiredReportTable_Columns.Rows.Count];

                int y = 0;
                //enter first header row
                #region first row having text populated from DB and if month populated from list - MonthListDesc
                if (iHeaderRow1 > 0)
                {

                    System.Data.DataTable dtReportTemplateRow1 = Campaign.Campaign.GetReportTemplate(iReportType, iHeaderRow1);
                    int iMonthCount = 0;

                    for (int iRow = 0; iRow < dtReportTemplateRow1.Rows.Count; iRow++)
                    {
                        string strColumnName = dtReportTemplateRow1.Rows[iRow]["Column_DBName"].ToString();
                        int iCellspan = Convert.ToInt32(dtReportTemplateRow1.Rows[iRow]["CellSpan"]) - 1;
                        //make a list for Column_DB_Name and pass it to report table
                        string strTranslatedName = dtReportTemplateRow1.Rows[iRow]["Column_TranslatedName"].ToString();


                        if (dtReportTable.Columns[strColumnName] != null)
                        {
                            cells[0, y] = strTranslatedName;
                            // Width adjustment needs to be made to column.                    
                            string cellName = FormatCellName(icolumnHeaderRowOffset, y + 1);

                            string cellName_Extended = FormatCellName(icolumnHeaderRowOffset, y + iCellspan + 1);
                            Excel.Range cell = worksheet.get_Range(cellName, cellName_Extended);
                            if (iCellspan > 0)
                            {
                                cell.HorizontalAlignment = 7;//text is aligned in center of the cell
                                cell.MergeCells = true;
                            }
                            Marshal.ReleaseComObject(cell);
                            y = y + iCellspan;
                        }

                        else if (strColumnName.Contains("month") && y < dtRequiredReportTable_Columns.Rows.Count && iMonthCount < MonthListDesc.Count)
                        {
                            strTranslatedName = MonthListDesc[iMonthCount].ToString().Substring(4, 2) + "/" + MonthListDesc[iMonthCount].ToString().Substring(0, 4);
                            cells[0, y] = strTranslatedName;
                            iMonthCount++;

                            string cellName = FormatCellName(icolumnHeaderRowOffset, y + 1);

                            string cellName_Extended = FormatCellName(icolumnHeaderRowOffset, y + iCellspan + 1);
                            Excel.Range cell = worksheet.get_Range(cellName, cellName_Extended);
                            cell.NumberFormat = "mmm-yy";

                            if (iCellspan > 0)
                            {
                                cell.HorizontalAlignment = 7;//text is aligned in center of the cell
                                cell.MergeCells = true;
                            }

                            Marshal.ReleaseComObject(cell);
                            y = y + iCellspan;
                        }
                        y++;
                    }

                    range.set_Value(Missing.Value, cells);
                    range.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.LightGray);
                    range.Borders.Color = ColorTranslator.ToWin32(Color.FromArgb(51, 51, 153));
                    range.Font.Bold = true;
                    Marshal.ReleaseComObject(range);

                    dtReportTemplateRow1.Dispose();

                    icolumnHeaderRowOffset++;
                }
                #endregion

                #region Row 2 Header Row --for report details
                //optional row for Details
                //int icolumnHeaderRowOffset = 3;          
                if (iHeaderRow2 > 0)
                {
                    y = 0;
                    range = worksheet.get_Range(
                    FormatCellName(icolumnHeaderRowOffset, 0),
                    FormatCellName(icolumnHeaderRowOffset, dtRequiredReportTable_Columns.Rows.Count));
                    range.WrapText = true;

                    cells = new Object[icolumnHeaderRowOffset, dtRequiredReportTable_Columns.Rows.Count];

                    System.Data.DataTable dtReportDetailsHeaderRow = Campaign.Campaign.GetReportTemplate(iReportType, iHeaderRow2);

                    for (int iRow = 0; iRow < dtReportDetailsHeaderRow.Rows.Count; iRow++)
                    {
                        string strColumnName = dtReportDetailsHeaderRow.Rows[iRow]["Column_DBName"].ToString();
                        int iCellspan = Convert.ToInt32(dtReportDetailsHeaderRow.Rows[iRow]["CellSpan"]) - 1;
                        //make a list for Column_DB_Name and pass it to report table
                        string strTranslatedName = dtReportDetailsHeaderRow.Rows[iRow]["Column_TranslatedName"].ToString();

                        if (dtReportTable.Columns[strColumnName] != null)
                        {
                            cells[0, y] = strTranslatedName;

                            string cellName = FormatCellName(icolumnHeaderRowOffset, y + 1);
                            string cellName_Extended = FormatCellName(icolumnHeaderRowOffset, y + iCellspan + 1);

                            Excel.Range cell = worksheet.get_Range(cellName, cellName_Extended);
                            if (iCellspan > 0)
                            {
                                cell.HorizontalAlignment = 7; //text is aligned in center of the cell
                                cell.MergeCells = true;
                            }
                            Marshal.ReleaseComObject(cell);
                            y = y + iCellspan;
                        }
                        y++;
                    }
                    range.set_Value(Missing.Value, cells);
                    range.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.LightGray);
                    range.Borders.Color = ColorTranslator.ToWin32(Color.FromArgb(51, 51, 153));
                    range.Font.Bold = true;
                    Marshal.ReleaseComObject(range);
                    dtReportDetailsHeaderRow.Dispose();
                    icolumnHeaderRowOffset++;
                }
                #endregion

                #region row for db column's translated name
                //insert required db column's translated name in the row

                range = worksheet.get_Range(
                FormatCellName(icolumnHeaderRowOffset, 0),
                FormatCellName(icolumnHeaderRowOffset, dtRequiredReportTable_Columns.Rows.Count));
                range.WrapText = true;

                cells = new Object[icolumnHeaderRowOffset, dtRequiredReportTable_Columns.Rows.Count];

                y = 0;
                for (int iRow = 0; iRow < dtRequiredReportTable_Columns.Rows.Count; iRow++)
                {
                    string strColumnName = dtRequiredReportTable_Columns.Rows[iRow]["Column_DBName"].ToString();

                    //make a list for Column_DB_Name and pass it to report table
                    string strTranslatedName = dtRequiredReportTable_Columns.Rows[iRow]["Column_TranslatedName"].ToString();

                    cells[0, y] = strTranslatedName;
                    if (!string.IsNullOrEmpty(dtRequiredReportTable_Columns.Rows[iRow]["Width"].ToString()))
                    {
                        string cellName = FormatCellName(_columnHeaderRowOffset + 1, y + 1);
                        Excel.Range cell = worksheet.get_Range(cellName, cellName);
                        cell.ColumnWidth = dtRequiredReportTable_Columns.Rows[iRow]["Width"].ToString();
                        Marshal.ReleaseComObject(cell);
                    }
                    y++;
                }
                range.set_Value(Missing.Value, cells);
                range.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.LightGray);
                range.Borders.Color = ColorTranslator.ToWin32(Color.FromArgb(51, 51, 153));
                range.Font.Bold = true;
                Marshal.ReleaseComObject(range);
                icolumnHeaderRowOffset++;
                #endregion
                #region populate rows from database
                // Populate and style rows
                int x = 0, rowBeginOffset = icolumnHeaderRowOffset;
                int totalCount = 0;
                range = worksheet.get_Range(
                FormatCellName(rowBeginOffset, 0),
                FormatCellName(rowBeginOffset, dtRequiredReportTable_Columns.Rows.Count));
                range.WrapText = true;
                if (iReportType == 2)
                {
                    int iRowCount = 0;//dtReportTable.Rows.Count + dtReportSummary.Rows.Count;
                    for (int i = 0; i < dtReportSummary.Rows.Count; i++)
                    {
                        iRowCount = iRowCount + 1;
                        string strCampaignID = dtReportSummary.Rows[i]["Campaign_ID"].ToString();
                            string strFilterString = string.Format(" Campaign_ID = {0} ", strCampaignID);
                        System.Data.DataTable dtFilterTable = FilterTable(dtReportTable, strFilterString);
                        iRowCount = iRowCount + dtFilterTable.Rows.Count;
                    }
                   
                    for (int iRow = 0; iRow < iRowCount; iRow++)
                    {
                        ++totalCount;

                        range = worksheet.get_Range(
                            FormatCellName(rowBeginOffset, 0),
                            FormatCellName(rowBeginOffset + totalCount, dtRequiredReportTable_Columns.Rows.Count));
                        cells = new Object[rowBeginOffset + totalCount, dtRequiredReportTable_Columns.Rows.Count];
                    }
                }
                else
                {
                    for (int iRow = 0; iRow < dtReportTable.Rows.Count; iRow++)
                    {
                        ++totalCount;

                        range = worksheet.get_Range(
                            FormatCellName(rowBeginOffset, 0),
                            FormatCellName(rowBeginOffset + totalCount, dtRequiredReportTable_Columns.Rows.Count));
                        cells = new Object[rowBeginOffset + totalCount, dtRequiredReportTable_Columns.Rows.Count];
                    }
                }
                totalCount = 0;
                //Report for Impact Report Details , Report TypeID = 2
                if (iReportType == 2 && !(dtReportSummary == null))
                {
                    //insert report summary
                    for (int iRowSummary = 0; iRowSummary < dtReportSummary.Rows.Count; iRowSummary++)
                    {
                        ++x;
                        y = 0;
                        string strCampaignID = dtReportSummary.Rows[iRowSummary]["Campaign_ID"].ToString();

                        //check all the required columns in report table and insert the row
                        for (int iCol = 0; iCol < dtRequiredReportTable_Columns.Rows.Count; iCol++)
                        {
                            string strReportColName = dtRequiredReportTable_Columns.Rows[iCol]["Column_DBName"].ToString();
                            string strFormat = dtRequiredReportTable_Columns.Rows[iCol]["DataFormat"].ToString();

                            //make the report summary record's cell font - bold
                            Excel.Range rangeSummary = worksheet.get_Range(
                                   FormatCellName(rowBeginOffset + totalCount, 0),
                                   FormatCellName(rowBeginOffset + totalCount, dtRequiredReportTable_Columns.Rows.Count));
                            rangeSummary.Font.Bold = true;
                            Marshal.ReleaseComObject(rangeSummary);

                            //insert the summary table records
                            if (dtReportSummary.Columns[strReportColName] != null)
                            {
                                try
                                {
                                    if (!string.IsNullOrEmpty(strFormat))
                                        cells[x - 1, iCol] = String.Format(strFormat, dtReportSummary.Rows[iRowSummary][strReportColName]);
                                    else
                                        cells[x - 1, iCol] = dtReportSummary.Rows[iRowSummary][strReportColName];
                                }
                                catch (FormatException)
                                {
                                    cells[x - 1, iCol] = dtReportSummary.Rows[iRowSummary][strReportColName];
                                }
                                catch
                                { }
                            }
                            //if Required DB Column Name = Actual_District_Name, insert the Plan Name for showing the Plan level details 
                            //, all districts name will be added in the next row through districtdetails table (dtReportTable)
                            else if (strReportColName == "Actual_District_Name")
                                cells[x - 1, iCol] = dtReportSummary.Rows[iRowSummary]["Plan_Name"];
                            else
                                cells[x - 1, iCol] = "";

                        }

                        string strFilterString = string.Format(" Campaign_ID = {0} ", strCampaignID);
                        System.Data.DataTable dtFilterTable = FilterTable(dtReportTable, strFilterString);
                        //now insert the report district details
                        for (int iRow = 0; iRow < dtFilterTable.Rows.Count; iRow++)
                        {
                            ++x;
                            y = 0;

                            bool bColorGoalPercent = true;
                            for (int iColDetails = 0; iColDetails < dtRequiredReportTable_Columns.Rows.Count; iColDetails++)
                            {
                                string strReportDetailsColName = dtRequiredReportTable_Columns.Rows[iColDetails]["Column_DBName"].ToString();
                                string strFormat = dtRequiredReportTable_Columns.Rows[iColDetails]["DataFormat"].ToString();

                                string cellName = FormatCellName(rowBeginOffset + totalCount + 1, iColDetails + 1);
                                Excel.Range cell = worksheet.get_Range(cellName, cellName);

                                if (dtFilterTable.Columns[strReportDetailsColName] != null && strReportDetailsColName != "Campaign_ID")
                                {
                                    try
                                    {
                                        if (!string.IsNullOrEmpty(strFormat))
                                            cells[x - 1, iColDetails] = String.Format(strFormat, dtFilterTable.Rows[iRow][strReportDetailsColName]);
                                        else
                                            cells[x - 1, iColDetails] = dtFilterTable.Rows[iRow][strReportDetailsColName];
                                    }
                                    catch (FormatException)
                                    {
                                        cells[x - 1, iColDetails] = dtFilterTable.Rows[iRow][strReportDetailsColName];
                                    }
                                    catch
                                    { }

                                    //color the cells for Goal Percent for most recent record i.e. if the cell is not colored before
                                    if (bColorGoalPercent && (strReportDetailsColName == "Result_GoalPercent" || strReportDetailsColName.Contains("Curr_Trx_GoalPercent")))
                                    {
                                        if (!string.IsNullOrEmpty(dtFilterTable.Rows[iRow][strReportDetailsColName].ToString()))
                                        {
                                            bColorGoalPercent = false;
                                            if (Convert.ToInt32(dtFilterTable.Rows[iRow][strReportDetailsColName]) >= 100)
                                                cell.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Green);
                                            else if (Convert.ToInt32(dtFilterTable.Rows[iRow][strReportDetailsColName]) >= 90)
                                                cell.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Yellow);
                                            else
                                                cell.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
                                        }
                                    }
                                    Marshal.ReleaseComObject(cell);
                                }
                                //keep the cell blank to prevent the same campaign id in each row
                                else if (dtFilterTable.Columns[strReportDetailsColName] != null && strReportDetailsColName == "Campaign_ID")
                                    cells[x - 1, iColDetails] = "";
                            }
                            totalCount++;
                        }
                        ++totalCount;
                    }

                    //end of report district details

                }

                //for other reports except report district details report
                else
                {
                    for (int iRow = 0; iRow < dtReportTable.Rows.Count; iRow++)
                    {
                        ++x;
                        y = 0;
                        //bool bColorGoalPercent = true;
                        for (int iCol = 0; iCol < dtRequiredReportTable_Columns.Rows.Count; iCol++)
                        {
                            string strReportColName = dtRequiredReportTable_Columns.Rows[iCol]["Column_DBName"].ToString();
                            string strFormat = dtRequiredReportTable_Columns.Rows[iCol]["DataFormat"].ToString();

                            if (dtReportTable.Columns[strReportColName] != null)
                            {
                                try
                                {
                                    if (!string.IsNullOrEmpty(strFormat))
                                        cells[x - 1, iCol] = String.Format(strFormat, dtReportTable.Rows[iRow][strReportColName]);
                                    else
                                        cells[x - 1, iCol] = dtReportTable.Rows[iRow][strReportColName];
                                }
                                catch (FormatException)
                                {
                                    cells[x - 1, iCol] = dtReportTable.Rows[iRow][strReportColName];
                                }
                                catch
                                { }
                            }
                        }
                        ++totalCount;
                    }
                }//end of else
                range.set_Value(Missing.Value, cells);
                range.WrapText = true;
                range.Borders.Color = ColorTranslator.ToWin32(Color.Black);
                Marshal.ReleaseComObject(range);
                dtRequiredReportTable_Columns.Dispose();
                dtReportTable.Dispose();
                #endregion

                TimeSpan interval = startTime - DateTime.Now;
                log.Debug(String.Format("Table compilation completed in {0}.", interval));
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
        
        //for getting the filtered datatable
        public System.Data.DataTable FilterTable(System.Data.DataTable dt, string filterString)
        {
            DataRow[] filteredRows = dt.Select(filterString);
            System.Data.DataTable filteredDt = dt.Clone();

            DataRow dr;
            foreach (DataRow oldDr in filteredRows)
            {
                dr = filteredDt.NewRow();
                for (int i = 0; i < dt.Columns.Count; i++)
                    if (dt.Columns[i].ColumnName != "Plan_Name" && dt.Columns[i].ColumnName != "AEName" && dt.Columns[i].ColumnName != "Brand_Name"
                        && dt.Columns[i].ColumnName != "Start_Date" && dt.Columns[i].ColumnName != "End_Date" && dt.Columns[i].ColumnName != "Campaign_ID")
                    dr[dt.Columns[i].ColumnName] = oldDr[dt.Columns[i].ColumnName];
                filteredDt.Rows.Add(dr);

            }

            return filteredDt;
        }

        private void UpdateProtection(Excel.Worksheet worksheet)
        {
            if (ProtectOutputFile)
            {
                // Generate a random password.
                String password = Guid.NewGuid().ToString();
                log.Debug(String.Format("Protecting report with password \"{0}\".", password));

                // Restrict operations, and require a password to perform them.
                worksheet.Protect(password, Missing.Value, Missing.Value, Missing.Value,
                    false,      
                    true,       
                    true,       
                    true,       
                    false,      
                    false,      
                    false,      
                    false,      
                    false,      
                    true,       
                    true,       
                    false);     
            }
        }
        
        /// <summary>
        /// for formatted output
        /// </summary>
        /// <param name="strHeader"></param>
        /// <param name="strReportName"></param>
        /// <param name="dsReportSet"></param>
        /// <param name="QueryString"></param>
        /// <returns></returns>
        public override string ExportToFileWithFormat(string strHeader, string strReportName, DataSet dsReportSet, NameValueCollection QueryString, IList<int> MonthListDesc, int iReportType, System.Data.DataTable dtReportSummary)
        {
            try
            {
                // Acquire app from pool.
                Excel.Application app = ExcelApp;

                // Ensure thread safety.
                lock (app)
                {
                    string tempPath = ConfigurationManager.AppSettings["TempFolder"];
                    if (string.IsNullOrEmpty(tempPath) || !Directory.Exists(tempPath))
                        System.IO.Directory.CreateDirectory(tempPath);

                    //throw new ArgumentException("TempFolder does not exist or has not been specified in AppSettings section of web.config.  Please specify a temporary folder for generating excel files that is not a system directory.");

                    // Generate a random report file name (.xls)
                    string result = Path.Combine(tempPath, String.Concat("XR-", Guid.NewGuid().ToString().ToUpper(), ".xls"));

                    // Open the template workbook and get its default worksheet
                    Excel.Workbook workbook = ExcelApp.Workbooks.Open(_templateFile,
                        Missing.Value, true, Missing.Value, Missing.Value, Missing.Value,
                        Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value,
                        Missing.Value, Missing.Value, Missing.Value, Missing.Value);

                    Excel.Worksheet worksheet = (Excel.Worksheet)workbook.ActiveSheet;

                    int index = 1;
                    //IList<NameValueCollection> images = Impact.FileExport.ExtractImagesFromRequest(QueryString);

                    //foreach (NameValueCollection image in images)
                    //{
                    //    worksheet = (Excel.Worksheet)workbook.Sheets[index];
                    //    //update worksheet name
                    //    worksheet.Name = string.Format("chart{0}", index);

                    //    InsertImage(worksheet, image["path"], float.Parse(image["Width"]), float.Parse(image["Height"]));
                    //    workbook.Sheets.Add(Missing.Value, worksheet, 1, _templateFile);
                    //    index++;
                    //}

                    for (int i = 0; i < dsReportSet.Tables.Count; i++)
                    {
                        worksheet = (Excel.Worksheet)workbook.Sheets[index];
                        //update worksheet name and report criteria on top of excel sheet
                        UpdateHeaders(worksheet, strReportName, strHeader);
                        //insert the dataset records in excel
                        UpdateTableFormatted(worksheet, dsReportSet.Tables[i], MonthListDesc, iReportType, dtReportSummary);
                        workbook.Sheets.Add(Missing.Value, worksheet, 1, _templateFile);
                        index++;
                    }
                    // Document write protection
                    UpdateProtection(worksheet);

                    Marshal.ReleaseComObject(worksheet);

                    ((Excel.Worksheet)workbook.Sheets[1]).Activate();


                    // Save new document to disk
                    workbook.Author = Resources.Resource.Assembly_CompanyName;
                    workbook.SaveCopyAs(result);
                    workbook.Close(false, Missing.Value, Missing.Value);

                    Marshal.ReleaseComObject(workbook);

                    return result;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex.Message);
                throw ex;
            }
            finally
            {
                ReleaseExcelApp();
            }
        }
      
    }

}
