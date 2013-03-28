using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_GoalsMonthTemplate : DynamicTemplateBase
{
    public override string DataFieldFormat1
    {
        get { return "Trx{0}"; }
    }
    public override string DataFieldFormat2
    {
        get { return "Mst{0}"; }
    }
    public override string DataFieldFormat3
    {
        get { return ""; }
    }
    public override string DataFieldFormat4
    {
        get { return ""; }
    }
}
