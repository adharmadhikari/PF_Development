﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SingleSection.master" AutoEventWireup="true" CodeFile="formularydrilldown.aspx.cs" Inherits="standardreports_all_formularydrilldown" %>
<%@ Register src="~/standardreports/controls/FDrilldownScript.ascx" tagname="FDrilldownScript" tagprefix="pinso" %>
<%@ Register src="~/standardreports/controls/FDrilldownData.ascx" tagname="FDrilldownData" tagprefix="pinso" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptContainer" Runat="Server">
	<pinso:FDrilldownScript ID="fdrilldownscript" runat="server" />  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Tile3Title" runat="Server">
    <asp:Literal runat="server" ID="Literal1" Text="Formulary Drill Down" />
</asp:Content>
<asp:Content ID="optionsMenuContent" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:TileOptionsMenu runat="server" ID="optionsMenu" UserRole="sr_fdx" ExportConfirm="true" />   
</asp:Content>
<asp:Content runat="server" ID="tile3" ContentPlaceHolderID="Tile3">
		<pinso:FDrilldownData ID="fdrilldowndata" runat="server" />
</asp:Content>