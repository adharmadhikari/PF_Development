<%@ Control Language="C#" AutoEventWireup="true" CodeFile="header.ascx.cs" Inherits="controls_header" %>
<div class="welcomeMenu">
    <span style="text-transform:uppercase">Welcome&nbsp;<%= Session["FirstName"] %><%= HttpContext.Current.IsDebuggingEnabled ? string.Format("&nbsp;<a title='debugging only' href='titleSelect.aspx' style='color:yellow'>[{0}-{1}]</a>", UserTitle.CurrentTitleName, Session["territoryID"]) : ""%></span>
    
    <asp:HyperLink ID="linkAdmin" runat="server" NavigateUrl="~/admingoalsandtargets.aspx" Text='<%$ Resources:Resource, Label_Admin %>'></asp:HyperLink>
    <%--<asp:Literal runat="server" Text="&bull;" ID="adminBullet" />--%>    
    
    <span style="display:none;"<asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/dashboard.aspx" Text='<%$ Resources:Resource, Label_Help %>'></asp:HyperLink>
    &bull;</span>
    <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/signout.aspx" Text='<%$ Resources:Resource, Label_Sign_Out %>'></asp:HyperLink></div>
<div class="logo">
    <asp:Image SkinID="mainLogo" ID="PFLogo" runat="server" /> <h1 class="tagLine" id="tagLine" runat="server"><!-- TAG LINE HERE--></h1>
</div>
<div class="clearAll">
</div>
