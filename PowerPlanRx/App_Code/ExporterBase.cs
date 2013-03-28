using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Specialized;
using System.Collections;
using System.Reflection;
using System.Web.UI;
using System.Text;
using System.Data;

namespace Impact
{
   
    /// <summary>
    /// Summary description for ExporterBase
    /// </summary>
    public abstract class ExporterBase : IDisposable
    {
        public ExporterBase()
        {
            ReportDate = DateTime.Now;
            ProtectOutputFile = false;
        }
        ~ExporterBase()
        {
            Dispose(false);
        }

        /// <summary>
        /// Report title (Optional)
        /// </summary>
        /// <remarks>
        /// Shows up in template's header block.
        /// </remarks>
        public String Title { get; set; }
             
        private bool _disposed = false;

        /// <summary>
        /// Reporting date/time (Optional; Defaults date/time of instantiation.)
        /// </summary>
        /// <remarks>
        /// Shows up in template's header block.
        /// </remarks>
        public DateTime ReportDate { get; set; }

        /// <summary>
        /// Write protect the data in the output file?
        /// </summary>
        /// <remarks>
        /// Setting this will protect the document by generating and setting a random password on it when
        /// data manipulation is performed. Formatting/styling is still allowed.
        /// </remarks>
        public bool ProtectOutputFile { get; set; }
        
    /// <summary>
    /// Creates an instance of an appropriate Excel exporter and instantiates it with column mappings and data.
    /// </summary>
    /// <typeparam name="T">Specialized type of exporter to create.</typeparam>
    /// <param name="strReportName">Report Name</param>
    /// <param name="ds">Report Data Set</param>
    /// <returns></returns>
        public static ExporterBase CreateInstance<T>(String strReportName, DataSet ds) where T : ExporterBase
        {           
            ExporterBase exporter = null;           
           
            try
            {
                // Instantiate exporter
                exporter = (ExporterBase)Activator.CreateInstance<T>();

                if (exporter != null)
                {
                    exporter.Title = strReportName;                                    
                }
                return exporter;
            }
            finally
            {
               
            }
        }
        
        public abstract string ExportToFileWithFormat(string strHeader, string strReportName, DataSet dsReportSet, NameValueCollection QueryString, IList<int> MonthListDesc, int iReportType, DataTable dtReportSummary);
       
        #region IDisposable Members

        void IDisposable.Dispose()
        {
            Dispose(true);
        }
        protected void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    GC.SuppressFinalize(this);
                }

                _disposed = true;
            }
        }

        #endregion
    }
}