using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections.Specialized;
using System.Data.Common;
using Dundas.Charting.WebControl;
using Telerik.Web.UI;
using Pathfinder;
using Pinsonault.Data;
using Pinsonault.Application.UnitedThera;



public partial class custom_unitedthera_reimbursementchallengereport_all_issuereport : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

        RadGrid grid1 = (RadGrid)irData1.FindControl("dataProduct1").FindControl("gridIssueSummaryReport");
        
       NameValueCollection queryValues = new NameValueCollection(Request.QueryString);
        using (PathfinderUnitedTheraEntities ctx = new PathfinderUnitedTheraEntities())
        {
            IList<DbDataRecord> issueReportData = null;

            //get report IDs that contain selected products
            if(!string.IsNullOrEmpty(queryValues["Products_Discussed_ID"])){
                string product1 = "";
                string product2 = "";
                string product3 = "";
                int[] IDs = null;
                //split products ids into array
                var prodIDs = queryValues["Products_Discussed_ID"].Split(',');
                //maximum of 3 values
                product1 = prodIDs[0];
                if (prodIDs.Length == 2)
                    product2 = prodIDs[1];
                if (prodIDs.Length == 3)
                    product3 = prodIDs[2];

                //get list of Report IDs
                var list = (from id in ctx.RCReportIssueDetailsViewSet
                            where id.Products_Discussed_ID.Contains(product1) ||
                                    id.Products_Discussed_ID.Contains(product2) ||
                                    id.Products_Discussed_ID.Contains(product3)
                            orderby id.RC_Report_ID
                            select id.RC_Report_ID).ToList().Distinct();
                IDs = list.ToArray();

                string[] stringArray = new string[IDs.Length];
                for (int i = 0; i < IDs.Length; i++)
                {
                    stringArray[i] = IDs[i].ToString();
                }

                string stringIDs = string.Join(",", stringArray);
                //add Report IDS to query string
                queryValues.Add("RC_Report_ID", stringIDs);
                //remove products discussed
                queryValues.Remove("Products_Discussed_ID");
            }

            issueReportData = Pinsonault.Data.Generic.CreateGenericEntityQuery<Pinsonault.Application.UnitedThera.RCReportIssueSummaryView>(ctx, new IssueReportQueryDefinition("RCReportIssueSummaryView", queryValues)).ToList();
            
            if (issueReportData.Count > 0)
        {
            grid1.DataSource = issueReportData;
            grid1.DataBind();
        }


        }

    }

}