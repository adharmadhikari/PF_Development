<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pcnbinreport.aspx.cs" MasterPageFile="~/MasterPages/SingleSection.master" Inherits="custom_unitedthera_pcnbinreport_Default" %>

<%@ Register src="~/custom/unitedthera/pcnbinreport/controls/PCNBINReport.ascx" tagname="PCNBINReport" tagprefix="pinso" %>
<%@ Register src="~/custom/unitedthera/pcnbinreport/controls/PCNBINReportScript.ascx" tagname="PCNBINReportScript" tagprefix="pinso" %>

<asp:Content ID="Content2" ContentPlaceHolderID="scriptContainer" Runat="Server">
    <pinso:PCNBINReportScript ID="PCNBINReportScript1" runat="server"/>
</asp:Content>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="Tile3Title">
PCN/BIN Report
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Tile3Tools">
    <pinso:TileOptionsMenu runat="server" ID="optionsMenu" ExportConfirm="false" />
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Tile3" Runat="Server">
    <pinso:PCNBINReport ID="PCNBINReport1" runat="server"/>
</asp:Content>