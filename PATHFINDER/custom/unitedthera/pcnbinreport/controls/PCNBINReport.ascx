<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PCNBINReport.ascx.cs" Inherits="custom_unitedthera_pcnbinreport_controls_PCNBINReport" %>

<telerik:RadGrid SkinID="radTable" runat="server" ID="gridPCNBINReport" AllowSorting="true"  EnableEmbeddedSkins="false" PageSize="50">        
    <MasterTableView autogeneratecolumns="false" ClientDataKeyNames="Plan_ID">
       <Columns>
       <telerik:GridBoundColumn DataField="Plan_Name" UniqueName="Plan_Name" HeaderText="Plan Name" HeaderStyle-Width="30%"  />
        <telerik:GridBoundColumn DataField="Plan_State" UniqueName="Plan_State" HeaderText="Plan State" HeaderStyle-Width="10%"  />
        <telerik:GridBoundColumn DataField="Section_Name" UniqueName="Section_Name" HeaderText="Market Segment" HeaderStyle-Width="20%"  />
        <telerik:GridBoundColumn DataField="BIN_Number" UniqueName="BIN_Number" HeaderText="BIN Number" HeaderStyle-Width="20%"  />
        <telerik:GridBoundColumn DataField="PCN_Number" UniqueName="PCN_Number" HeaderText="PCN Number" HeaderStyle-Width="20%" />
        </Columns>  
        <SortExpressions>
            <telerik:GridSortExpression FieldName="Plan_Name" SortOrder="Ascending"  />   
        </SortExpressions>               
    </MasterTableView>           
    <ClientSettings>
          <DataBinding Location="~/custom/unitedthera/pcnbinreport/services/unitedtheradataservice.svc" DataService-TableName="PCNBINReportViewSet" />
          <%--<Scrolling AllowScroll="false" UseStaticHeaders="false" ScrollHeight="400px" />--%>
          <%--<Selecting AllowRowSelect="true" /> --%>
    </ClientSettings>
</telerik:RadGrid>
<pinso:RadGridWrapper runat="server" ID="radGridWrapper" Target="gridPCNBINReport" PagingSelector="#divTile3Container .pagination"  CustomPaging="false"  MergeRows="false" RequiresFilter="false" AutoUpdate="false" AutoLoad="true"/>
