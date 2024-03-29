﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Data.Objects;
using System.ComponentModel;
using System.Data.Common;
using Telerik.Web.UI;
using PathfinderModel;

public partial class standardreports_controls_tiercoveragedata : System.Web.UI.UserControl, IReportGrid
{
    #region IReportGrid Members

    public void ProcessGrid(IList<DbDataRecord> Data, string Title, string Region)
    {
        RadGrid grid;

        if ( string.Compare(Region, "US", true) == 0 )
        {
            grid = dataUS.HostedGrid;
            dataUS.GridLabel = Title;
            dataUS.Visible = true;            
        }
        else
        {
            grid = dataStateTerr.HostedGrid;
            dataStateTerr.GridLabel = Title;
            dataStateTerr.Visible = true;
        }

        Pinsonault.Web.Support.RegisterComponentWithClientManager(this.Page, grid.ClientID);

        addColumns(grid,Data);

        grid.DataSource = Data;
        grid.DataBind();
    }

    #endregion

    void addColumns(RadGrid grid, IList<DbDataRecord> Data)
    {       
        //add section if it is other than all
        if (!string.IsNullOrEmpty(Request.QueryString["Section_ID"]))
        {
            Telerik.Web.UI.GridBoundColumn colSection;
            colSection = new Telerik.Web.UI.GridBoundColumn();
            grid.Columns.Add(colSection);

            colSection.DataField = "Section_Name";

            colSection.HeaderText = "Section";
            colSection.UniqueName = "Section_Name";
            colSection.SortExpression = "Section_Name";
            colSection.ItemStyle.CssClass = "alignLeft";
            colSection.HeaderStyle.Width = Unit.Pixel(65);            
        }
        Telerik.Web.UI.GridHyperLinkColumn col;

        IList<Tier> tiers = ReportPageLoader.Tiers;  
        foreach ( Tier tier in tiers )
        {
            bool IsColumnVisible = false;
            foreach (DbDataRecord record in Data)
            {                
                decimal tierPercent = record.GetDecimal(record.GetOrdinal(string.Format("T{0}",tier.ID)));
                if (tierPercent > 0) IsColumnVisible = true;                
            }
            if (IsColumnVisible) //if all the records for a column are having value > 0 then add the column else don't add it
            {
                col = new Telerik.Web.UI.GridHyperLinkColumn();
                grid.Columns.Add(col);

                col.DataTextField = string.Format("T{0}", tier.ID);
                col.DataTextFormatString = "{0:n2}%";

                //if selected section is all, pass 0 as section id else the data value
                if (!string.IsNullOrEmpty(Request.QueryString["Section_ID"]))
                {
                    col.DataNavigateUrlFields = new string[] { "Geography_ID", "Drug_ID", "Drug_Name", "Section_ID", "Section_Name" };
                    //pass section name as drug name if multiple sections are present
                    if (Request.QueryString["Section_ID"].Contains(","))
                        col.DataNavigateUrlFormatString = "javascript:tierCoverageDrilldown(\"{0}\",{1}," + tier.ID + ",\"{4}\",\"" + tier.Name + "\"," + "{3}" + ")";
                    else //pass drug name
                        col.DataNavigateUrlFormatString = "javascript:tierCoverageDrilldown(\"{0}\",{1}," + tier.ID + ",\"{2}\",\"" + tier.Name + "\"," + "{3}" + ")";
                }
                else
                {
                    col.DataNavigateUrlFields = new string[] { "Geography_ID", "Drug_ID", "Drug_Name" };
                    col.DataNavigateUrlFormatString = "javascript:tierCoverageDrilldown(\"{0}\",{1}," + tier.ID + ",\"{2}\",\"" + tier.Name + "\"," + 0 + ")";
                }

                col.HeaderText = tier.Name;
                col.UniqueName = col.DataTextField;
                col.SortExpression = col.DataTextField;
                col.ItemStyle.CssClass = "alignRight";
                col.HeaderStyle.Width = Unit.Pixel(50);
            }
        }
    }
}
