<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DrilldownReportScript.ascx.cs" Inherits="custom_unitedthera_reimbursementchallengereport_controls_DrilldownReportScript" %>
<%@ OutputCache Shared="true" VaryByParam="None" Duration="100" %>

<script type="text/javascript">

    clientManager.add_pageInitialized(drillDownReportPageInitialized);
    clientManager.add_pageUnloaded(drillDownReportPageUnloaded);

    function drillDownReportPageInitialized() {
        
        clientManager.registerComponent('ctl00_Tile4_irData1_dataProduct1_gridRCRdrillDownReport', null);
        // var gridSummary = $get("ctl00_Tile4_issueReportSummary_gridIssueReportSummary_GridData").GridWrapper;
        // gridSummary.add_dataBound(gridrestrictionsdrilldownreport_onDataBound);

    }

    function drillDownReportPageUnloaded() {
        clientManager.remove_pageInitialized(drillDownReportPageInitialized);
        clientManager.remove_pageUnloaded(drillDownReportPageUnloaded);
    }

</script>