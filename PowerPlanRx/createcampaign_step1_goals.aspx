<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Theme="impact" Title="PowerPlanRx - Step 1 Goals" AutoEventWireup="true" CodeFile="createcampaign_step1_goals.aspx.cs" Inherits="createcampaign_step1_goals" %>

<%@ Register Src="~/controls/Goals.ascx" TagName="Goals" TagPrefix="pinso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    
    <pinso:Goals runat="server" ID="goals" ShowResults="false" />
    

     
</asp:Content>

