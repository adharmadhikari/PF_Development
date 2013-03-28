<%@ Page Title="" Language="C#" MasterPageFile="~/custom/unitedthera/reimbursementchallengereport/MasterPages/ReimbursementChallengeReport.master" AutoEventWireup="true" CodeFile="reimbursementissueentry.aspx.cs" Inherits="custom_pinso_customercontactreports_all_customercontactreport" %>
<%@ Register Src="../controls/RCRGridView.ascx" TagName="RCRGridList" TagPrefix="pinso" %>
<%@ Register Src="../controls/BusinessPlansGrid.ascx" TagName="RCBusinessDocument" TagPrefix="pinso" %>
<%@ Register Src="../controls/RCRPlanGridView.ascx" TagName="RCPlanGrid" TagPrefix="pinso" %>
<%@ Register Src="../controls/RCReportScripts.ascx" TagName="RCPlanScript" TagPrefix="pinso" %>

<asp:Content ID="content8" ContentPlaceHolderID="scrptContainer" runat="server">
   <pinso:RCPlanScript ID="ccplanscript1" runat="server" />
</asp:Content>
<asp:Content ID="content7" ContentPlaceHolderID="Tile8Title" runat="server">
      Plan Select
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="Tile8Tools" runat="server">
    <a id="AddCCRLnk" class='reqsel' href="javascript:OpenRCR('AddIR');">Add New Issue</a>
    <span class="reqsel">|</span>
    <a href='javascript:resetSectionPlans()'>Reset</a>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Tile8" Runat="Server">
    <pinso:RCPlanGrid ID="CCPlan1" runat="server" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Tile6Title" Runat="Server">
    Issue Reports
</asp:Content>
<asp:Content ContentPlaceHolderID="Tile6Tools" runat="server">
<a id="A3" class="reqsel" href="javascript:viewRCR();">View</a>
    <span class="reqsel">|</span>
    <a id="A4" class="reqsel" href="javascript:OpenDeleteRCR();">Delete</a>
    </asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Tile6" Runat="Server">
    <pinso:RCRGridList ID ="CCRGridList1" runat ="server" />
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="Tile7Title" Runat="Server">
    Support Documentation
</asp:Content>
  <asp:Content ContentPlaceHolderID="Tile7Tools" runat="server">
  <a id="A1" href="javascript:OpenDocUpload('AddIR');">Upload</a> 
    <span class='reqsel'>|</span> 
    <a id="A2" class="reqsel" href="javascript:viewDocument();">View</a>
    <span class="reqsel">|</span>
    <a id="DeleteCCRLnk" class="reqsel" href="javascript:OpenDeleteDoc();">Delete</a>
   </asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Tile7" Runat="Server">
    <pinso:RCBusinessDocument ID ="BusinessDocument1" runat="server" />
</asp:Content>
