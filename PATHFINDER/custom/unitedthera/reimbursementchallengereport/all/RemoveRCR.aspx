<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Modal.master" AutoEventWireup="true" CodeFile="RemoveRCR.aspx.cs" Inherits="custom_Alcon_customercontactreports_all_RemoveCCR" %>
<%@ Register src="../controls/RCR_RemoveRCRScript.ascx" tagname="RemoveRCRScript" tagprefix="pinso" %>
<%@ Register src="../controls/RCR_RemoveRCR.ascx" tagname="RemoveRCR" tagprefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <pinso:RemoveRCRScript ID="RemoveRCRScript" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="title" Runat="Server">
  <asp:Label ID="titleText" runat="server" Text="Remove Selected Reimbursement Challenge Report"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="tools" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" Runat="Server">
    <pinso:RemoveRCR ID="RemoveRCR" runat="server" />
</asp:Content>