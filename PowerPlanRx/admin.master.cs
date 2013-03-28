using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin : System.Web.UI.MasterPage
{
    protected override void OnLoad(EventArgs e)
    {         
        main.Visible = Impact.User.IsAdmin;
        error.Visible = !Impact.User.IsAdmin;

        base.OnLoad(e);
    }
}
