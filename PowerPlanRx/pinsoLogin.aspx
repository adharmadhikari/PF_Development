<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pinsoLogin.aspx.cs" Theme="impact"
    Title="PowerPlanRx Login" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
            
            <img id="Img1" class="userIcon" runat="server" src="~/content/images/user.jpg" alt="User Icon" />
            <div class="userInfo">
                <asp:Login runat="server" ID="login1" SkinID="loginBox" DestinationPageUrl="~/home.aspx" MembershipProvider="StandardMembershipProvider"
                    DisplayRememberMe="false">
                    <LayoutTemplate>
                        <span class="coreTextBox"><span class="bg"><span class="bg2">
                            <asp:TextBox TabIndex="1" CssClass="textBox" ID="UserName" runat="server" EnableViewState="false"
                                AutoCompleteType="Disabled"></asp:TextBox>
                        </span></span></span><span class="rightCol">
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                Text="*"></asp:RequiredFieldValidator><asp:Label ID="LabelUserName" Text="Username"
                                    runat="server" />
                        </span>
                        <div class="clearAll">
                        </div>
                        <span class="coreTextBox"><span class="bg"><span class="bg2">
                            <asp:TextBox TabIndex="2" CssClass="textBox" ID="Password" runat="server" TextMode="Password"
                                EnableViewState="false"></asp:TextBox>
                        </span></span></span><span class="rightCol">
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                Text="*"></asp:RequiredFieldValidator></span><asp:Label ID="LabelPassword" Text="Password"
                                    runat="server" />
                        <div class="clearAll">
                        </div>
                        <asp:Button ID="Login" SkinID="formButton" CommandName="Login" Text="Sign In" runat="server" /><br /><br />
                        <p class="error">
                            <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                        </p>
                        <div id="spanProgress">
                            <asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Resource, Message_VerifyingUser %>' /></div>
                        <div class="optionLinks" runat="server" id="additionalOptions">
                            Register &bull; <a href="javascript:forgotPassword()">Forgot your password?</a>  <br />
                            <a href="javascript:resetUserName()">Sign in with a different account</a>
                        </div>
                    </LayoutTemplate>
                </asp:Login>
            </div>
            <div class="clearAll">
            </div>
        </div>
        <div>
        </div>
    </div>
    <div class="footer">
        <div class="inside">
            
            &copy; Pinsonault Associates, LLC. All Rights Reserved. Version 1.0</div>
    </div>
    <div id="forgotPassword" style="display:none;">
        <div id="forgotPasswordSubmit">
            <div>Enter your email address and then press Submit to request a new password.</div>
            <asp:TextBox runat="server" ID="txtEmail" Width="400px" />
            <asp:Button runat="server" ID="btnSubmitEmail" Text="Submit" OnClientClick="return submitEmail()" CausesValidation="false" UseSubmitBehavior="false" />
        </div>
        <div id="forgotPasswordStatus"></div>
    </div>
    </form>
</body>
</html>
