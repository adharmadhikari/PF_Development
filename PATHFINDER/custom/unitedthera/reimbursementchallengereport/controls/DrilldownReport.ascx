<div id="tile3DataDrillDown">
<telerik:RadGrid SkinID="radTable" runat="server" ID="gridrcrDrilldown" AllowSorting="true" AutoGenerateColumns="false" 
     AllowPaging="false" AllowFilteringByColumn="false" EnableEmbeddedSkins="false" PageSize="50" >
    <MasterTableView PageSize="50" AutoGenerateColumns="false" ClientDataKeyNames="RCR_Report_ID, Issue_ID">
            <Columns>
                <telerik:GridBoundColumn DataField="Account_Manager" HeaderStyle-Width="8%" HeaderText="Account Manager" SortExpression="Account_Manager" UniqueName="Account_Manager" /> 
                <telerik:GridBoundColumn DataField="Plan_Name" HeaderStyle-Width="10%" HeaderText='<%$ Resources:Resource, Label_Account_Name %>' SortExpression="Plan_Name" UniqueName="Plan_Name" /> 
                <telerik:GridBoundColumn DataField="Geography_Name" HeaderStyle-Width="8%" HeaderText="Geography" SortExpression="Geography_Name" UniqueName="Geography_Name" /> 
                <telerik:GridBoundColumn DataField="Contact_Date" DataType ="System.DateTime" DataFormatString="{0:M/dd/yyyy}" HeaderStyle-Width="8%" HeaderText='Report Date' SortExpression="Contact_Date" UniqueName="Contact_Date" ItemStyle-CssClass="alignRight" /> 	
                <telerik:GridBoundColumn DataField="Section_Name"  HeaderStyle-Width="8%" HeaderText="Section Name" SortExpression="Section_Name" UniqueName="Section_Name" /> 
                <telerik:GridBoundColumn DataField="Issue_Name"  HeaderStyle-Width="8%" HeaderText="Issue Name" SortExpression="Issue_Name" UniqueName="Issue_Name" /> 
                <telerik:GridBoundColumn DataField="Other_Issue"  HeaderStyle-Width="8%" HeaderText="Issue Type Other" SortExpression="Other_Issue" UniqueName="Other_Issue" /> 
                <telerik:GridBoundColumn DataField="Drug_Name"  HeaderStyle-Width="8%" HeaderText="Drug" SortExpression="Drug_Name" UniqueName="Drug_Name" /> 
                <telerik:GridBoundColumn DataField="Status_Name"  HeaderStyle-Width="6%" HeaderText="Status" SortExpression="Status_Name" UniqueName="Status_Name" /> 
                <telerik:GridBoundColumn DataField="ASSIST_Desc"  HeaderStyle-Width="8%" HeaderText="ASSIST Description" SortExpression="ASSIST_Desc" UniqueName="ASSIST_Desc" /> 
                <telerik:GridBoundColumn DataField="Contact_Name"  HeaderStyle-Width="8%" HeaderText="Contact(s)" SortExpression="Contact_Name" UniqueName="Contact_Name" /> 
                <telerik:GridBoundColumn DataField="Team_Comments"  HeaderStyle-Width="8%" HeaderText="Team Comments" SortExpression="Team_Comments" UniqueName="Team_Comments" /> 
               
            </Columns>         
            <PagerStyle Visible="false" />     
            <SortExpressions>
                <telerik:GridSortExpression FieldName="Account_Manager" />
            </SortExpressions>             
        </MasterTableView>
        
        <ClientSettings>
            <DataBinding Location="../services/UnitedTheraDataService.svc"  DataService-TableName="RCReportDrilldownViewSet" 
                 />               
            <Scrolling AllowScroll="True" UseStaticHeaders="true"  />
            <%--<Selecting AllowRowSelect="true" />--%>
        </ClientSettings>   
</telerik:RadGrid>
</div>
<pinso:RadGridWrapper runat="server" ID="radGridWrapper" Target="gridrcrDrilldown" MergeRows="true" PagingSelector="#divTile3Container .pagination" AutoUpdate="true" RequiresFilter="true" AutoLoad="false" ShowNumberOfRecords="true" />
