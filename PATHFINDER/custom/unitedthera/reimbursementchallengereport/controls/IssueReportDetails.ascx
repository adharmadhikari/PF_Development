<%@ Control Language="C#" AutoEventWireup="true" CodeFile="IssueReportDetails.ascx.cs" Inherits="custom_controls_IssueReportDetails" %>

  <telerik:RadGrid SkinID="radTable" runat="server" ID="gridIR" AllowSorting="true"   
        PageSize="50" AllowPaging="true" AllowFilteringByColumn="false" EnableEmbeddedSkins="false" Width="100%" >
        <MasterTableView AutoGenerateColumns="False" ClientDataKeyNames="Plan_Name, Contact_Date, Issue_Name" PageSize="50"
         AllowMultiColumnSorting="true" Width="100%" >
            <Columns>
            <telerik:GridBoundColumn DataField="Account_Manager" HeaderStyle-Width="10%" ItemStyle-CssClass="firstCol planName"
                     HeaderText='Account Manager'  UniqueName="Account_Manager" 
                     DataType="System.String" /> 

             <telerik:GridBoundColumn DataField="Plan_Name" HeaderText="Account Name" ItemStyle-CssClass="planName"
                          UniqueName="Plan_Name" DataType="System.String" HeaderStyle-Width="18%" />                          

             <telerik:GridBoundColumn DataField="Contact_Date" HeaderText='Date' ItemStyle-CssClass="alignRight contactDT"
                         UniqueName="Contact_Date" DataType ="System.DateTime" DataFormatString="{0:M/dd/yyyy}" HeaderStyle-Width="8%"> </telerik:GridBoundColumn>         
                
             <telerik:GridBoundColumn DataField="Issue_Name" HeaderText="Issue Type" ItemStyle-CssClass="issueType"
                          UniqueName="Issue_Name" DataType="System.String" HeaderStyle-Width="13%" />
                 
             <telerik:GridBoundColumn DataField="Drug_Name" HeaderText="Product(s) Discussed" ItemStyle-CssClass="drugName"
                          UniqueName="Drug_Name" DataType="System.String" HeaderStyle-Width="10%" />
                
             <telerik:GridBoundColumn DataField="Contact_Name" HeaderText='Contact(s)' ItemStyle-CssClass="contactName"
                        UniqueName="Contact_Name"  DataType ="System.String" HeaderStyle-Width="15%"/>  
                               
             <telerik:GridBoundColumn DataField="Followup_Date" HeaderText='Follow-Up Date' ItemStyle-CssClass="alignRight contactDT"
                         UniqueName="Followup_Date" DataType ="System.DateTime" DataFormatString="{0:M/dd/yyyy}" HeaderStyle-Width="8%"> </telerik:GridBoundColumn>         
                       
             <telerik:GridBoundColumn DataField="Status_Name" HeaderText="Status" HeaderStyle-Width="10%" ItemStyle-CssClass="status" 
                       UniqueName="Status_Name" DataType="System.String"></telerik:GridBoundColumn>
                
            </Columns>
            <PagerStyle Visible="false" />
            
            <SortExpressions>
<%--          <telerik:GridSortExpression FieldName="Account_Manager" />
                <telerik:GridSortExpression FieldName="Plan_Name" SortOrder="Ascending" /> 
                <telerik:GridSortExpression FieldName="Contact_Date" />
                <telerik:GridSortExpression FieldName="Issue_Name" />
                <telerik:GridSortExpression FieldName="Contact_Name" />
                <telerik:GridSortExpression FieldName="Followup_Date" />
                <telerik:GridSortExpression FieldName="Status_Name" />    --%>        
            </SortExpressions>
        </MasterTableView>
   

       <ClientSettings >
           <DataBinding Location="~/custom/unitedthera/reimbursementchallengereport/services/UnitedTheraDataService.svc" DataService-TableName="RCReportIssueDetailsViewSet"
                />         
            <Scrolling AllowScroll="True" UseStaticHeaders="True" />
        </ClientSettings> 
    </telerik:RadGrid>

   <pinso:RadGridWrapper runat="server" ID="radGridWrapper" Target="gridIR"  MergeRows="true" PagingSelector="#divTile5Container .pagination" RequiresFilter="true" AutoUpdate="true" DrillDownLevel="1" UtcDateColumns="Contact_Date, Followup_Date"/>
    
    