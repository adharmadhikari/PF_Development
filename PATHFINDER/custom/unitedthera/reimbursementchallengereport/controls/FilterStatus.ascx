<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FilterStatus.ascx.cs" Inherits="custom_unitedthera_reimbursementchallengereport_controls_filterstatus" %>
<asp:PlaceHolder runat="server" id="placeholder">
  <div class="filterGeo">
        <asp:Literal runat="server" ID="filterLabel" Text='Status' />
    </div>
    <telerik:RadComboBox runat="server" ID="Status_ID" DataSourceID="dsStatus" DataTextField="Status_Name" DataValueField="Status_ID" 
      AppendDataBoundItems="true" Skin="pathfinder" EnableEmbeddedSkins="false" MaxHeight="300px" >
        
    </telerik:RadComboBox>  
  
</asp:PlaceHolder>
<asp:EntityDataSource ID="dsStatus" runat="server" ConnectionString="name=PathfinderUnitedTheraEntities"  EntitySetName="LkpRCReportStatusSet" DefaultContainerName="PathfinderUnitedTheraEntities" OrderBy="it.Status_ID"
    AutoGenerateWhereClause="True">
</asp:EntityDataSource> 

 