<%@ Page Title="Report" Language="C#" MasterPageFile="~/Report.master" Theme="impact" AutoEventWireup="true" CodeFile="reports.aspx.cs" Inherits="reports" %>


<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
<script language="javascript" type="text/javascript">
//function called when report type is changed
function OnClientReportTypeChanged(sender, eventArgs)
{
    var comboType = $find("<%= ddlReportType.ClientID %>");
    var comboDist = $find("<%= ddlDistrict.ClientID %>");
    var comboTerritory = $find("<%= ddlManagedMarketsTerritory.ClientID %>");
    
    //if report type = summary, disable the district and territory combo boxes.
    if (comboType._selectedIndex == 1) {
        comboDist.disable();
        comboTerritory.disable();       
    }
    else {
        comboDist.enable();
        comboTerritory.enable();
    }       
}
</script>
    <div class="tileContainerHeader">
        <asp:Label ID="lblHeader" runat="server" Text="Reports"></asp:Label>
       </div>
       <div class="reportsPage">
        <table width="100%" >
            <col width="10%" />
            <col width="25%" />
            <col width="5%" />
            <col width="25%" />
            <col width="5%" />
            <col width="25%" />
            <tr>
                <td>       
                    <asp:Label CssClass="label" ID="lblReportType" runat="server" Text="Report Type"></asp:Label> 
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge" 
                        ID="ddlReportType" runat="server" OnClientSelectedIndexChanged="OnClientReportTypeChanged">
                        <Items>          
                            <telerik:RadComboBoxItem Text="--Select--" Value="0"/>
                            <telerik:RadComboBoxItem Text="Summary" Value="1" Selected="True"/>
                            <telerik:RadComboBoxItem Text="Details" Value="2"/>      
                        </Items>
                    </telerik:RadComboBox>
                </td>   

                
                <td>
                    <asp:Label CssClass="label" ID="lblStrategicAcct" runat="server" Text='<%$ Resources:Resource, Label_Strategic_Account %>'></asp:Label>
                </td>
                <td>
                <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge" 
                    ID="ddlStrategicAccount" runat="server" DataSourceID = "dsStrategicPlans"
                    DataTextField="Strategic_Plan_Name" DataValueField="Parent_ID" AppendDataBoundItems="true">
                     <Items>    
                         <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_Strategic_Account %>' Value="0"/>
                     </Items> 
                </telerik:RadComboBox> 
                </td>
            </tr>
            <tr>
                
                <td>
                    <asp:Label CssClass="label" ID="lblArea" runat="server" Text='<%$ Resources:Resource, Label_Retail_Area %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge" 
                        ID="ddlArea" runat="server" DataSourceID="dsRetailsArea" AutoPostBack="true" OnSelectedIndexChanged="OnAreaChanged"
                        DataTextField="Area_Name" DataValueField="AREA_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_Area %>' Value="0" />
                        </Items>
                    </telerik:RadComboBox> 
                </td>
                      
                <td>
                    <asp:Label CssClass="label" ID="lblRegion" runat="server" Text='<%$ Resources:Resource, Label_Retail_Region %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"
                        ID="ddlRegion" runat="server" DataSourceID="dsRetailsRegion" AutoPostBack="true" OnSelectedIndexChanged="OnRegionChanged" 
                        DataTextField="Region_Name" DataValueField="Region_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_Region %>' Value="0"/>
                        </Items>
                     </telerik:RadComboBox> 
                 </td>
              
            </tr>
            <tr>  
                <td>
                    <asp:Label CssClass="label" ID="lblDistrict" runat="server" Text='<%$ Resources:Resource, Label_Retail_District %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"
                        ID="ddlDistrict" runat="server" DataSourceID="dsRetailsDistrict" Enabled="false"
                        DataTextField="District_Name" DataValueField="District_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_District %>' Value="0"/>
                        </Items>
                   </telerik:RadComboBox> 
               </td>
             
                
                <td>
                    <asp:Label CssClass="label" ID="lblManagedMarketsArea" runat="server" Text='<%$ Resources:Resource, Label_Managed_Care_Area %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"
                        ID="ddlManagedMarketsArea" runat="server" DataSourceID="dsMangedMarketsArea" AutoPostBack="true" OnSelectedIndexChanged="OnMCAreaChanged" 
                        DataTextField="Area_Name" DataValueField="AREA_ID" AppendDataBoundItems="true" >
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_MC_Area %>' Value="0"/>
                        </Items>
                     </telerik:RadComboBox> 
                 </td>
              
               </tr>
            <tr>                
                <td>
                    <asp:Label CssClass="label" ID="lblManagedMarketsRegion" runat="server" Text='<%$ Resources:Resource, Label_Managed_Care_Region %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"
                        ID="ddlManagedMarketsRegion" runat="server" DataSourceID="dsManagedMarketsRegion" AutoPostBack="true" OnSelectedIndexChanged="OnMCRegionChanged"
                        DataTextField="Region_Name" DataValueField="Region_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_MC_Region %>' Value="0"/>
                        </Items>
                   </telerik:RadComboBox>
               </td> 
                
                
                <td>
                    <asp:Label CssClass="label" ID="lblManagedMarketsTerritory" runat="server" Text='<%$ Resources:Resource, Label_Managed_Care_Territory %>'></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"        
                        ID="ddlManagedMarketsTerritory" runat="server" DataSourceID="dsManagedMarketsTerritory" AutoPostBack="true" 
                        OnSelectedIndexChanged="OnMCTerritoryChanged" Enabled="false"
                        DataTextField="Territory_Name" DataValueField="Territory_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_MC_Territory %>' Value="0"/> 
                        </Items>
                    </telerik:RadComboBox>
                </td> 
                
           </tr>
            <tr>      
                    <td>     
                        <asp:Label CssClass="label" ID="lblAE" runat="server" Text='<%$ Resources:Resource, Label_Account_Executive %>'></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"        
                            ID="ddlAccountExecutive" runat="server" DataSourceID="dsAccountExecutive" 
                            DataTextField="UserName" DataValueField="User_ID" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_AE %>' Value="0"/>
                            </Items>
                       </telerik:RadComboBox> 
                   </td>
                   
                              
                    <td>
                        <asp:Label CssClass="label" ID="lblBrands" runat="server" Text='<%$ Resources:Resource, Label_Brand %>'></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox  EnableEmbeddedSkins="false"  SkinID="impactGenLarge"         
                            ID="ddlBrands" runat="server" DataSourceID="dsCampaignBrands"
                            DataTextField="Brand_Name" DataValueField="Brand_ID" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text='<%$ Resources:Resource, Label_Any_Brand %>' Value="0"/>
                            </Items>
                        </telerik:RadComboBox> 
                    </td>
                </tr>
       </table>
      
    <!--Retail Area-->
 
    
    <pinso:CustomButton ID="btnSubmit" runat="server" Text="Submit" onclick="btntempSubmit_Click" /> 
    
    <asp:Label ID="lblMessage" runat="server" Text="No Records present for the selected search criteria." Visible="false"></asp:Label>
    <asp:CompareValidator ValueToCompare="--Select--" Operator="NotEqual" ControlToValidate="ddlReportType"
            ErrorMessage="Please select a report type." runat="server" ID="valReportType" />
    <asp:SqlDataSource ID="dsStrategicPlans" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetStrategicPlans" SelectCommandType="StoredProcedure" > 
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="dsRetailsArea" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetAreaName" SelectCommandType="StoredProcedure"> 
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsRetailsRegion" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetRegionName" SelectCommandType="StoredProcedure"> 
        <SelectParameters>
           <asp:ControlParameter ControlID="ddlArea" Name="Area_ID" PropertyName="SelectedValue" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsRetailsDistrict" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetDistrictNameByAreaIDRegionID" SelectCommandType="StoredProcedure">
            <SelectParameters>    
                <asp:ControlParameter ControlID="ddlArea" Name="Area_ID" PropertyName="SelectedValue" DefaultValue="0" />          
                <asp:ControlParameter ControlID="ddlRegion" Name="Region_ID" PropertyName="SelectedValue" DefaultValue="0" />
            </SelectParameters> 
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsMangedMarketsArea" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetManagedMarketsAreaName" SelectCommandType="StoredProcedure"> 
    </asp:SqlDataSource>    
    <asp:SqlDataSource ID="dsManagedMarketsRegion" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetManagedMarketRegionName" SelectCommandType="StoredProcedure" > 
        <SelectParameters>
           <asp:ControlParameter ControlID="ddlManagedMarketsArea" Name="MCArea_ID" PropertyName="SelectedValue" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsManagedMarketsTerritory" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetTerritoryIDByAreaIDRegionID" SelectCommandType="StoredProcedure" > 
        <SelectParameters>    
                <asp:ControlParameter ControlID="ddlManagedMarketsArea" Name="MCArea_ID" PropertyName="SelectedValue" DefaultValue="0" />          
                <asp:ControlParameter ControlID="ddlManagedMarketsRegion" Name="MCRegion_ID" PropertyName="SelectedValue" DefaultValue="0" />
            </SelectParameters> 
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsAccountExecutive" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetAEDetails" SelectCommandType="StoredProcedure" > 
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlManagedMarketsTerritory" Name="Territory_ID" PropertyName="SelectedValue" DefaultValue="0" />        
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsCampaignBrands" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
        SelectCommand="usp_GetBrandName" SelectCommandType="StoredProcedure" > 
    </asp:SqlDataSource> 
       </div>
</asp:Content>

