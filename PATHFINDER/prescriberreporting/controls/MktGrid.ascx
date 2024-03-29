﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MktGrid.ascx.cs"
    Inherits="prescriberreporting_controls_PrescriberGrid" %>
<asp:GridView runat="server" OnDataBound="detailedGrid_DataBound" GridLines="None"
        OnPreRender="detailedGrid_PreRender" ID="detailedGrid" CssClass="grid gv" 
        HeaderStyle-CssClass="detailedHeader gvh" RowStyle-CssClass="gvr"
    AutoGenerateColumns="False" >
<RowStyle CssClass="gvr"></RowStyle>
        <Columns>
            <asp:BoundField DataField="Plan_Name" HeaderText="Account Name" />                    
            <asp:BoundField DataField="Total_Covered" HeaderText="Lives" ItemStyle-CssClass="alignRight" DataFormatString="{0:N0}"/>
            <asp:TemplateField HeaderText="Drug Name">
                <ItemTemplate>
                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("Product_Name") %>' />                   
                    <input type="hidden" id="dataKey" value='<%# String.Format("{0}~{1}~{2}",Eval("Plan_ID"), Eval("Product_ID"), Eval("Segment_ID")) %>' />                
                </ItemTemplate>
            </asp:TemplateField>     
            <asp:BoundField DataField="Segment_Name" HeaderText="Section" />       
            <asp:BoundField DataField="Tier_Name" HeaderText="Tier" />
            <asp:BoundField DataField="Co_Pay" HeaderText="Co-Pay" ItemStyle-CssClass="alignRight" />
            <asp:TemplateField HeaderText="Restrictions">
                <ItemTemplate>                     
                    <asp:Literal ID="lblPA" runat="server" Text='<%# CheckRestriction((object)DataBinder.Eval(Container.DataItem, "PA"), (object)DataBinder.Eval(Container.DataItem, "QL"), (object)DataBinder.Eval(Container.DataItem, "ST")) %>'/>
                    <%--<asp:Label ID="lblPA" runat="server" Text="PA" Visible='<%# CheckRestriction((object)DataBinder.Eval(Container.DataItem, "PA")) %>'/>
                    <asp:Label ID="lblQL" runat="server" Text="QL" Visible='<%# CheckRestriction((object)DataBinder.Eval(Container.DataItem, "QL")) %>'/>
                    <asp:Label ID="lblST" runat="server" Text="ST" Visible='<%# CheckRestriction((object)DataBinder.Eval(Container.DataItem, "ST")) %>'/>--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

<HeaderStyle CssClass="detailedHeader gvh"></HeaderStyle>
    </asp:GridView> 
