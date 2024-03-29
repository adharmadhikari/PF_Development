﻿<%@ Page Title="" Language="C#" MasterPageFile="~/standardreports/MasterPages/filters.master" AutoEventWireup="true" CodeFile="formularydrilldown_filters.aspx.cs" Inherits="standardreports_all_formularydrilldown_filters" %>
<%@ Register src="../controls/FilterAccountType.ascx" tagname="FilterAccountType" tagprefix="uc1" %>
<%@ Register src="../controls/FilterGeographyMedD.ascx" tagname="FilterGeography" tagprefix="uc2" %>
<%@ Register src="../controls/FilterReportType.ascx" tagname="FilterReportType" tagprefix="uc3" %>
<%@ Register src="../controls/FilterDrugSelection.ascx" tagname="FilterDrugSelection" tagprefix="uc4" %>
<%@ Register src="../controls/FilterTierSelection.ascx" tagname="FilterTierSelection" tagprefix="uc5" %>
<%@ Register src="../controls/FilterRestrictions.ascx" tagname="FilterRestrictions" tagprefix="uc6" %>
<%@ Register src="../controls/filterbenefitdesign.ascx" tagname="FilterBenefitDesign" tagprefix="uc7" %>
<%@ Register Src="../controls/FilterSection.ascx" tagname="FilterChannel" tagprefix="ucSection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="filtersContainer" Runat="Server">
    <ucSection:FilterChannel ID="Section_ID" runat="server" />
    <uc1:FilterAccountType ID="AccountType" runat="server" />
    <uc2:FilterGeography ID="Geography" runat="server" />
    <uc3:FilterReportType ID="ReportType" runat="server" />
    <uc4:FilterDrugSelection ID="DrugSelection" MaxDrugs="10"  runat="server" />
    <uc5:FilterTierSelection ID="TierSelection" runat="server" />
    <uc6:FilterRestrictions ID="Restrictions" runat="server" />
    <uc7:FilterBenefitDesign ID="BenefitDesign" runat="server" />
</asp:Content>

