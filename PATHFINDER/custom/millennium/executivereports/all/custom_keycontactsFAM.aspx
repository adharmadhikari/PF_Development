﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/SingleSection.master" AutoEventWireup="true" CodeFile="custom_keycontactsFAM.aspx.cs" Inherits="custom_millennium_executivereports_all_custom_keycontactsFAM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scriptContainer" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile3Title" Runat="Server">
Corporate Key Contacts BY FAM Report
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Tile3Tools" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Tile3" Runat="Server">
    <iframe id="reportviewerframe" src="custom/millennium/executivereports/all/ReportViewer.aspx?reportname=MillenniumExecutiveReports&report=MillenniumKeyContactsByFAMReport"      frameborder="0" width="100%" height="100%">
    </iframe>       

</asp:Content>

