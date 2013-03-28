﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using PathfinderModel;
using Dundas.Charting.WebControl;

public partial class standardreports_controls_FormularyStatusChartTemplate : ChartUserControl
{
    public bool GeographicCoverage { get; set; }

    public override Chart HostedChart
    {
        get { return chart; }
    }

    //protected override void OnLoad(EventArgs e)
    //{
    //    ProcessChart();

    //    base.OnLoad(e);
    //}
    public override Unit GetRenderedWidth()
    {
        if (!GeographicCoverage)
            return base.GetRenderedWidth();
        else
            return new Unit("375px");
    }

    public override Unit GetRenderedHeight()
    {
        if (!GeographicCoverage)
            return base.GetRenderedHeight();
        else
            return new Unit("210px");
    }
}


