<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RCRGridView.ascx.cs" Inherits="custom_controls_CCRGridView" %>
<div id="ccrView">
    <telerik:RadGrid SkinID="radTable" runat="server" ID="gridCCReports" AllowSorting="True" EnableEmbeddedSkins="False" PageSize="50">        
        <MasterTableView autogeneratecolumns="false" ClientDataKeyNames="RC_Report_ID, Plan_ID" AllowPaging="true" Width="100%" PageSize="50">
            <Columns>
                <telerik:GridBoundColumn DataField="Contact_Date" HeaderText='Report Date' HeaderStyle-Width="15%" SortExpression="Contact_Date" UniqueName="Contact_Date" DataType ="System.DateTime" DataFormatString="{0:M/dd/yyyy}" /> 
                <telerik:GridBoundColumn DataField="Issue_Name" HeaderText='Issue Type' HeaderStyle-Width="25%" SortExpression="Issue_Name" UniqueName="Issue_Name"  DataType ="System.String"/>          
                <telerik:GridBoundColumn DataField="Drug_Name" HeaderText='Product(s) Discussed' HeaderStyle-Width="25%" SortExpression="Drug_Name" UniqueName="Drug_Name" DataType = "System.String" />
                <telerik:GridBoundColumn DataField="Status_Name"  HeaderText='Status' HeaderStyle-Width="35%" SortExpression="Status_Name"  UniqueName="Status_Name" DataType ="System.String" />          
            </Columns>    
            <SortExpressions>
                <telerik:GridSortExpression FieldName="Contact_Date" SortOrder="Descending" />
            </SortExpressions>                   
        </MasterTableView>
        <PagerStyle Visible="false" /> 
        <ClientSettings ClientEvents-OnRowSelecting="gridCCReports_OnRowSelecting">
            <DataBinding Location="~/custom/UnitedThera/reimbursementchallengereport/services/UnitedTheraDataService.svc" DataService-TableName="RCReportProductsDiscussedViewSet" SelectCountMethod ="GetRCReportCount">
            </DataBinding>
            <Scrolling AllowScroll="true" UseStaticHeaders="true" /> 
            <Selecting AllowRowSelect="true" />
        </ClientSettings>   
    </telerik:RadGrid>    
    <pinso:RadGridWrapper runat="server" ID="gridWrapper" Target="gridCCReports" PagingSelector="#tile6ContainerHeader .pagination" MergeRows="false"  RequiresFilter ="true" AutoLoad="true" UtcDateColumns="Contact_Date" />
</div> 