<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GoalsMonthHeaderWithResultsTemplate.ascx.cs" Inherits="controls_GoalsMonthHeaderWithResults" %>
<table style="width:100%" cellpadding="0" cellspacing="0"> 
    <tr>
        <td colspan="4" class="<%= DataField1 %>"></td>
    </tr>
    <tr>
        <td class="left" colspan="2">Goal</td>
        <td class="right" colspan="2">Actual</td>
    </tr>
    <tr>
        <td class="left"  style="width:25%">Trx</td>
        <td class="left" style="width:25%">Mst</td>
        <td class="left" style="width:25%">Trx</td>
        <td class="right" style="width:25%">Mst</td>
    </tr>
</table>