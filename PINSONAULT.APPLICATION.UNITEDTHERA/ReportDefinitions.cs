using System;
using System.Collections.Specialized;
using System.Linq;
using Pinsonault.Data;
using Pinsonault.Data.Reports;

namespace Pinsonault.Application.UnitedThera
{
    public class IssueReportDefinitionBase : ReportDefinition
    {
        protected override QueryDefinition CreateQueryDefinition(NameValueCollection filters)
        {
            return new IssueReportQueryDefinition(EntityTypeName, filters);
        }
    }

    public class IssueReportDefinition : IssueReportDefinitionBase
    {
        private NameValueCollection newFilters;

        protected override QueryDefinition CreateQueryDefinition(NameValueCollection filters)
        {
            using (PathfinderUnitedTheraEntities ctx = new PathfinderUnitedTheraEntities())
            {
                //get report IDs that contain selected products
                if (!string.IsNullOrEmpty(filters["Products_Discussed_ID"]))
                {
                    string product1 = "";
                    string product2 = "";
                    string product3 = "";
                    int[] IDs = null;
                    //split products ids into array
                    var prodIDs = filters["Products_Discussed_ID"].Split(',');
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
                    filters.Add("RC_Report_ID", stringIDs);
                    //remove products discussed
                    filters.Remove("Products_Discussed_ID");
                }
            }
            if(!string.IsNullOrEmpty(filters["Issue_ID"]))
                filters.Remove("Issue_ID");
            return base.CreateQueryDefinition(filters);
        }
    }

    public class DetailsReportDefinition : ReportDefinition
    {
        protected override QueryDefinition CreateQueryDefinition(NameValueCollection filters)
        {
            using (PathfinderUnitedTheraEntities ctx = new PathfinderUnitedTheraEntities())
            {
                //get report IDs that contain selected products
                if (!string.IsNullOrEmpty(filters["Products_Discussed_ID"]))
                {
                    string product1 = "";
                    string product2 = "";
                    string product3 = "";
                    int[] IDs = null;
                    //split products ids into array
                    var prodIDs = filters["Products_Discussed_ID"].Split(',');
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
                    filters.Add("RC_Report_ID", stringIDs);
                    //remove products discussed
                    filters.Remove("Products_Discussed_ID");
                }
            }
            return new DetailsQueryDefinition(this.EntityTypeName, filters);
        }
    }

    public class RCRDrilldownReportDefinition : ReportDefinition
    {
        protected override QueryDefinition CreateQueryDefinition(NameValueCollection filters)
        {
            using (PathfinderUnitedTheraEntities ctx = new PathfinderUnitedTheraEntities())
            {
                //get report IDs that contain selected products
                if (!string.IsNullOrEmpty(filters["Products_Discussed_ID"]))
                {
                    string product1 = "";
                    string product2 = "";
                    string product3 = "";
                    int[] IDs = null;
                    //split products ids into array
                    var prodIDs = filters["Products_Discussed_ID"].Split(',');
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
                    filters.Add("RC_Report_ID", stringIDs);
                    //remove products discussed
                    filters.Remove("Products_Discussed_ID");
                }
            }
            return new RCRDrilldownQueryDefinition(this.EntityTypeName, filters);
        }
    }

    public class PCNBINReportDefinition : ReportDefinition
    {
        protected override QueryDefinition CreateQueryDefinition(NameValueCollection filters)
        {   
            return new PCNBINReportQueryDefinition(this.EntityTypeName, filters);
        }
    }

}
