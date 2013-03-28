using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;
using Telerik.Web.UI;



/// <summary>
/// For common functions used in the application i.e. Email etc
/// </summary>
namespace Impact.Utility
{
    public class Utility
    {
        /// <summary>
        /// For sending the email
        /// </summary>
        /// <param name="strTo"></param>
        /// <param name="strFrom"></param>
        /// <param name="strSubject"></param>
        /// <param name="strBody"></param>
        /// <param name="Priority"></param>
        public static void SendEMail(string strTo, string strFrom, string strSubject, string strBody, MailPriority Priority)
        {
            SendEMail(strTo, null, strFrom, strSubject, strBody, Priority);
        }
        /// <summary>
        /// For sending the email with CC
        /// </summary>
        /// <param name="strTo"></param>
        /// <param name="strCC"></param>
        /// <param name="strFrom"></param>
        /// <param name="strSubject"></param>
        /// <param name="strBody"></param>
        /// <param name="Priority"></param>
        public static void SendEMail(string strTo, string strCC, string strFrom, string strSubject, string strBody, MailPriority Priority)
        {
            MailMessage msg = new MailMessage(strFrom, strTo, strSubject, strBody);
            if (!string.IsNullOrEmpty(strCC))
                msg.CC.Add(strCC);
            msg.Priority = Priority;
                      
            SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SmtpHost"]);
            smtp.Send(msg);
        }
        /// <summary>
        /// For getting the Admin Email address
        /// </summary>
        /// <returns></returns>
        public static string GetAdminEmail()
        {
            string strAdminEmailList = "";
            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
           
            DataTable dtAdminEmail = SqlHelper.ExecuteDataset(cn, "usp_GetAdminEMail").Tables[0];
            int iCount;
            for (iCount = 0; iCount < dtAdminEmail.Rows.Count; iCount++ )
            {
                strAdminEmailList = strAdminEmailList + dtAdminEmail.Rows[iCount]["EMail"].ToString() + ",";
            }
            return strAdminEmailList;            
        }
        /// <summary>
        /// For getting the user's email address
        /// </summary>
        /// <param name="iUserID"></param>
        /// <returns></returns>
        public static string GetUserEmail(int iUserID)
        {
            string strUserEmail = "";

            SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString);
            
            SqlParameter[] arParams = new SqlParameter[1];
            arParams[0] = new SqlParameter("@User_ID", iUserID);
            
            strUserEmail = SqlHelper.ExecuteDataset(cn, "usp_GetUserEMail", arParams).Tables[0].Rows[0]["EMail"].ToString();

            return strUserEmail;                     
        }


        /// <summary>
        /// helper function to properly add a column dynamically to a Telerik RadGrid
        /// </summary>
        /// <param name="grid">Telerik RadGrid that a column is added to.</param>
        /// <param name="headerTemplate">URL of a control to use as the theader template.</param>
        /// <param name="dataTemplate">URL of a control to use for a data item's template</param>
        public static GridTemplateColumn AddColumn(RadGrid grid, string name, string headerTemplate, string dataTemplate)
        {
            GridTemplateColumn column = null;

            column = grid.Columns.FindByUniqueNameSafe(name) as GridTemplateColumn;
            if ( column == null )
            {
                //must add column to collection before setting properties
                column = new GridTemplateColumn();
                grid.Columns.Add(column);

                column.UniqueName = name;
            }
            column.HeaderTemplate = grid.Page.LoadTemplate(headerTemplate);
            column.ItemTemplate = grid.Page.LoadTemplate(dataTemplate);
            //column.HeaderStyle.Width = 100;
            //column.ItemStyle.Width = 100;

            return column;
        }

    }
}