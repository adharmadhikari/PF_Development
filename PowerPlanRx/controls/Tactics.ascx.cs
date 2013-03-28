using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


public partial class controls_Tactics : System.Web.UI.UserControl
{
    public Telerik.Web.UI.RadGrid TacticGrid
    {
        get { return rgTacticsReadOnly; }
    }
}
