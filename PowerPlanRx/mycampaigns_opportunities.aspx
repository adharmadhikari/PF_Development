<%@ Page Title="PowerPlanRx - My Campaign Opportunities" Language="C#" MasterPageFile="~/MasterPage.master" EnableViewState="true"  Theme="impact" AutoEventWireup="true" CodeFile="mycampaigns_opportunities.aspx.cs" Inherits="mycampaigns_opportunities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
<script type="text/javascript">

    $(document).ready(function() {
        var i = 0;
        var brand;
        $("#dial").dialog({ autoOpen: false, modal: true, width: 800, height: 450, title: "", resizable: false, draggable: false });
        for (i = 0; i < 100; i++) {
            
            brand = "Brand" + i;

            var j = $("." + brand);
           
            if (j.length > 0) 
                j.text($("#" + brand).val());            
            else
                break;
        }


    });

    function validate() //To notify user to select a market basket from dropdown
    { 
        var combo = $find("<%= mbradcombobox.ClientID %>");
        var text = combo.get_value();
        if (text == "0")            
        {
            alert("Please select a market basket.");

            return false;
        }
       
        return true;
    }

    function createNewCampaign(url)
    {
        $("#dial").html("<iframe style='height:100%;width:100%'></iframe>").dialog('option', 'title', 'Create Campaign').dialog('open').find("iframe").attr("src", url);        
    }

    function showBrandComparison(PlanID, BrandID,MBID) {

        $("#dial").html("Loading...").load("BrandComparisonPieChart.aspx?plan_id=" + PlanID + "&mb_id=" + MBID + "&brand_id=" + BrandID + " form >*").dialog('option', 'title', 'Brand Comparison').dialog('open');
    }
