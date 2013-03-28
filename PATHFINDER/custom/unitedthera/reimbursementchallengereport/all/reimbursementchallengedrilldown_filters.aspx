<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/custom/unitedthera/reimbursementchallengereport/MasterPages/filters.master" CodeFile="reimbursementchallengedrilldown_filters.aspx.cs" Inherits="custom_unitedthera_reimbursementchallengereport_all_reimbursementchallengedrilldown_filters" %>

<%@ Register src="../controls/FilterAccountManager.ascx" tagname="FilterAcctManager" tagprefix="uc0" %>
<%@ Register src="../controls/FilterMarketSegment.ascx" tagname="FilterMarketSegment" tagprefix="uc1" %>
<%@ Register src="../controls/FilterAccount.ascx" tagname="FilterAccounts" tagprefix="uc2" %>
<%@ Register src="../controls/FilterIssueType.ascx" tagname="FilterIssueType" tagprefix="uc3" %>
<%@ Register src="../controls/FilterTimeFrame.ascx" tagname="FilterTimeFrame" tagprefix="uc4" %>
<%@ Register src="../controls/FilterProducts.ascx" tagname="FilterProducts" tagprefix="uc5" %>
<%@ Register src="../controls/FilterStatus.ascx" tagname="FilterStatus" tagprefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="filtersContainer" Runat="Server">
    <uc0:FilterAcctManager ID="FilterAcctManager" runat="server" />
    <uc1:FilterMarketSegment ID="FilterMarketSegment" runat="server" />
    <uc2:FilterAccounts ID="FilterAccount" runat="server" />
    <uc3:FilterIssueType ID="FilterIssueType" runat="server" />
    <uc4:FilterTimeFrame ID="FilterTimeFrame" runat="server" />
    <uc5:FilterProducts ID="FilterProducts" runat="server" />
    <uc6:FilterStatus ID="FilterStatus" runat="server" IncludeAll="true"  />
</asp:Content>