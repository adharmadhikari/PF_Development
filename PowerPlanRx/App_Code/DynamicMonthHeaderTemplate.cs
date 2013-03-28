using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class DynamicMonthHeaderTemplate : DynamicTemplateBase
{
    public override string DataFieldFormat1
    {
        get { return "month{0}"; }
    }
    public override string DataFieldFormat2
    {
        get { return ""; }
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
