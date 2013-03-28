﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SingleSection.master" AutoEventWireup="true" CodeFile="affiliations.aspx.cs" EnableViewState="false" Inherits="todaysaccounts_combined_affiliations_section2" %>
<%@ Register src="~/todaysaccounts/controls/AffiliationsListView.ascx" tagname="AffiliationsListView" tagprefix="pinso" %>
<%@ Register src="~/todaysaccounts/controls/AffiliationsListViewScript.ascx" tagname="AffiliationsListViewScript" tagprefix="pinso" %>
<%@ Register src="~/todaysaccounts/controls/AffiliationsToolbar.ascx" tagname="AffiliationsToolbar" tagprefix="pinso" %>

<%-- Today's Accounts - Combined -  Affiliations --%>

<asp:Content runat="server" ContentPlaceHolderID="scriptContainer">
    <pinso:AffiliationsListViewScript runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Tile3Title" Runat="Server">
    <asp:Literal runat="server" ID="titleText" Text='<%$ Resources:Resource, SectionTitle_PlanAffiliations %>' />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:AffiliationsToolbar runat="server" ID="affilToolbar" />
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Tile3" Runat="Server">
    <pinso:AffiliationsListView  ID="AffiliationsListView" runat="server" AffiliationType="1" />      
</asp:Content>

