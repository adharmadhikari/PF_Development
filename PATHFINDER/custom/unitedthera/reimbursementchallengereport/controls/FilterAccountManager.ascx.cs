using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PathfinderClientModel;
using Pinsonault.Web;
using Pinsonault.Application.UnitedThera;


public partial class custom_controls_FilterAccountManager : System.Web.UI.UserControl
{
    public custom_controls_FilterAccountManager()
    {
        ContainerID = "moduleOptionsContainer";
    }
    public string ContainerID { get; set; }

    protected override void OnPreRender(EventArgs e)
    {
        //creates the drop down list for Status
        using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
        {
              var q = (from p in context.AccountManagersByTerritoryViewSet
                    orderby p.User_ID
                    select p ).ToList().Select( p => new GenericListItem { ID = p.User_ID.ToString(), Name = p.FullName });
              if (q != null)
              {
                  Pinsonault.Web.Support.RegisterGenericListVariable(this.Page, q.ToArray(), "accountManager");
              }
        }
        base.OnPreRender(e);
    }
    protected override void OnLoad(EventArgs e)
    {
        Pinsonault.Web.Support.RegisterTierScriptVariable(this.Page);
        Pinsonault.Web.Support.RegisterComponentWithClientManager(this.Page, NAM_ID.ClientID, null, "moduleOptionsContainer");
        NAM_ID.OnClientLoad = "function(s,a){$createCheckboxDropdown(s.get_id(), 'NAMIDOptionList', accountManager , {'defaultText': '--All Account Managers--', 'multiItemText': '" + Resources.Resource.Label_Multiple_Selection + "' }, null, 'moduleOptionsContainer'); var NAM_ID = $get('NAMIDOptionList').control; $loadPinsoListItems(NAM_ID, accountManager, null, -1);}";
        base.OnLoad(e);
    }
}
