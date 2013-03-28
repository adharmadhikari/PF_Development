using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Pinsonault.Data.Reports;
using System.Data.Objects;
using PathfinderModel;
using Pinsonault.Data;
using System.Collections.Specialized;

namespace Pinsonault.Application.UnitedThera
{
    public class IssueReport : Report
    {

        protected override void BuildReportDefinitions()
        {
            IList<string> tiles = new List<string>();
            tiles.Add("Tile4Tools");

            if (FilterSets.Count > 0 && !string.IsNullOrEmpty(FilterSets[0]["Section_ID"]))
                tiles.Add("Tile4ToolsSection");

            ReportDefinitions.Add(new ReportDefinition
            {
                ReportDefinitions = new ReportDefinition[]
                                {
                                    new IssueReportDefinition { ReportKey="issuereport", Tile= string.Join(", ", tiles.ToArray()), EntityTypeName="RCReportIssueSummaryView", Sort="Issue_Name asc", SectionTitle="Issue Report Summary" },       
                                }
            });
            ReportDefinitions.Add(new DetailsReportDefinition { ReportKey = "issuereport", Tile = "Tile5Tools", EntityTypeName = "RCReportIssueDetailsView", Sort = "Account_Manager asc", SectionTitle = "Issue Report Details" });
        }

        protected override ObjectContext CreateObjectContext(PathfinderEntities context, bool IsCustom)
        {
            return CreateUnitedTheraContext();
        }

        protected ObjectContext CreateUnitedTheraContext()
        {
            return new PathfinderUnitedTheraEntities();
        }
    }

    public class RCRDrilldownReport : Report
    {
        protected override void BuildReportDefinitions()
        {
            IList<string> tiles = new List<string>();
            tiles.Add("Tile3Tools");

            if (FilterSets.Count > 0 && !string.IsNullOrEmpty(FilterSets[0]["Section_ID"]))
                tiles.Add("Tile3ToolsSection");

            ReportDefinitions.Add(new RCRDrilldownReportDefinition { ReportKey = "reimbursementchallengedrilldown", Tile = "Tile3Tools", EntityTypeName = "RCReportDrilldownView", Sort = "Account_Manager asc", SectionTitle = "Reimbursement Challenge Drilldown Report" });
        }

        protected override ObjectContext CreateObjectContext(PathfinderEntities context, bool IsCustom)
        {
            return CreateUnitedTheraContext();
        }

        protected ObjectContext CreateUnitedTheraContext()
        {
            return new PathfinderUnitedTheraEntities();
        }
    }

    public class PCNBINReport : Report
    {

        protected override void BuildReportDefinitions()
        {
            ReportDefinitions.Add(new PCNBINReportDefinition { ReportKey = "pcnbinreport", Tile = "Tile3Tools", RequiresFilters=false, EntityTypeName = "PCNBINReportView", Sort = "Plan_Name asc", SectionTitle = "PCN BIN Report" });
        }

        protected override ObjectContext CreateObjectContext(PathfinderEntities context, bool IsCustom)
        {
            return CreateUnitedTheraContext();
        }

        protected ObjectContext CreateUnitedTheraContext()
        {
            return new PathfinderUnitedTheraEntities();
        }
    }

}
