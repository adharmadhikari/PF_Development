using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class createcampaign_step4_bestpractices : System.Web.UI.Page, IEditPage
{
    protected override void OnLoad(EventArgs e)
    {
        if (((MasterPage)this.Master).IsPageEditable)
            formView.ChangeMode(FormViewMode.Edit);

        base.OnLoad(e);
    }


    #region IEditPage Members

    public bool Save()
    {       
                
        formView.UpdateItem(true);
        formView.ChangeMode(FormViewMode.ReadOnly);
        return true;
    }

    public void Reset()
    {
        formView.ChangeMode(FormViewMode.ReadOnly);
    }

    public void Edit()
    {
        formView.ChangeMode(FormViewMode.Edit);
    }

    #endregion
}
