﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PathfinderClientModel;
using Pinsonault.Web;
using System.Text;
using System.Configuration;
using System.Web.Caching;
using System.Runtime.Serialization;

public partial class marketplaceanalytics_controls_FilterDrugSelection : System.Web.UI.UserControl
{
    public marketplaceanalytics_controls_FilterDrugSelection()
    {
        ContainerID = "moduleOptionsContainer";
        MaxDrugs = 3;
    }

    public string ContainerID { get; set; }
    public int MaxDrugs { get; set; }

    protected override void OnPreRender(EventArgs e)
    {
        //creates the drop down list for Market Segment
        using (PathfinderClientEntities context = new PathfinderClientEntities(Pinsonault.Web.Session.ClientConnectionString))
        {
            var q = (from p in context.ProductsTheraSet
                     orderby p.Thera_Name
                     select p).ToList().Select(p => new GenericListItem { ID = p.Thera_ID.ToString(), Name = p.Thera_Name });
            if (q != null)
            {
                //List<GenericListItem> list = q.ToList();
                //list.Insert(0, new GenericListItem { ID = "0", Name = "All" });
                Pinsonault.Web.Support.RegisterGenericListVariable(this.Page, q.ToArray(), "productsThera");
            }
        }
        base.OnPreRender(e);
    }

    protected override void OnLoad(EventArgs e)
    {
        Pinsonault.Web.Support.RegisterComponentWithClientManager(Page, Market_Basket_ID.ClientID, null, ContainerID);
        Pinsonault.Web.Support.RegisterComponentWithClientManager(Page, Product_ID.ClientID, null, ContainerID);

        PathfinderClientModel.PathfinderClientEntities contextClient = new PathfinderClientModel.PathfinderClientEntities(Pinsonault.Web.Session.ClientConnectionString);

        RegisterDrugListVariable(this.Page, contextClient);

        //not ideal but event handlers are added in code behind this way so element ids can be dynamically set (can vary depending on naming containers).
        Market_Basket_ID.OnClientLoad = "function(s,a){$loadListItems(s, productsThera, null, clientManager.get_MarketBasket());}";
        Market_Basket_ID.OnClientSelectedIndexChanged = "function(s,a){var d = $find(\"DrugIDList\");if(!d) return;$loadPinsoListItems(d, marketplaceProductListOptions[s.get_value()],null,-1); var dl = $find(\"" + Product_ID.ClientID + "\"); dl.set_visible(d.get_count()>0);$updateCheckboxDropdownText(dl,'DrugIDList');}";
        Product_ID.OnClientLoad = "function(s,a){ var data = marketplaceProductListOptions[$find('" + Market_Basket_ID.ClientID + "').get_value()]; $createCheckboxDropdown(s.get_id(), 'DrugIDList', null, {'maxItems':" + MaxDrugs.ToString() + ",'defaultText':'" + Resources.Resource.Label_No_Selection + "'}, {'error':function(){$alert('Maximum " + MaxDrugs.ToString() + " drugs should be selected.', 'Report Filters');}}, 'moduleOptionsContainer'); $loadPinsoListItems($find('DrugIDList'), data,null, -1);$updateCheckboxDropdownText(s,'DrugIDList');}";
        base.OnLoad(e);
    }

