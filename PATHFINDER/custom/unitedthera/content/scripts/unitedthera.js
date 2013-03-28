/// <reference name="MicrosoftAjax.js"/>
/// <reference path="~/content/scripts/jquery-1.4.1-vsdoc.js"/>
/// <reference path="~/content/scripts/ui-vsdoc.js"/>
/// <reference path="~/content/scripts/clientManager-vsdoc.js"/>


//Formulary Sell Sheets business rules ---------------------------------------------------------------------------------------------------------------------------------------------
Pathfinder.UI.UnitedtheraFormularySellSheetsApplication = function(id) {
Pathfinder.UI.UnitedtheraFormularySellSheetsApplication.initializeBase(this, [id]);
};
//Pathfinder.UI.UnitedtheraFormularySellSheetsApplication.prototype =
//{
//    createSellSheet: function() {
//        //Clear the plan selection for the first time.
//        clientManager.setContextValue("ssSelectedPlansList");

//        var dt = new Date();
//        dt = "'" + encodeURIComponent(dt.localeFormat("d") + " " + dt.localeFormat("t")) + "'";

//        $.getJSON("custom/unitedthera/sellsheets/services/UnitedTheraDataService.svc/CreateSellSheet?Created=" + dt, null, this._onCreateCallbackDelegate);
//    }
//};
Pathfinder.UI.UnitedtheraFormularySellSheetsApplication.registerClass("Pathfinder.UI.UnitedtheraFormularySellSheetsApplication", Pathfinder.UI.FormularySellSheetsApplication);

// Reimbursement Challenge Report
Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication = function (id) {
    Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication.initializeBase(this, [id]);
};
Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication.prototype =
{
    //override CCR methods to point to Reimbursement Challenge Report
    activate: function (clientManager) {
        //Hide the channel menu
        if (clientManager) clientManager.get_ChannelMenu().set_visible(false);

        //Set effective channel to zero for proper loading of filters
        clientManager.set_EffectiveChannel(0);

        Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication.callBaseMethod(this, "activate", [clientManager]);
    },
    
    get_UrlName: function () { return "custom/" + this.get_clientKey() + "/reimbursementchallengereport"; },

    getUrl: function (channelName, module, pageName, hasData, isCustom) {
        //not using channel menu anymore for standard reports
        channelName = "all";
        //Does not require user selection to run so hasData must be true
        if (module == "reimbursementissueentry")
            hasData = true;
        return Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication.callBaseMethod(this, 'getUrl', [channelName, module, pageName, hasData, isCustom]);
    },

    getDefaultModule: function (clientManager) {
        return "reimbursementissueentry";
    },

    get_ModuleOptionsUrl: function (clientManager) {
        if (clientManager.get_Module() != "reimbursementissueentry")
            return this.getUrl("all", null, clientManager.get_Module() + "_filters.aspx", false);
        else
            return null;
    },

    get_ServiceUrl: function () { return this.get_UrlName() + "/services/unitedtheradataservice.svc"; },

    get_OptionsServiceUrl: function(clientManager)
    {
    return this.get_ServiceUrl() + "/GetCCRModuleOptions";
    },
    
    //override to fix some styling issues due to naming conflicts
    resizeSection: function () {
        var browserWindow = $(window);
        var divHeight = browserWindow.height();
        var divWidth = browserWindow.width();
        var tile2Height = divHeight / topSRHeight;
        var hdrElement = $("#divTile4 thead tr");
        var height = 20;

        if ($get("tile2")) {
            if (!$get("tile4"))
                $(".section2SR .enlarge").show();
            else {
                $(".srBottom .enlarge").show();
                $("#tile3 .enlarge, #tile3SR .enlarge, #divTile3Container .enlarge").hide(); //only show maximize for grids, not chart
            }
        } //sph 8/9/2010 - not sure why this line was commented out - required so "Max" button doesn't appear if browser is resized after max operation
        $("#maxTChart .enlarge, #maxSRMap .enlarge, #maxTBtm .enlarge, #maxChart .enlarge, #maxSRTile4 .enlarge, #maxSRTile5 .enlarge").hide();

        if (hdrElement.length > 0) {
            height = Sys.UI.DomElement.getBounds(hdrElement[0]).height;
        }
        //Tile 3 Properties (if Tile4 & 5 exist statement)
        var tile3Height;
        if (!$get("tile4") && !$get("tile4SR") && !$get("maxSRTile4")) {
            tile3Height = divHeight - 131;
        }
        else {
            tile3Height = divHeight * .40;
        }
        if (ie6) {
            $("#tile3 #divTile3Container ").css({
                height: tile3Height
            }
           );
        }

        $("#tile4 #divTile4, #tile5 #divTile5, #tile4SR #divTile4, #tile5SR #divTile5 ").css({
            height: safeSub((divHeight - tile3Height), 164)
        });
        $("#tile3 #divTile3, #tile3SR #divTile3").css({
            height: tile3Height, textAlign: "center", width: "auto", overflow: "hidden"
        }
           );

        //Fix for Drill Down Report
        if ($get("ctl00_Tile3_gridDrilldown_gridrcrDrilldown")) {
            $("#ctl00_Tile3_gridDrilldown_gridrcrDrilldown_GridData").height(tile3Height - $("#ctl00_Tile3_gridDrilldown_gridrcrDrilldown_GridHeader").height());
            $("#tile3 #divTile3 #ctl00_Tile3_gridDrilldown_gridrcrDrilldown").height(tile3Height);
        }


        var fullWidth = safeSub(divWidth, ($get("divTile3") ? Sys.UI.DomElement.getBounds($get("divTile3")).x + 16 : 0));
        //Meetings grid scroll height
        $(".ccrMeetings .dashboardTable .rgDataDiv").css({ height: safeSub((tile3Height - height), 220) });

        //dynamic sized page depending on selection
        if ($(".ccrPlanSelectView .mini").length > 0) {
            $(".ccrPlanSelectView .dashboardTable .rgDataDiv").height(115);

            if (fullWidth > 0) {
                var pwidth = Math.round(fullWidth * .6);

                if (ie6)
                    $(".ccrPlanSelectView").height(190).width(pwidth + 6);
                if (chrome || !flashSupported)
                    $(".ccrPlanSelectView").height(190).width(pwidth - 5);
                else
                    $(".ccrPlanSelectView").height(190).width(pwidth);

                $(".ccrBusinessPlans").width(fullWidth - pwidth - 5);
            }

            $(".ccrBusinessPlans, .ccrMeetings").show();
        }
        else {
            $(".ccrBusinessPlans, .ccrMeetings").hide();

            if (fullWidth > 0)
                $(".ccrPlanSelectView").height(safeSub(tile3Height, 4)).width(fullWidth);
            else
                $(".ccrPlanSelectView").height(safeSub(tile3Height, 4)).width($("#divTile3").width());

            $(".ccrPlanSelectView .dashboardTable .rgDataDiv").height(safeSub((tile3Height - height), 57));
        }

        //Fix height of radGrids for report/chart screens
        $("#divTile4 .rgDataDiv").height(safeSub($("#divTile4").height(), $("#divTile4 .rgHeaderDiv").height()));
        $("#divTile5 .rgDataDiv").height(safeSub($("#divTile5").height(), $("#divTile5 .rgHeaderDiv").height()));


        $("#tile3").removeClass("leftTile");
        $(".todaysAccounts1").css({
            padding: "0px",
            position: "relative"
        });

        //clears Telerik computed width in the headers for the data table
        resetGridHeadersX(500);
    }
};
Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication.registerClass("Pathfinder.UI.UnitedtheraReimbursementChallengeReportApplication", Pathfinder.UI.CustomerContactReportsApplication);

