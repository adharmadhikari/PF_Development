<%@ Page Language="C#" AutoEventWireup="true" CodeFile="titleSelect.aspx.cs" Inherits="titleSelect"
    Theme="impact" Title="PowerPlanRx - Select a role" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link id="Link1" runat="server" href="~/content/styles/main.css" rel="stylesheet"
        type="text/css" />
    <link id="Link2" runat="server" href="~/content/styles/ui.all.css" rel="stylesheet"
        type="text/css" />
</head>
<body class="login">
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="scriptManager" EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Path="https://ajax.microsoft.com/ajax/jquery/jquery-1.3.2.min.js" />
            <asp:ScriptReference Path="content/scripts/jquery-ui-1.7.2.custom.min.js" />
            <asp:ScriptReference Path="content/scripts/login.js" />
            <asp:ScriptReference Path="content/scripts/css_browser_selector.js" />
        </Scripts>
    </asp:ScriptManager>
    <div class="signIn">
        <div class="logos">
            <asp:Image SkinID="loginLogo" ID="PFLogo" runat="server" />
        </div>
        <div class="inside">
            <div>
                Please select a role &nbsp;<br />
                <div class="titleSelectLeft">
                            <telerik:RadComboBox runat="server" ID="dlTitles" EnableEmbeddedSkins="false" SkinID="impactGen"
                                DataSourceID="dsTitles" DataTextField="Title_Name" DataValueField="Title_And_Terr">
                            </telerik:RadComboBox>
                        </div>
                 <div class="titleSelectRight">
                            <pinso:CustomButton runat="server" ID="btnSubmit" Text="Continue" OnClick="OnTitleSelected" />
                </div>
            </div>
        </div>
        <div class="clearAll">
        </div>
    </div>
    <div>
    </div>

    <div class="footer">
        <div class="inside">
    <asp:HyperLink ID="disclaimer" Target="_blank" NavigateUrl="~/content/Privacy Policy.doc" runat="server" Text="Privacy Policy"></asp:HyperLink>
    |
    <asp:HyperLink ID="terms" Target="_blank" NavigateUrl="~/content/Terms and Conditions of Use.doc" runat="server" Text="Terms of Use"></asp:HyperLink>        
    
           &copy; Pinsonault Associates, LLC. All Rights Reserved. Version 1.0</div>
    </div>

    <asp:SqlDataSource runat="server" ID="dsTitles" ConnectionString='<%$ ConnectionStrings:impact %>'
        SelectCommand="usp_GetUserTitles" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="NovoUserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
