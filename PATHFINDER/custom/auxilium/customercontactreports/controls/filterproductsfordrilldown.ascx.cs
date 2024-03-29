﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PathfinderClientModel;
using Pinsonault.Web;


public partial class custom_controls_FilterProductsForDrilldown : System.Web.UI.UserControl
{
    public custom_controls_FilterProductsForDrilldown()
    {
        ContainerID = "moduleOptionsContainer";
       
    }
    public string ContainerID { get; set; }
    
    protected override void OnPreRender(EventArgs e)
    {
        //creates the drop down list for Products Discussed based on the Drug_Name
        using (PathfinderClientEntities context = new PathfinderClientEntities(Pinsonault.Web.Session.ClientConnectionString))
        {
              var q = (from p in context.LkpProductsDiscussedSet
                    orderby p.Drug_Name
                    select p ).ToList().Select( p => new GenericListItem { ID = p.Products_Discussed_ID.ToString(), Name = p.Drug_Name });
              if (q != null)
              {                 
                  Pinsonault.Web.Support.RegisterGenericListVariable(this.Page, q.ToArray(), "productsDiscussed");
              }
        }
        base.OnPreRender(e);
    }
    protected override void OnLoad(EventArgs e)
    {
        Pinsonault.Web.Support.RegisterTierScriptVariable(this.Page);
        Pinsonault.Web.Support.RegisterComponentWithClientManager(this.Page, Products_Discussed_ID.ClientID, null, "moduleOptionsContainer");
       
        Products_Discussed_ID.OnClientLoad = "function(s,a){$createCheckboxDropdown(s.get_id(), 'ProductsIDOptionList', productsDiscussed , {'defaultText': '--All Products--', 'multiItemText': '" + Resources.Resource.Label_Multiple_Selection + "' }, null, 'moduleOptionsContainer'); var Products_Discussed_ID = $get('ProductsIDOptionList').control; $loadPinsoListItems(Products_Discussed_ID, productsDiscussed, null, -1);}";

        base.OnLoad(e);
    }
}
