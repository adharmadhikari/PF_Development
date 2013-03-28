<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GoalsMonthWithResultsTemplate.ascx.cs" Inherits="controls_GoalsMonthWithResultsTemplate" %>
<table style="width:100%" cellpadding="0" cellspacing="0"> 
    <tr>
        <td style="width:25%" class="alignRight"><%# Eval(DataField1, "{0:n0}") %></td>
        <td style="width:25%" class="alignRight"><%# Eval(DataField2, "{0:n2}")%></td>
        <td style="width:25%" class="alignRight"><%# Eval(DataField3, "{0:n0}") %></td>
        <td style="width:25%" class="alignRight"><%# Eval(DataField4, "{0:n2}")%></td>
    </tr>
</table>