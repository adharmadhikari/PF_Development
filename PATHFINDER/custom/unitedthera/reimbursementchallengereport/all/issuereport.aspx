<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Pyramid.master" AutoEventWireup="true" CodeFile="issuereport.aspx.cs" EnableViewState="true" Inherits="custom_unitedthera_reimbursementchallengereport_all_issuereport" %>
<%@ Register src="~/custom/unitedthera/reimbursementchallengereport/controls/IssueReportScript.ascx" tagname="irScript" tagprefix="uc1" %>
<%@ Register src="~/custom/unitedthera/reimbursementchallengereport/controls/IssueReportData.ascx" tagname="irData" tagprefix="uc2" %>
<%@ Register src="~/custom/unitedthera/reimbursementchallengereport/controls/IssueReportDetails.ascx" tagname="irDataDetails" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptContainer" runat="Server">
    <uc1:irScript ID="irScript1" runat="server" /> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Tile3Title" runat="Server">
    <asp:Literal runat="server" ID="lbl1" Text='Reimbursement Challenge Issue Report' /> 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:TileOptionsMenu runat="server" ID="optionsMenu" ExportConfirm="false" />
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Tile3" runat="Server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="Tile4Title" Runat="Server">
    Summary View
</asp:Content>

<asp:Content ID="Content6" ContentPlaceHolderID="Tile4Tools" Runat="Server">
</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="tile4" runat="server" >
    <uc2:irData id="irData1" runat="server" />
</asp:Content>

<asp:Content ID="Content8" ContentPlaceHolderID="Tile5Title" Runat="Server">
    Detailed View
</asp:Content>

<asp:Content ID="Content9" ContentPlaceHolderID="Tile5Tools" Runat="Server">
</asp:Content>

<asp:Content ID="Content10" ContentPlaceHolderID="tile5" runat="server" >
   <uc3:irDataDetails ID="irDetails1" runat="server" />  
</asp:Content>
