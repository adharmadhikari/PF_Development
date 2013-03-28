<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GoalsMonthTemplate.ascx.cs" Inherits="controls_GoalsMonthTemplate" %>
<table style="width:100%" cellpadding="0" cellspacing="0"> 
    <tr>
        <td style="width:50%" class="alignRight"><%# Eval(DataField1, "{0:n0}") %></td>
        <td style="width:50%" class="alignRight"><%# Eval(DataField2, "{0:n2}")%></td>
    </tr>
</table>