<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IssueReportDataTemplate.ascx.cs" Inherits="custom_unitedthera_reimbursementchallengereport_controls_IssueReportDataTemplate" %>

<telerik:RadGrid OnPreRender="gridIssueSummaryReport_PreRender" SkinID="radTable" runat="server" ID="gridIssueSummaryReport" AllowSorting="False"  AllowFilteringByColumn="false" AutoGenerateColumns="False"
 AllowPaging="True" EnableEmbeddedSkins="False" GridLines="None">
    <MasterTableView AutoGenerateColumns="false"  Width="100%" AllowSorting="false" ClientDataKeyNames="Issue_ID, Issue_Name">   
         <Columns>
            <telerik:GridBoundColumn DataField="Issue_Name" HeaderStyle-Width="47%" 
                HeaderText='Topic Name' UniqueName="Issue_Name" />             
            <telerik:GridBoundColumn DataField="RecordCount" HeaderStyle-Width="22%" 
                HeaderText='# Of Calls' UniqueName="RecordCount" DataType="System.Int32" /> 
            <telerik:GridBoundColumn DataField="User_ID_Percent" HeaderStyle-Width="26%" 
                HeaderText='% Of Calls' DataFormatString="{0:F2}%"  
                UniqueName="User_ID_Percent" DataType="System.Double" /> 
         </Columns>        
    </MasterTableView>
    <ClientSettings ClientEvents-OnRowSelecting="gridIssueSummaryReport_OnRowSelecting">
        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="230px" />
        <Selecting AllowRowSelect="true" /> 
    </ClientSettings>
</telerik:RadGrid>