﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DistrictProfileGrid_All.ascx.cs" Inherits="controls_DistrictProfileGrid_All" %>
<table width="100%" border="0" >
           <col width="2%" />
            <col width="96%" />
            <col width="2%" />
            
<tr><td></td>
<td>
<asp:FormView ID="frmHeader" runat="server" DataSourceID="dsCommercial">
    <ItemTemplate> 
         
        <div class="tileSubHeader DistrictProfileModal">
            <asp:Label ID="lblBrandName" runat="server" Text='<%#(string.Format("Brand Name: {0}",Eval("Brand_Name")))%>'></asp:Label>
        
    </div>
    </ItemTemplate>
</asp:FormView>
</td>
</tr>
<tr><td></td>
<td>
<asp:GridView ID="grvCommercial"  runat="server" AutoGenerateColumns="False" DataSourceID="dsCommercial">
    <Columns>       
        <asp:BoundField DataField="Plan_Name" HeaderText="Top 5 Commercial Accounts in the District" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Left" />
        <asp:BoundField DataField="Brand_Trx" HeaderText="Trx"  DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>
        <asp:TemplateField HeaderText="Percentage (%)" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right" >
            <ItemTemplate>
                <asp:Label ID="lblPercentComm" runat="server" 
                    Text='<%# (string.Format("{0}{1}",Eval("PercentBrandTrxDistrictTotal","{0:n2}"),"%")) %>'></asp:Label>
            </ItemTemplate>           
        </asp:TemplateField>
        <asp:BoundField DataField="MB_Trx" HeaderText="Market Volume" DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>
    </Columns>
</asp:GridView>
</td>
</tr>
<tr><td></td>
<td>
<asp:GridView ID="grvOther" runat="server" AutoGenerateColumns="False" DataSourceID="dsOther" >
    <Columns>           
        <asp:TemplateField  HeaderText="All Other Accounts in the District" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Left">
            <ItemTemplate><asp:Label ID="lblOtherAccounts" Text="All Other Plans" runat="server"></asp:Label></ItemTemplate>
        </asp:TemplateField>  
        <asp:BoundField  DataField="OtherBrandTrxTotal" HeaderText="Trx" DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>
        <asp:TemplateField  HeaderText="Percentage (%)" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <asp:Label ID="lblPercentOther" runat="server" 
                    Text='<%# (string.Format("{0}{1}",Eval("PercentBrandTrxDistrictTotal","{0:n2}"),"%")) %>'></asp:Label>
            </ItemTemplate>           
        </asp:TemplateField>
        <asp:BoundField  DataField="OtherMarketTrxTotal" HeaderText="Market Volume" DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>  
    </Columns>
</asp:GridView>
</td>
</tr>
<tr><td></td>
<td>
<asp:GridView ID="grvPartD" runat="server" AutoGenerateColumns="False" DataSourceID="dsPartD" >
    <Columns>            
        <asp:BoundField DataField="Plan_Name" HeaderText="Top 5 Medicare Part D Accounts in the District" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Left" />
        <asp:BoundField DataField="Brand_Trx" HeaderText="Trx" DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>
        <asp:TemplateField HeaderText="Percentage (%)" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <asp:Label ID="lblPercentPartD" runat="server" 
                    Text='<%# (string.Format("{0}{1}",Eval("PercentBrandTrxDistrictTotal","{0:n2}"),"%")) %>'></asp:Label>
            </ItemTemplate>           
        </asp:TemplateField>
        <asp:BoundField DataField="MB_Trx" HeaderText="Market Volume" DataFormatString="{0:n0}" HeaderStyle-CssClass="headerList" ItemStyle-CssClass="itemList" ItemStyle-HorizontalAlign="Right"/>
    </Columns>   
</asp:GridView>
</td>
</tr>
</table>
<asp:SqlDataSource ID="dsCommercial" runat="server" 
    ConnectionString='<%$ConnectionStrings:impact %>'
    ProviderName="System.Data.SqlClient" 
    SelectCommand="usp_GetSV_BaseByDistrictIDBrandID" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="District_ID" 
            QueryStringField="dist" Type="String" />
        <asp:QueryStringParameter DefaultValue="0" Name="Brand_ID" 
            QueryStringField="brandid" Type="Int32" />
        <asp:Parameter DefaultValue="1" Name="Segment_ID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsOther" runat="server" 
    ConnectionString='<%$ConnectionStrings:impact %>'
    ProviderName="System.Data.SqlClient" 
    SelectCommand="usp_GetSV_Base_Other" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="District_ID" 
            QueryStringField="dist" Type="String" />
        <asp:QueryStringParameter DefaultValue="0" Name="Campaign_ID" 
            QueryStringField="id" Type="Int32" />        
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsPartD" runat="server" 
    ConnectionString='<%$ConnectionStrings:impact %>'
    ProviderName="System.Data.SqlClient" 
    SelectCommand="usp_GetSV_BaseByDistrictIDBrandID" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="0" Name="District_ID" 
            QueryStringField="dist" Type="String" />
        <asp:QueryStringParameter DefaultValue="0" Name="Brand_ID" 
            QueryStringField="brandid" Type="Int32" />
        <asp:Parameter DefaultValue="2" Name="Segment_ID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>


