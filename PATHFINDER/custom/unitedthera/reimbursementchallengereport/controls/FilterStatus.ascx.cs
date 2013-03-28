using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class custom_unitedthera_reimbursementchallengereport_controls_filterstatus : System.Web.UI.UserControl
{
    public custom_unitedthera_reimbursementchallengereport_controls_filterstatus()
    {
        ContainerID = "moduleOptionsContainer";
    }
    public string ContainerID { get; set; }

    public bool IncludeAll { get; set; }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Pinsonault.Web.Support.RegisterComponentWithClientManager(Page, Status_ID.ClientID, null, ContainerID);

        if (IncludeAll)
        {
            RadComboBoxItem itemAM = new RadComboBoxItem("--Any Status--");
            Status_ID.Items.Add(itemAM);
        }
    }
    
}
