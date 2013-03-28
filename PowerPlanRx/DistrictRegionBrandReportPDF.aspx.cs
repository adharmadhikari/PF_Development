using System;
using System.Collections.Generic;
using System.Collections.Specialized;

public partial class DistrictRegionBrandReportPDF : System.Web.UI.Page
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
        
       imgCommercialChart.Visible = !string.IsNullOrEmpty(imgCommercialChart.ImageUrl);
    
    }    
}
