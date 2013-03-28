<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FilterIssueType.ascx.cs" Inherits="custom_controls_FilterIssueType" %>

<div class="filterGeo">
    <asp:Literal runat="server" ID="filterLabel" Text="Issue Type" />
    
</div>
<telerik:RadComboBox ID="Issue_ID" runat="server" EnableEmbeddedSkins="false" Skin="pathfinder" AppendDataBoundItems="true">
</telerik:RadComboBox>


