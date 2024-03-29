﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SingleSection.master" AutoEventWireup="true" CodeFile="livesdistribution.aspx.cs" Inherits="standardreports_all_livesdistribution" %>
<%@ Register src="../controls/LivesDistribution.ascx" tagname="livesdistribution" tagprefix="pinso" %>
<%@ Register src="../controls/LivesDistScript.ascx" tagname="livesdistributionscript" tagprefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scriptContainer" Runat="Server">
    <pinso:livesdistributionscript ID="livesdistributionscript" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Title" Runat="Server">
    <asp:Literal runat="server" ID="Literal1" Text='<%$ Resources:Resource, SectionTitle_LivesDistributionReport %>' />
</asp:Content>
<asp:Content ID="optionsMenuContent" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:TileOptionsMenu runat="server" ID="optionsMenu" UserRole="export"/>
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderID="Tile3" Runat="Server">
    <pinso:livesdistribution ID="gridLivesDistribution" runat="server" />
</asp:Content>

