using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PathfinderClientModel;
using Pinsonault.Web;
using Pinsonault.Application.UnitedThera;

public partial class custom_controls_FilterIssueType : System.Web.UI.UserControl
{

    public custom_controls_FilterIssueType()
    {
        ContainerID = "moduleOptionsContainer";
    }
    public string ContainerID { get; set; }

    protected override void OnPreRender(EventArgs e)
    {
        //creates the drop down list for Products Discussed based on the Drug_Name
        using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
        {
            var q = (from m in context.LkpRCReportIssueSet
                     orderby m.Issue_Name
                     select m).ToList().Select(m => new GenericListItem { ID = m.Issue_ID.ToString(), Name = m.Issue_Name });
            if (q != null)
            {
                //List<GenericListItem> list = q.ToList();
                //list.Insert(0, new GenericListItem { ID = "0", Name = "All" });
                Pinsonault.Web.Support.RegisterGenericListVariable(this.Page, q.ToArray(), "issueType");
            }
        }
        base.OnPreRender(e);
    }
    protected override void OnLoad(EventArgs e)
    {
        Pinsonault.Web.Support.RegisterTierScriptVariable(this.Page);
        Pinsonault.Web.Support.RegisterComponentWithClientManager(this.Page, Issue_ID.ClientID, null, "moduleOptionsContainer");
        Issue_ID.OnClientLoad = "function(s,a){$createCheckboxDropdown(s.get_id(), 'IssueIDOptionList', issueType , {'defaultText': '--All Issues--', 'multiItemText': '" + Resources.Resource.Label_Multiple_Selection + "' }, null, 'moduleOptionsContainer'); var Issue_ID = $get('IssueIDOptionList').control; $loadPinsoListItems(Issue_ID, issueType, null, -1);}";
        base.OnLoad(e);
    }
}
