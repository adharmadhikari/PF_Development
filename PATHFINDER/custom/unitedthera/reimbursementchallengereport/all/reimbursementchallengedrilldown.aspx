<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/SingleSection.Master" CodeFile="reimbursementchallengedrilldown.aspx.cs" Inherits="custom_unitedthera_reimbursementchallengereport_all_reimbursementchallengedrilldown" %>

<%@ Register src="../controls/DrilldownReportScript.ascx" tagname="DrilldownReportScript" tagprefix="pinso" %>
<%@ Register src="../controls/DrilldownReport.ascx" tagname="DrillDownReport" tagprefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scriptContainer" runat="Server">
    <pinso:DrilldownReportScript ID="RestrictionsReportscript" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Title" runat="Server">
    <asp:Literal runat="server" ID="lbl1" Text='Reimbursement Challenge Drilldown Report' />
</asp:Content>
<asp:Content ID="optionsMenuContent" ContentPlaceHolderID="Tile3Tools" runat="Server">
   <pinso:TileOptionsMenu runat="server" ID="optionsMenu" ExportConfirm="false" />
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="Tile3">
    <pinso:DrilldownReport ID="gridDrilldown" runat="server" />
</asp:Content>
