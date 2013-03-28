using System.Data.Services;
using System.ServiceModel.Web;
using System.Text;
using PathfinderClientModel;
using System.Linq;
using System.Web;
using System;
using System.Data.Objects;
using System.Linq.Expressions;
using System.Collections.Specialized;
using System.Collections.Generic;
using Pinsonault.Web.Services;

namespace Pinsonault.Application.UnitedThera
{
    public class UnitedTheraDataService : PathfinderDataServiceBase<PathfinderUnitedTheraEntities>
    {
        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(IDataServiceConfiguration config)
        {
            Pinsonault.Web.Support.InitializeService(config);
            config.SetEntitySetAccessRule("PlanGridSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportsSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportProductsDiscussedViewSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportIssueSummaryViewSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportIssueDetailsViewSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportDrilldownViewSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("RCReportPlanDocumentsSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("AccountManagersByTerritoryViewSet", EntitySetRights.AllRead);
            config.SetEntitySetAccessRule("PCNBINReportViewSet", EntitySetRights.AllRead);

        }


        #region Query Interceptors
        [QueryInterceptor("RCReportDrilldownViewSet")]
        public Expression<Func<RCReportDrilldownView, bool>> FilterDrilldownByProducts()
        {
            string product1 = "";
            string product2 = "";
            string product3 = "";
            if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["Products_Discussed_ID"]))
            {
                string products = HttpContext.Current.Request.QueryString["Products_Discussed_ID"];
                string[] productList = products.Split(',');

                if (productList.Length == 0 || productList.Length == 3)
                {
                    product1 = productList[0];
                    product2 = productList[1];
                    product3 = productList[2];
                }
                else if (productList.Length == 1)
                {
                    product1 = productList[0];
                }
                else if (productList.Length == 2)
                {
                    product1 = productList[0];
                    product2 = productList[1];
                }
                return e => e.Products_Discussed_ID.Contains(product1) || e.Products_Discussed_ID.Contains(product2) || e.Products_Discussed_ID.Contains(product3);

            }
            return e => true;

        }

        [QueryInterceptor("RCReportIssueDetailsViewSet")]
        public Expression<Func<RCReportIssueDetailsView, bool>> FilterDetailsByProducts()
        {
            string product1 = "";
            string product2 = "";
            string product3 = "";
            if (!string.IsNullOrEmpty(HttpContext.Current.Request.QueryString["Products_Discussed_ID"]))
            {
                string products = HttpContext.Current.Request.QueryString["Products_Discussed_ID"];
                string[] productList = products.Split(',');

                if (productList.Length == 0 || productList.Length == 3)
                {
                    product1 = productList[0];
                    product2 = productList[1];
                    product3 = productList[2];
                }
                else if (productList.Length == 1)
                {
                    product1 = productList[0];
                }
                else if (productList.Length == 2)
                {
                    product1 = productList[0];
                    product2 = productList[1];
                }
                return e => e.Products_Discussed_ID.Contains(product1) || e.Products_Discussed_ID.Contains(product2) || e.Products_Discussed_ID.Contains(product3);

            }
            return e => true;
          
        }

        [QueryInterceptor("RCReportProductsDiscussedViewSet")]
        public Expression<Func<RCReportProductsDiscussedView, bool>> FilterReportsByStatus()
        {
            return e => e.Report_Status == true;
        }

        [QueryInterceptor("RCReportPlanDocumentsSet")]
        public Expression<Func<RCReportPlanDocuments, bool>> FilterDocsByStatus()
        {
            return e => e.Document_Status == true;
        }
        #endregion

        [WebGet]
        public string GetCCRModuleOptions()
        {
            using (PathfinderModel.PathfinderEntities context = new PathfinderModel.PathfinderEntities())
            {
                return context.GetUserReportOptionsAsJSON(Pinsonault.Web.Session.UserID, Pinsonault.Web.Identifiers.ReimbursementChallengeReport);
            }
        }

        [WebGet]
        public override string GetModuleOptions()
        {
            using (PathfinderModel.PathfinderEntities context = new PathfinderModel.PathfinderEntities())
            {
                return context.GetUserReportOptionsAsJSON(Pinsonault.Web.Session.UserID, Pinsonault.Web.Identifiers.PCNBINReport);
            }
        }

    }
}