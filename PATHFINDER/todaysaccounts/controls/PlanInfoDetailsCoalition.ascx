﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PlanInfoDetailsCoalition.ascx.cs" Inherits="todaysaccounts_controls_PlanInfoCoalition" %>

    <asp:FormView runat="server" ID="formView" DataSourceID="dsPlanInfoDetails" CellPadding="0" CellSpacing="0" Width="100%">
        <ItemTemplate>
       
            <table class="genTable" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td><asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Resource, Label_Website %>' /></td>
                    <td class="rn"><a target="_blank" href='http://<%# Eval("Plan_WebSite") %>'><%# Eval("Plan_WebSite") %></a>&nbsp;</td>
                </tr>
                <%--<tr>
                    <td colspan="2" class="sectionDisclaimer"><%# Eval("Last_Update_DT", Resources.Resource.Label_Section_Last_Updated)%></td>
                </tr>--%>               
                <tr>
                    <td rowspan="4" colspan="2" class="bn rn">&nbsp;</td>
                </tr>
            </table>       
        </ItemTemplate>
    </asp:FormView>

    <asp:EntityDataSource ID="dsPlanInfoDetails" runat="server" EntitySetName="PlanInfoSet" ConnectionString="name=PathfinderEntities" DefaultContainerName="PathfinderEntities" 
        AutoGenerateWhereClause="true">
        <WhereParameters>       
            <asp:QueryStringParameter QueryStringField="Plan_ID" Name="Plan_ID" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>  