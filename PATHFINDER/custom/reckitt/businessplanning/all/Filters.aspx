﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PartialPage.master" AutoEventWireup="true" CodeFile="Filters.aspx.cs" Inherits="custom_reckitt_businessplanning_all_Filters" %>
<%@ Register src="~/controls/FiltersContainer.ascx" tagname="FiltersContainer" tagprefix="pinso" %>
<%@ Register src="~/controls/FiltersContainerScript.ascx" tagname="FiltersContainerScript" tagprefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scriptContainer" Runat="Server">
    <pinso:FiltersContainerScript runat="server" ID="filtersContainerScript" /> 
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="partialPage" Runat="Server">
  <div class="tileContainerHeader">
        <div class="title">
            <asp:Literal runat="server" ID="literalTitle" Text='<%$ Resources:Resource, Label_Report_Filters %>' />
        </div>
         <div class="tools"><div id="warnings" onclick="$alert()"></div>
        </div>
        <div class="clearAll">
        </div>
    </div>
    <div id="filterControls">
         <pinso:FiltersContainer ID="filtersContainer" runat="server" />
    </div>
    <div class="modalFormButtons" id="filterFormButtons">
        <pinso:CustomButtonNonServer runat="server" id="requestReportButton" Text="Submit" />
        <pinso:CustomButtonNonServer runat="server" id="clearFiltersButton" Text="Reset" />                
    </div> 
</asp:Content>

