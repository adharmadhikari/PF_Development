<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Goals.ascx.cs" Inherits="controls_GoalsByDistrict" %>
    <script type="text/javascript">
        
        $(document).ready(function()
        {
                var browserWindow = $(window);
        var divHeight = browserWindow.height();
        var divWidth = browserWindow.width();

            $(".row .merged").attr("rowspan", 2);
            $(".alt .merged").css("display", "none");

            $("#dial").dialog({ resizable: false, draggable: false, autoOpen: false, modal: true, width: divWidth-100, height:600,  title: "" });

            var dateKey = $("#startDateKey").val();
            var dt = new Date(dateKey.substr(4) + "/1/" + dateKey.substr(0,4));
           
            for(var i=0; i<=12; i++)
            {                                
                $(".month" + i).text(dt.format("MMM yyyy"));    
                
                dt.setMonth(dt.getMonth() +1);            
            }
    
            if(<%= IsEdit.ToString().ToLower() %>)
                $(".targeted").removeAttr("disabled").find("input").removeAttr("disabled");
            else
                $(".targeted").attr("disabled", "disabled").find("input").attr("disabled", "disabled");
        });
        
        function showDistrictPhysicians(campaignId, dist, start, end)
        {
            $("#dial").html("Loading...").load("physicians.aspx?id=" + campaignId + "&dist=" + dist + "&start=" + start + "&end=" + end + " form >*").dialog('option', 'title', 'Physician List').dialog('open');
        }

        function showDistrictChart(campaignId, dist, start, end,brandid)
        {
            $("#dial").html("Loading...").load("districtprofiletrxchart.aspx?id=" + campaignId + "&dist=" + dist + "&start=" + start + "&end=" + end + "&brandid=" + brandid + " form >*").dialog('option', 'title', 'District Profile').dialog('open');
        }
    </script>
        
    <asp:Panel runat="server" ID="panelCampaignInformation">
        <div class="tileContainerHeader">
                    <div class="CampaignInfo">Campaign Name: <asp:Label runat="server" ID="lblPlanName" /></div>
                </div>
                
        
    </asp:Panel>
    <div class="tileSubHeader">Plan Goals</div>
    <telerik:RadGrid CssClass="topGrid" EnableEmbeddedSkins="false" runat="server" ID="gridView" AutoGenerateColumns="false" DataSourceID="dsPlanGoals" AllowSorting="true" AllowPaging="false">
        <PagerStyle Position="Top" />
        <MasterTableView AllowSorting="true" DataKeyNames="Campaign_ID, BaselineTrx, BaselineMst, MB_Trx, Data_Year, Data_Month">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Brand" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="brand">
                    <ItemTemplate>
                        <asp:Literal ID="lblRecordType" runat="server" Visible='<%# (int)Eval("RecordType") == 1 %>' Text='<%# Eval("Brand_Name") %>' />                        
                        <asp:Literal ID="Label2" runat="server" Visible='<%# (int)Eval("RecordType") != 1 %>' Text='Competitors' />                                                
                    </ItemTemplate>
                </telerik:GridTemplateColumn>               
                <telerik:GridTemplateColumn  HeaderStyle-CssClass="rightScroll"  ItemStyle-CssClass="rightScroll">
                    <HeaderTemplate>
                        <table style="width:100%" cellpadding="0" cellspacing="0"> 
                            <tr>
                                <td colspan="2">Baseline</td>
                            </tr>
                            <tr>
                                <td class="left">Trx</td>
                                <td class="right">Mst</td>
                            </tr>
                        </table>                    
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table style="width:100%" cellpadding="0" cellspacing="0"> 
                            <tr>
                                <td><%# Eval("BaselineTrx", "{0:n0}")%></td>
                                <td><%# Eval("BaselineMst", "{0:n2}")%></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>                            
            </Columns>
        </MasterTableView>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"  Scrolling-FrozenColumnsCount="2"  />
    </telerik:RadGrid>
      <div class="tileSubHeader">District Goals</div>  
    <telerik:RadGrid CssClass="btmGrid"  EnableEmbeddedSkins="false" runat="server" ID="gridViewDistricts" AutoGenerateColumns="false" DataSourceID="dsPlanDistrictGoals"  AllowSorting="true" AllowPaging="false">
        <MasterTableView AllowPaging="false" DataKeyNames="Campaign_ID, District_Name, Trx, Mst, MB_Trx, Data_Year, Data_Month" AllowSorting="false">
            <ItemStyle CssClass="row" />
            <AlternatingItemStyle CssClass="alt" />
            <Columns>   
                <telerik:GridTemplateColumn HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged">                
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chkTargeted" CssClass="targeted" Visible='<%# (bool)Eval("InDistrict") && string.Compare(Eval("District_Name").ToString(), "Non-Targeted", true) != 0 %>'  Checked='<%# Eval("Campaign_Flag_Indicator") %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged">                
                    <ItemTemplate>
                        <asp:HyperLink runat="server" ID="physLink" Visible='<%# (bool)Eval("InDistrict") && string.Compare(Eval("District_Name").ToString(), "Non-Targeted", true) != 0 %>' NavigateUrl='<%# string.Format("javascript:showDistrictPhysicians({0}, \"{1}\", {2}, {3})", Eval("Campaign_ID"), Eval("District_Name"), Eval("Start_Data_Key"), Eval("End_Data_Key")) %>' ToolTip="Top Physicians"><img src="content/images/list.png" alt="Top Physicians" /></asp:HyperLink>                     
                        <asp:HyperLink runat="server" ID="distLink" Visible='<%# (bool)Eval("InDistrict") && string.Compare(Eval("District_Name").ToString(), "Non-Targeted", true) != 0 %>' NavigateUrl='<%# string.Format("javascript:showDistrictChart({0}, \"{1}\", {2}, {3},{4})", Eval("Campaign_ID"), Eval("District_Name"), Eval("Start_Data_Key"), Eval("End_Data_Key"), Eval("Brand_ID")) %>' ToolTip="District Profile Brand Trx"><img src="content/images/chart.gif" alt="District Profile Brand Trx" /></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn HeaderText="District" DataField="District_Name" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="merged" />                
                <telerik:GridTemplateColumn HeaderText="Brand" HeaderStyle-CssClass="headerTh" ItemStyle-CssClass="brand">
                    <ItemTemplate>
                        <asp:Literal ID="lblRecordType" runat="server" Visible='<%# (int)Eval("RecordType") == 1 %>' Text='<%# Eval("Brand_Name") %>' />                        
                        <asp:Literal ID="Label2" runat="server" Visible='<%# (int)Eval("RecordType") != 1 %>' Text='Competitors' />                        
                    </ItemTemplate>
                </telerik:GridTemplateColumn>   
                <telerik:GridTemplateColumn HeaderStyle-CssClass="rightScroll" ItemStyle-CssClass="rightScroll">
                    <HeaderTemplate  >
                        <table style="width:100%" cellpadding="0" cellspacing="0"> 
                            <tr>
                                <td colspan="2" class="top">Baseline</td>
                            </tr>
                            <tr>
                                <td class="left">Trx</td>
                                <td class="right">Mst</td>
                            </tr>
                        </table>                    
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table style="width:100%" cellpadding="0" cellspacing="0"> 
                            <tr>
                                <td class="alignRight"><%# Eval("Trx", "{0:n0}") %></td>
                                <td class="alignRight"><%# Eval("Mst", "{0:n2}")%></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>             
            </Columns>
        </MasterTableView>
        
        <%-- FROZEN COLUMN count is set in code since it depends on columns that are sometimes hidden. --%>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" />
    </telerik:RadGrid>
    
    <asp:SqlDataSource runat="server" ID="dsPlanGoals" ConnectionString='<%$ConnectionStrings:impact %>' 
         UpdateCommand="usp_Campaign_UpdateGoals" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource runat="server" ID="dsPlanDistrictGoals" ConnectionString='<%$ConnectionStrings:impact %>' >
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>    
    
    <div id="dial" style="display:none;">
    </div>