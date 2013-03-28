<%@ Page Title="View Campaign Opportunity Assessment Data" Language="C#" MasterPageFile="~/MasterPages/Popup.master" Theme="impact" AutoEventWireup="true" CodeFile="CampaignOpportunityAssessments.aspx.cs" Inherits="CampaignOpportunityAssessments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<asp:ScriptManagerProxy runat="server" ID="scriptManagerProxy"   >
    <Scripts>
        <asp:ScriptReference Path="https://ajax.microsoft.com/ajax/jquery/jquery-1.3.2.min.js" />
        <asp:ScriptReference Path="content/scripts/jquery-ui-1.7.2.custom.min.js" />
        <asp:ScriptReference Path="content/scripts/ui.js" />
        <asp:ScriptReference Path="content/scripts/css_browser_selector.js" />        
    </Scripts>
</asp:ScriptManagerProxy>

<script type="text/javascript">

    $(document).ready(function() {
        var i = 0;
        var brand;
        
        for (i = 0; i < 100; i++) {
            
            brand = "Brand" + i;

            var j = $("." + brand);
           
            if (j.length > 0) 
                j.text($("#" + brand).val());            
            else
                break;
        }


    });
</script> 
<div class="MC_Results" id="divResult" runat="server">

 <telerik:RadSplitter EnableEmbeddedBaseStylesheet="false" runat="server" ID="radSplitter" SkinID="ImpactradSplitter" Height="500px" ResizeWithBrowserWindow="true" Width="100%" OnClientLoaded="resizeSplitter" OnClientResized="resizeSplitter">
        <telerik:RadPane runat="server" ID="radPaneChart" Collapsed="true" Width="60%" CssClass="leftPane">         
        <DCWC:Chart ID="Chart1" runat="server" BackColor="#FFFFFF" Width="712px" Height="400px" BorderLineStyle="Solid" Palette="Dundas" BackGradientType="TopBottom" 
             BorderLineWidth="0" BorderLineColor="181, 64, 1">
        <Titles>
				<dcwc:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3" Text="Market Profile \n Product Volume/Share by Plan" Color="26, 59, 105"></dcwc:Title>
		</Titles>
            <Legends>
                <DCWC:Legend Name="Default"  Enabled="false" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></DCWC:Legend>
            </Legends> 
            <Legends>
                <DCWC:Legend Name="Legend1"  Enabled="true"  BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></DCWC:Legend>
            </Legends>     
            <%--<BorderSkin SkinStyle="Emboss"></BorderSkin>--%>            
            <Series>              
                <DCWC:Series 
                Name="Novo Brand"                                     
                MarkerBorderColor="64, 64, 64"                 
                ShadowOffset="1"  
                BorderColor="180, 26, 59, 105" 
                Color="220, 65, 140, 240" 
                Font="Trebuchet MS, 9pt"              
                >
                </DCWC:Series>
            </Series>            
            <ChartAreas>
				<dcwc:ChartArea Name="Default" BorderColor="64, 64, 64, 64" BorderStyle="Solid" BackGradientEndColor="White" BackColor="White" ShadowColor="Transparent">
					<AxisY LineColor="64, 64, 64, 64" Title="Market Volume">
						<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Format="N"></LabelStyle>
						<MajorGrid LineColor="64, 64, 64, 64"></MajorGrid>
					</AxisY>
					<AxisX LineColor="64, 64, 64, 64" Title="Market Share(%)">
						<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold"></LabelStyle>
						<MajorGrid LineColor="64, 64, 64, 64"></MajorGrid>
					</AxisX>				
				</dcwc:ChartArea>
			</ChartAreas>      
        </DCWC:Chart>     
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitBar1" runat="server" CollapseMode="Forward" CollapseExpandPaneText="Expand/Collapse to View Bubble Chart" />
        <telerik:RadPane runat="server" Scrolling="Both" ID="radPaneGrid" Width="40%" EnableEmbeddedScripts="false" CssClass="rightPane" >            
            <telerik:RadGrid ID="GridView1" SkinID="table1" EnableEmbeddedSkins="false" runat="server" AllowSorting="False" GridLines="None" AutoGenerateColumns="False" BorderStyle="None"  EmptyDataText="No Data available" DataSourceID="SqlDataSource4"  Width="100%">
            <MasterTableView autogeneratecolumns="False" datakeynames="Plan_ID" datasourceid="SqlDataSource4">
          
            <Columns>
                <telerik:GridBoundColumn DataField="Ranking" HeaderText="Rank" ReadOnly="True" SortExpression="Ranking"  HeaderStyle-CssClass="headerTh"  ItemStyle-CssClass="merged" />                            
                <telerik:GridBoundColumn DataField="Plan_Name" HeaderText="Plan Name" ReadOnly="True" SortExpression="Plan_Name"  HeaderStyle-CssClass="headerTh"  ItemStyle-CssClass="merged alignLeft" />           
                <telerik:GridBoundColumn DataField="Section_Name" HeaderText="Section_Name" Visible="false" ReadOnly="True" SortExpression="Section_Name"  HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged alignLeft" />
                <telerik:GridBoundColumn DataField="Segment_Name" HeaderText="Segment Name" ReadOnly="True" SortExpression="Segment_Name" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged alignLeft" />                
                <telerik:GridBoundColumn DataField="Pharmacy_Lives" HeaderText="Covered Lives"  DataFormatString="{0:#,###}" ReadOnly="True" SortExpression="Pharmacy_Lives" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged alignRight" />                      
                <telerik:GridBoundColumn DataField="MB_Trx" HeaderText="Market Volume" ReadOnly="True" DataFormatString="{0:#,###}" SortExpression="MB_Trx" HeaderStyle-CssClass="rightScroll" ItemStyle-CssClass="rightScroll alignRight" />  
            </Columns>
            </MasterTableView>
                <ClientSettings>
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="0" />
                </ClientSettings>
       </telerik:RadGrid>            
        </telerik:RadPane>
    </telerik:RadSplitter>    
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="usp_Get_Campaign_Opportunity_Data_Archived" SelectCommandType="StoredProcedure">
        <SelectParameters>
                <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
</asp:Content>

