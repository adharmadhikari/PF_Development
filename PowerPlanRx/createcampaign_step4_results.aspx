<%@ Page Title="PowerPlanRx - Step 4 Results" Language="C#" MasterPageFile="~/MasterPage.master" Theme="impact" AutoEventWireup="true" CodeFile="createcampaign_step4_results.aspx.cs" Inherits="createcampaign_step4_results" %>
<%@ Register Src="~/controls/Goals.ascx" TagName="Goals" TagPrefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <pinso:Goals runat="server" ID="goals" ShowResults="true" />
</asp:Content>