</script> 
 <script type="text/javascript">
     /* <![CDATA[ */
     var cancelDropDownClosing = false;

     function StopPropagation(e) {
         //cancel bubbling
         e.cancelBubble = true;
         if (e.stopPropagation) {
             e.stopPropagation();
         }
     }

     function onDropDownClosing() {
         cancelDropDownClosing = false;
     }

     function onCheckBoxClick(chk) {
         var combo = $find("<%= RadComboBox1.ClientID %>");
         var RTb =   $get("<%= tempbox1.ClientID %>");
         
         //prevent second combo from closing
         cancelDropDownClosing = true;
         //holds the text of all checked items
         var text = "";
         //holds the values of all checked items
         var values = "";
         //get the collection of all items
         var items = combo.get_items();
         //enumerate all items
         for (var i = 0; i < items.get_count(); i++) {
             var item = items.getItem(i);
             //get the checkbox element of the current item
             var chk1 = $get(combo.get_id() + "_i" + i + "_chk1");
             if (chk1.checked) {
                 text += item.get_text() + ",";
                 values += item.get_value() + ",";
             }
         }
         //remove the last comma from the string
         text = removeLastComma(text);
         values = removeLastComma(values);

         if (text.length > 0) {
             //set the text of the combobox
             combo.set_text(text);
             RTb.value = values;
            
           
         }
         else {
             //all checkboxes are unchecked
             //so reset the controls
             combo.set_text("");
            
            
            
         }
     }

     //this method removes the ending comma from a string
     function removeLastComma(str) {
         return str.replace(/,$/, "");
     }

    
     function OnClientDropDownClosingHandler(sender, e) {
         //do not close the second combo if 
         //a checkbox from the first is clicked
         e.set_cancel(cancelDropDownClosing);
     }
     /* ]]> */ 
        </script>




    <div class="MC_Opportunity">
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td class="tileContainerHeader" colspan="7">My Campaign Opportunity</td>
        </tr>
        <tr>
            <td>Market Basket:</td>   
            <td ><telerik:RadComboBox SkinID="impactGen" ID="mbradcombobox" runat="server" DataSourceID="SqlDataSource1" DataTextField="MB_Name"  AutoPostBack="true"  OnSelectedIndexChanged="mbradcombobox_SelectedIndexChanged"  DataValueField="MB_ID" AppendDataBoundItems="true" EnableEmbeddedSkins="false">       
                <Items>
                    <telerik:RadComboBoxItem runat="server" Value="0" Text="Select a Market Basket" />  
                </Items>       
                </telerik:RadComboBox>               
            </td>
            <td >Segment:</td>
            <td><telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="rcbsegment" runat="server" DataSourceID="SqlDataSource2" DataTextField="Segment_Name"      DataValueField="Segment_ID" AppendDataBoundItems="true" >
                 <Items>
                    <telerik:RadComboBoxItem runat="server" Value="0" Text="All Segments" />  
                 </Items>
                </telerik:RadComboBox>    
            </td>
            <td>Brands:</td>
            <td>       
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="RadComboBox1" runat="server" DataSourceID="SqlDataSource3"
                        DataValueField="Brand_ID" DataTextField="Brand_Name" EmptyMessage="Please select a brand" HighlightTemplatedItems="true"
                        AllowCustomText="true" Width="240px" OnClientDropDownClosed="onDropDownClosing">
                        <ItemTemplate>
                            <div onclick="StopPropagation(event)">
                                <asp:CheckBox runat="server" ID="chk1" Checked="false" onclick="onCheckBoxClick(this)"/>
                                <asp:Label runat="server" ID="Label1" AssociatedControlID="chk1">
                                    <%# Eval("Brand_Name")%>
                                </asp:Label>                                
                            </div>
                        </ItemTemplate>
                    </telerik:RadComboBox>                   
                    <asp:HiddenField ID="tempbox1" runat="server" Value="" />          
            </td>
      
         
          <td>         
                <asp:HiddenField ID="brandscnt" runat="server" Value="" />
                <asp:HiddenField ID="NNBrandsList" runat="server" Value="" /> 
           <div class="impactBtns" id="div1" runat="server">
            <pinso:CustomButton ID="btnSubmit" EnableEmbeddedSkins="false" SkinID="formButton" runat="server" Text="Submit" OnClientClick=" return validate()" onclick="btnSubmit_Click" />            
           </div>
         </td>
      </tr>    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="SELECT distinct [MB_ID], [MB_Name] FROM [Lkp_Products]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="SELECT [Segment_ID], [Segment_Name] FROM [Lkp_Segment]where Segment_Name<>'OTH'">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="SELECT DISTINCT Brand_ID, Brand_Name FROM Lkp_Products WHERE Is_Campaign_Brand = 0 AND  MB_ID = @MB_ID"> 
        <selectparameters>
        <asp:SessionParameter Name="TID" SessionField="TerritoryID" Type="String" /> 
        <asp:controlparameter name="MB_ID" controlid="mbradcombobox" propertyname="SelectedValue" Type="Int32" />
        </selectparameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="SELECT distinct [Brand_ID] FROM [Lkp_Products] where MB_ID=@MB_ID and Is_Campaign_Brand =1"> 
        <selectparameters>
            <asp:controlparameter name="MB_ID" controlid="mbradcombobox" propertyname="SelectedValue" Type="Int32" />
        </selectparameters>
        </asp:SqlDataSource>		    
   </table>
  </div>
    <div class="MC_Results" id="divResult" runat="server" visible="false">   
    <telerik:RadSplitter EnableEmbeddedBaseStylesheet="false" runat="server" ID="radSplitter" SkinID="ImpactradSplitter" ResizeWithBrowserWindow="true" Width="100%" OnClientLoaded="resizeSplitter" OnClientResized="resizeSplitter">
        <telerik:RadPane runat="server" ID="radPaneChart" Collapsed="true" Width="60%" CssClass="leftPane">         
            <img src="content/images/chart.jpg" />
        
        <DCWC:Chart Visible=false ID="Chart1" runat="server" BackColor="#FFFFFF" Width="712px" Height="400px" BorderLineStyle="Solid" Palette="Dundas" BackGradientType="TopBottom" 
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
        <telerik:RadSplitBar runat="server" CollapseMode="Forward" CollapseExpandPaneText="Expand/Collapse to View Bubble Chart" />
        <telerik:RadPane runat="server" Scrolling="Both" ID="radPaneGrid" Width="40%" EnableEmbeddedScripts="false" CssClass="rightPane" >            
            <telerik:RadGrid OnSortCommand="onSort" ID="GridView1" SkinID="table1" EnableEmbeddedSkins="false" runat="server" AllowSorting="True" GridLines="None" AutoGenerateColumns="False" BorderStyle="None"  EmptyDataText="No Data available" DataSourceID="SqlDataSource4"  Width="100%">
            <MasterTableView autogeneratecolumns="False" datakeynames="Plan_ID" datasourceid="SqlDataSource4">
          
            <Columns>
                <telerik:GridBoundColumn DataField="Plan_ID" HeaderText="Plan_ID" ReadOnly="True"  Visible="false" SortExpression="Plan_ID" />             
                <telerik:GridTemplateColumn HeaderText="" ItemStyle-CssClass="addRationale merged" HeaderStyle-CssClass="headerTh">     
                    <ItemTemplate>                                                 
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# string.Format("javascript:createNewCampaign(\"Campaign_Rationale.aspx?Plan_ID={0}&Brand_ID={1}&SegmentID={2}&BrandList={3}\")",Eval("Plan_ID"),Eval("Novo_Brand_Id"),Eval("Segment_Id"),CompetitorsBrandIDs+","+Eval("Novo_Brand_Id")) %>' 
                        runat="server" ImageUrl="~/App_Themes/impact/images/plus.gif"></asp:HyperLink>              
                    </ItemTemplate>                     
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText=""  HeaderStyle-CssClass="headerTh"  ItemStyle-CssClass="merged">     
                    <ItemTemplate>  
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# string.Format("javascript:showBrandComparison(\"{0}\", {1},{2})", Eval("Plan_ID"), Eval("Novo_Brand_Id"),mbradcombobox.SelectedValue) %>' runat="server" ImageUrl="~/App_Themes/impact/images/pie_icon.gif"></asp:HyperLink>  
                    </ItemTemplate>                      
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="Ranking" HeaderText="Rank" ReadOnly="True" SortExpression="Ranking"  HeaderStyle-CssClass="headerTh"  ItemStyle-CssClass="merged" />                            
                <telerik:GridBoundColumn DataField="Plan_Name" HeaderText="Plan Name" ReadOnly="True" SortExpression="Plan_Name"  HeaderStyle-CssClass="headerTh"  ItemStyle-CssClass="merged alignLeft" />           
                <telerik:GridBoundColumn DataField="Section_ID" HeaderText="Section_ID" ReadOnly="True" Visible="false"  SortExpression="Section_ID"  HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged" />
                <telerik:GridBoundColumn DataField="Section_Name" HeaderText="Section_Name" Visible="false" ReadOnly="True" SortExpression="Section_Name"  HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged alignLeft" />
                <telerik:GridBoundColumn DataField="Segment_ID" HeaderText="Segment_ID" ReadOnly="True" Visible="false" SortExpression="Segment_ID" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged" />
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
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>" SelectCommand="usp_Get_Campaign_Opportunity_Data6" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="mbradcombobox" Name="MB_ID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="rcbsegment" Name="Segment_ID" PropertyName="SelectedValue" Type="Int32" />           
            <asp:SessionParameter Name="AE_Territory_ID" SessionField="TerritoryID" Type="String" /> 
            <asp:ControlParameter ControlID="brandscnt" Name="Competitor_Brand_num" Type="Int32" />
            <asp:ControlParameter ControlID="NNBrandsList" Name="Competitor_Brand_ID" Type="String" DefaultValue="" />          
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
    <div id="dial" style="display:none;"></div>
</asp:Content>