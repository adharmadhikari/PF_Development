<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FilterAccountManager.ascx.cs" Inherits="custom_controls_FilterAccountManager" %>
<div class="filterGeo">
    <asp:Literal runat="server" ID="filterLabel" Text="Account Managers" />
</div>
<telerik:RadComboBox ID="NAM_ID" runat="server" EnableEmbeddedSkins="false" Skin="pathfinder" AppendDataBoundItems="true">
</telerik:RadComboBox>