    /// <summary>
    /// Outputs a variable for available products organized by market basket.  The name of the variable will be drugListOptions.
    /// </summary>
    /// <param name="Page">Current page handling the request.</param>
    static void RegisterDrugListVariable(Page Page, PathfinderClientModel.PathfinderClientEntities context)
    {
        //Output Product List
        //{TID:[{ID:0,Name:"ProductName"},...],TID2:[{ID:1,Name:"ProductName1"},...]}

        string clientKey = Pinsonault.Web.Session.ClientKey;

        string cacheKey = string.Format("{0}_marketplaceproductlist", clientKey);
        string script = HttpContext.Current.Cache[cacheKey] as string;

        if (string.IsNullOrEmpty(script))
        {
            script = getDrugListScript(context);

            HttpContext.Current.Cache.Insert(cacheKey, script, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromHours(1.0), new System.Web.Caching.CacheItemUpdateCallback(drugListCacheItemUpdateCallback));
        }

        Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "marketplaceProductListOptions", script, true);
        //
    }


    static void drugListCacheItemUpdateCallback(string key, CacheItemUpdateReason reason, out object expensiveObject, out CacheDependency dependency, out DateTime absoluteExpiration, out TimeSpan slidingExpiration)
    {
        absoluteExpiration = System.Web.Caching.Cache.NoAbsoluteExpiration;
        slidingExpiration = TimeSpan.FromHours(1.0);
        dependency = null;

        expensiveObject = null;

        //string clientKey = null;

        string[] parts = key.Split(new char[] { '_' }, 2);

        //if (Int32.TryParse(parts[0], out clientKey))
        //{
        if (!string.IsNullOrEmpty(parts[0]))
        {
            string connKey = "PathfinderClientEntities_Format";

            using (PathfinderClientModel.PathfinderClientEntities context = new PathfinderClientModel.PathfinderClientEntities(string.Format(ConfigurationManager.ConnectionStrings[connKey].ConnectionString, parts[0])))
            {
                expensiveObject = getDrugListScript(context);
            }
        }
        //}

    }

    static string getDrugListScript(PathfinderClientModel.PathfinderClientEntities context)
    {
        StringBuilder sb = new StringBuilder("var marketplaceProductListOptions = {");
        //StringBuilder sb2 = new StringBuilder("var marketBasketListOptions = [");

        int? currentTheraID = 0;

        IQueryable<MarketplaceProductListEntry> products = from d in context.DrugProductsSet
                                                        orderby d.Thera_ID, d.Product_Name
                                                        select new MarketplaceProductListEntry { ID = d.Product_ID, Name = d.Product_Name, TherapeuticClassID = d.Thera_ID };

        bool hasDrugs = false;

        foreach (MarketplaceProductListEntry product in products)
        {
            if (product.TherapeuticClassID != currentTheraID)
            {
                if (currentTheraID > 0)
                {
                    sb.Remove(sb.Length - 1, 1);
                    sb.Append("]");
                }
                sb.AppendFormat("{0}{1}:[", (currentTheraID > 0 ? "," : ""), product.TherapeuticClassID);

                currentTheraID = product.TherapeuticClassID;

                //sb2.Append("{ID:");
                //sb2.AppendFormat("{0},Name:\"{1}\"", drug.TherapeuticClassID, drug.TherapeuticClassName);
                //sb2.Append("},");
            }

            sb.Append("{ID:");
            sb.AppendFormat("{0},Name:\"{1}\"", product.ID, product.Name);
            sb.Append("},");

            hasDrugs = true;
        }

        if (hasDrugs)
        {
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]};");

            //sb2.Remove(sb2.Length - 1, 1);
            //sb2.Append("];");
        }
        else
        {
            sb.Append("};");
            //sb2.Append("];");
        }

        //sb2.Append(sb.ToString());

        //return sb2.ToString();
        return sb.ToString();
    }

    //public IQueryable<MarketplaceProductListEntry> GetUserDrugList(int clientID, PathfinderClientModel.PathfinderClientEntities context)
    //{
    //    using (context)
    //    {
    //        context.DrugProductsSet.MergeOption = MergeOption.NoTracking;

    //        var q = from d in context.DrugProductsSet
    //                orderby d.Product_Name
    //                select new MarketplaceProductListEntry { ID = d.Drug_ID, Name = d.Product_Name, TherapeuticClassID = d.Thera_ID };

    //        return q;
    //    }
    //}
}

public class MarketplaceProductListEntry
{
    public MarketplaceProductListEntry() { }


    /// <summary>
    /// Drug ID
    /// </summary>
    [DataMember]
    public int? ID { get; set; }

    /// <summary>
    /// Drug Name
    /// </summary>
    [DataMember]
    public string Name { get; set; }

    /// <summary>
    /// Therapeutic Class ID
    /// </summary>
    [DataMember]
    public int? TherapeuticClassID { get; set; }

}


