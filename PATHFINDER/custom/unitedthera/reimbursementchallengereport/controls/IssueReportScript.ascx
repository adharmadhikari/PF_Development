<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IssueReportScript.ascx.cs" Inherits="custom_controls_ccrMeetingActivityScript" %>
<%@ OutputCache Shared="true" VaryByParam="None" Duration="100" %>

<script type="text/javascript">

    clientManager.add_pageInitialized(issueReportPageInitialized);
    clientManager.add_pageUnloaded(issueReportPageUnloaded);
    function issueReportPageInitialized()
    {
        $('#divTile3').hide();
        clientManager.registerComponent('ctl00_Tile4_irData1_dataProduct1_gridIssueSummaryReport', null);
       // var gridSummary = $get("ctl00_Tile4_issueReportSummary_gridIssueReportSummary_GridData").GridWrapper;
       // gridSummary.add_dataBound(gridrestrictionsdrilldownreport_onDataBound);

    }

    function issueReportPageUnloaded()
    {
        clientManager.remove_pageInitialized(issueReportPageInitialized);
        clientManager.remove_pageUnloaded(issueReportPageUnloaded);
    }

    function gridIssueSummaryReport_OnRowSelecting(sender, args) {
        var issueID = args._dataKeyValues.Issue_ID;
        issueReportDrilldown(issueID, sender.ClientID);
    }

    function issueReportDrilldown(issueID, ctrlClientId) {
        var data = clientManager.get_SelectionData();
        data["Issue_ID"] = issueID;
        if ($get('Plan_ID') && $('#Plan_ID_DATA').val() != "")
            data["Plan_ID"] = $('#Plan_ID_DATA').val().split(',');
        else
            delete data["Plan_ID"];

        if ($validateContainerData("filtersContainer", data, '<%= Resources.Resource.Label_Report_Filters %>')) {
             data["__options"] = $getContainerData("optionsContainer");
             clientManager.set_SelectionData(data, 1);
         }
        
    }

</script>