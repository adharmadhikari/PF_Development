using System;
using System.Collections.Generic;
using System.Collections.Specialized;

public partial class DistrictProfileTrxChartPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        IList<NameValueCollection> images = Impact.FileExport.ExtractImagesFromRequest(Request.QueryString);
        if (images.Count > 0)
        {
            if (images[0] != null)
            {
                imgCommercialChart.ImageUrl = images[0]["path"];
            }
        }
        if (images.Count > 1)
        {
            if (images[1] != null)
            {
                imgPartDChart.ImageUrl = images[1]["path"];
            }
        }
       imgCommercialChart.Visible = !string.IsNullOrEmpty(imgCommercialChart.ImageUrl);
       imgPartDChart.Visible = !string.IsNullOrEmpty(imgPartDChart.ImageUrl); 
    
    }    
}