// Custom PCN and BIN Report
Pathfinder.UI.UnitedtheraPCNBINReportApplication = function (id) {
    Pathfinder.UI.UnitedtheraPCNBINReportApplication.initializeBase(this, [id]);
};

Pathfinder.UI.UnitedtheraPCNBINReportApplication.prototype =
{
    get_ModuleMenu: function () { return null; },

    getDefaultModule: function (clientManager) {
        return "pcnbinreport";
    },

    get_ModuleOptionsUrl: function (clientManager) {
            return null;
    },

    getUrl: function (channelName, module, pageName, hasData, isCustom) {
        //not using channel menu anymore for standard reports
        channelName = "all";
        hasData = true;
        return Pathfinder.UI.UnitedtheraPCNBINReportApplication.callBaseMethod(this, 'getUrl', [channelName, module, pageName, hasData, isCustom]);
    },

    get_ServiceUrl: function () { return this.get_UrlName() + "/services/unitedtheradataservice.svc"; },

    configureDashboardTiles: function(clientManager)
    {
        $(".todaysAccounts1").hide();

        Pathfinder.UI.UnitedtheraPCNBINReportApplication.callBaseMethod(this, 'configureDashboardTiles', [clientManager]);
    },
    
    resetDashboardTiles: function(clientManager)
    {
        $(".todaysAccounts1").show();
        
        Pathfinder.UI.UnitedtheraPCNBINReportApplication.callBaseMethod(this, 'resetDashboardTiles', [clientManager]);
    },

    //resize: function()
    //{
    //    var browserWindow = $(window);
    //    var divHeight = browserWindow.height();
    //    var divWidth = browserWindow.width();
    
    //    $("#tile2").hide();
        
    //    $(".RadWindow table").height("100%");
    //    $("#RadWindowWrapper_modal").css({
    //        height: divHeight - 150, width: divWidth / 1.05
    //    }
    //    , animationSpeed);

    //    this.resizeSection();
        
    //    Pathfinder.UI.UnitedtheraPCNBINReportApplication.callBaseMethod(this, 'resize');
    //},

    resizeSection: function()
    {
        var browserWindow = $(window);
        var divHeight = browserWindow.height();
        var tile3Height;

        tile3Height = divHeight - 131;
        if (ie6) {
            $("#tile3 #divTile3Container ").css({
                height: tile3Height
            }
           );
        }
        $("#tile3 #divTile3, #tile3SR #divTile3").css({
            height: tile3Height, textAlign: "center", width: "auto", overflow: "auto"
        }
           );
        //Fix for Drill Down Report
        if ($get("ctl00_Tile3_PCNBINReport1_gridPCNBINReport")) {
            $("#ctl00_Tile3_PCNBINReport1_gridPCNBINReport_GridData").height(tile3Height - $("#ctl00_Tile3_PCNBINReport1_gridPCNBINReport_GridHeader").height());
            $("#tile3 #divTile3 #ctl00_Tile3_PCNBINReport1_gridPCNBINReport").height(tile3Height);
        }
    },

    get_UrlName: function () { return "custom/" + this.get_clientKey() + "/pcnbinreport"; },

    get_Title: function () { return "PCN/BIN Report"; }
};
Pathfinder.UI.UnitedtheraPCNBINReportApplication.registerClass("Pathfinder.UI.UnitedtheraPCNBINReportApplication", Pathfinder.UI.BasicApplication);