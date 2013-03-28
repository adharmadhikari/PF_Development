using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class controls_maintab : System.Web.UI.UserControl
{
    protected override void OnLoad(EventArgs e)
    {
        string pageName = Path.GetFileName(this.Request.PhysicalPath);

        A1.Attributes["class"] = pageName.StartsWith("home", StringComparison.InvariantCultureIgnoreCase) ? "selected" : "default";
        A2.Attributes["class"] = pageName.StartsWith("campaigns", StringComparison.InvariantCultureIgnoreCase) ? "selected" : "default";
        A3.Attributes["class"] = pageName.StartsWith("mycampaigns", StringComparison.InvariantCultureIgnoreCase) || pageName.StartsWith("createcampaign", StringComparison.InvariantCultureIgnoreCase) ? "selected" : "default";
        A4.Attributes["class"] = pageName.StartsWith("reports.aspx", StringComparison.InvariantCultureIgnoreCase) ? "selected" : "default";
        //A4.Attributes["class"] = pageName.StartsWith("DistrictRegionBrandReport.aspx", StringComparison.InvariantCultureIgnoreCase) ? "selected" : "default";

        base.OnLoad(e);
    }
}
