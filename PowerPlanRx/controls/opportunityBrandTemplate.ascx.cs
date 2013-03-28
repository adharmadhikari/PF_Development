using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_opportunityBrandTemplate : DynamicTemplateBase
{
    public override string DataFieldFormat1
    {
        get { return "Tier{0}"; }
    }
    public override string DataFieldFormat2
    {
        get { return "Copay{0}"; }
    }
    public override string DataFieldFormat3
    {
        get { return "BTX{0}"; }
    }
    public override string DataFieldFormat4
    {
        get { return "BMST{0}"; }
    }

    public override string DataFieldFormat5
    {
        get { return "Brand{0}"; }
    }
}