﻿<%@ Page  EnableViewStateMac="false"  Title="" Theme="pathfinder" Language="C#" MasterPageFile="~/MasterPages/SingleSection.master" AutoEventWireup="true" CodeFile="contacts.aspx.cs" Inherits="custom_millennium_todaysaccounts_varecords_contacts" %>
<%@ Register src="~/custom/millennium/todaysaccounts/controls/KDMDetailsVAR.ascx" tagname="KDMDetailsVAR" tagprefix="pinso" %>
<%@ Register src="~/custom/millennium/todaysaccounts/controls/KDMAddressVAR.ascx" tagname="KDMAddressVAR" tagprefix="pinso" %>
<%@ Register src="~/custom/millennium/todaysaccounts/controls/KDMScript.ascx" tagname="KDMScript" tagprefix="pinso" %>
<%@ Register src="~/custom/millennium/todaysaccounts/controls/AddEditKDMScript.ascx" tagname="AddEditKDMScript" tagprefix="pinso" %>
<%-- Today's Accounts - VARecords -  Plan Information & Contacts --%>

<asp:Content ContentPlaceHolderID="scriptContainer" runat="server" ID="scriptContainer1">
    <pinso:KDMScript ID="KDMScript1" runat="server" /> 
     
     <pinso:AddEditKDMScript ID="AddEditKDMScrip1" runat="server" /> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Tile3Title" Runat="Server">
    <asp:Literal runat="server" ID="titleText3" Text='Key Decision Makers' />
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="Tile3Tools" Runat="Server">
    <pinso:TileOptionsMenu runat="server" ID="planDetailsTileOptions" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile3" Runat="Server">
    <pinso:KDMDetailsVAR ID="KDMDetailsVAR" runat="server" />
    <pinso:KDMAddressVAR ID="KDMAddressVAR1" runat="server" />
</asp:Content>



