﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dundas.Charting.WebControl;

public partial class custom_controls_ccrChartTemplate : ChartUserControl
{
    public override Chart HostedChart
    {
        get { return chart; }
    }
    protected override void OnLoad(EventArgs e)
    {
        //chart.PaletteCustomColors = Pathfinder.ReportColors.Palette.Reverse().ToArray();
        base.OnLoad(e);
    }
}
