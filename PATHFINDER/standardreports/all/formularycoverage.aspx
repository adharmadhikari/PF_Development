﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Pyramid.master" AutoEventWireup="true" CodeFile="formularycoverage.aspx.cs" Inherits="standardreports_all_formularycoverage" %>
<%@ Register src="../controls/formularycoveragechart.ascx" tagname="formularycoveragechart" tagprefix="pinso" %>
<%@ Register src="../controls/formularycoveragedata.ascx" tagname="formularycoverageSummary" tagprefix="pinso" %>
<%@ Register src="../controls/formularycoveragescript.ascx" tagname="FormularyCoverageScript" tagprefix="pinso" %>
<%@ Register src="../controls/FormularyCoverageDrillDown.ascx" tagname="FormularyCoverageDrillDown" tagprefix="pinso" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="scriptContainer" Runat="Server">
    <pinso:FormularyCoverageScript ID="formularycoveragescript" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Tile3Title" Runat="Server">
    <asp:Literal runat="server" ID="lbl1" Text='<%$ Resources:Resource, SectionTitle_FormularyCoverage %>' />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:TileOptionsMenu runat="server" ID="optionsMenu" UserRole="export"/>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Tile3" Runat="Server"> 
 
  <div id="divformularystatusChart" style="height:100%;margin-left: 5%;">        
        <pinso:formularycoveragechart ID="chartFormularyCoverage" runat="server" Thumbnail="true" /> 
  </div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="Tile4Title" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Tile4Tools" Runat="Server">
 <%--<div id="StdReportPieChart" onclick="javascript:OpenPieChartViewer(null,null,550,400);" ></div>--%>
</asp:Content>

<asp:Content ID="Content7" ContentPlaceHolderID="Tile4" Runat="Server">
    <pinso:formularycoverageSummary ID="gridFormularyCoverageSummary" runat="server" />
</asp:Content>

<asp:Content ID="Content8" ContentPlaceHolderID="Tile5Title" Runat="Server">
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="Tile5Tools" Runat="Server">
</asp:Content>

<asp:Content ID="Content10" ContentPlaceHolderID="Tile5" Runat="Server">
    <pinso:FormularyCoverageDrillDown ID="gridDrilldown" runat="server" />
</asp:Content>

