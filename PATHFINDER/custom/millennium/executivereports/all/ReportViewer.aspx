﻿<%@ Page EnableViewState="true" Language="C#" AutoEventWireup="true" CodeFile="ReportViewer.aspx.cs" Inherits="custom_millennium_executivereports_all_ReportViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
</head>

<body style="margin: 0 0 0 0;">
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager AsyncPostBackTimeout="900" ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <rsweb:ReportViewer ID="ReportViewer1" runat="server" ProcessingMode="Remote" Width="100%" >        
            <ServerReport  />
        </rsweb:ReportViewer>
        <script language="javascript" type="text/javascript">
            ResizeReportViewer();
            function ResizeReportViewer()
            {
                var rptviewer = document.getElementById("<%= ReportViewer1.ClientID %>");
                var htmlheight = document.documentElement.clientHeight;
                rptviewer.style.height = (htmlheight - 50) + "px";
            }
            window.onresize = function resize() { ResizeReportViewer(); } 
        </script> 
    </div>
    </form>
</body>
</html>
