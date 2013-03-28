using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class custom_unitedthera_reimbursementchallengereport_controls_DrilldownReport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        gridRCRdrillDownReport.ClientSettings.DataBinding.Location = "~/custom/" + Pinsonault.Web.Session.ClientKey + "/reimbursementchallengereport/services/UnitedTheraDataService.svc";
    }
}