<%@ Page Title="Region/District Drill Down Report" Language="C#" MasterPageFile="~/Report.master" Theme="impact" AutoEventWireup="true"
    CodeFile="DistrictRegionBrandReport.aspx.cs" Inherits="DistrictRegionBrandReport" %>

<%@ Register Src="~/controls/DistrictRegionBrand.ascx" TagName="DistrictRegionBrand"
    TagPrefix="pinso" %>
<%@ Register Src="~/controls/DistrictRegionBrand_All.ascx" TagName="DistrictRegionBrand_All"
    TagPrefix="pinso" %>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="tileContainerHeader">
        <asp:Label ID="lblHeader" runat="server" Text="Region/District Drill Down Report"></asp:Label>
    </div>
    <div class="districtsReportsPage">
        <table border="0" cellpadding="0" cellspacing="0" width="100%"  >
        <col width="10%" />
        <col width="25%" />
        <col width="5%" />
        <col width="25%" />
        <col width="5%" />
        <col width="25%" />

            <tr>
                <td>
                    <asp:Label ID="lblReportType" runat="server" Text="Report Type"></asp:Label>&nbsp;<span
                        style="font-weight: bold; color: Red;">*</span>
                        </td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlReportType"
                        runat="server" CausesValidation="False">
                        <Items>
                            <%--<telerik:RadComboBoxItem   Value="0" Text="-- Select a Type --" />--%>
                            <telerik:RadComboBoxItem Value="1" Text="Single Brand TRx" />
                            <telerik:RadComboBoxItem Value="2" Text="Market Basket Group TRx" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Label ID="lblBrands" runat="server" Text="Brand"></asp:Label>&nbsp;<span style="font-weight: bold;
                        color: Red;">*</span></td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlBrands"
                        runat="server" DataSourceID="dsBrand" DataTextField="Brand_Name" DataValueField="Brand_ID"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="-- Select a Brand --" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Label ID="lblSegment" runat="server" Text="Segment"></asp:Label>&nbsp;<span
                        style="font-weight: bold; color: Red;">*</span></td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlSegment"
                        runat="server" DataSourceID="dsSegment" DataTextField="Segment_Long_Name" DataValueField="Segment_ID"
                        AppendDataBoundItems="true">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="-- Select a Segment --" />
                        </Items>
                    </telerik:RadComboBox>
                    <br />
                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblArea" runat="server" Text="Area"></asp:Label></td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlArea"
                        runat="server" DataSourceID="dsArea" DataTextField="Area_Name" DataValueField="Area_ID"
                        AutoPostBack="true" AppendDataBoundItems="true" 
                        OnSelectedIndexChanged="OnAreaChanged" CausesValidation="False">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="-- Any Area --" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Label ID="lblRegion" runat="server" Text="Region"></asp:Label>&nbsp;<span style="font-weight: bold;
                        color: Red;">*</span></td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlRegion"
                        runat="server" DataSourceID="dsRegion" DataTextField="Region_Name" DataValueField="Region_ID"
                        AutoPostBack="true" AppendDataBoundItems="true" Width="180" 
                        OnSelectedIndexChanged="OnRegionChanged" CausesValidation="False">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="-- Select a Region --" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Label ID="lblDistrict" runat="server" Text="District"></asp:Label></td><td>
                    <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlDistrict"
                        runat="server" DataSourceID="dsDistrict" DataTextField="District_Name" DataValueField="District_ID" DropDownWidth="200px"
                        AppendDataBoundItems="true" CausesValidation="False">
                        <Items>
                            <telerik:RadComboBoxItem Value="0" Text="-- Any District --" />
                        </Items>
                    </telerik:RadComboBox>
                    <br />                    
                    
                </td>
            </tr>
        </table>
        <pinso:CustomButton ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        
        <%--<asp:CompareValidator id="cvType" 
         runat="server" ErrorMessage="Please select a Type"
         ControlToValidate="ddlReportType" ValueToCompare="-- Select a Type --" Operator="NotEqual">         
        </asp:CompareValidator>
        <br />--%>
        <asp:CompareValidator Display="None" ID="cvBrand" runat="server" ErrorMessage="Please select a Brand"
            ControlToValidate="ddlBrands" ValueToCompare="-- Select a Brand --" Operator="NotEqual">         
        </asp:CompareValidator>
        <br />
        <asp:CompareValidator Display="None" ID="cvSegment" runat="server" ErrorMessage="Please select a Segment"
            ControlToValidate="ddlSegment" ValueToCompare="-- Select a Segment --" Operator="NotEqual">         
        </asp:CompareValidator>
        <asp:CompareValidator Display="None" ID="cvRegion" runat="server" ErrorMessage="Please select a Region"
            ControlToValidate="ddlRegion" ValueToCompare="-- Select a Region --" Operator="NotEqual">         
        </asp:CompareValidator>
                    
        <asp:ValidationSummary ID="ValidationSummary1" DisplayMode="BulletList" EnableClientScript="true" runat="server"/>

        <asp:Label ID="lblMessage" runat="server" Text="No Records present for the selected search criteria."
            Visible="false"></asp:Label>
        
       
        <asp:Panel runat="server" ID="pnlResult" Visible="false">
            <div class="exportControls">
                <asp:HiddenField ID="hdnQString" runat="server" />
                <a class="pdf" href="javascript:exportPDF('ctl00_ctl00_main_main_content_hdnQString','ctl00_ctl00_main_main_content_DistrictRegionBrand_ChartAll','DistrictRegionBrandReport','pdf')">
                    PDF</a> <a class="print" href="javascript:PrintPage('divPageContent','District/Region Profile Chart')">
                        Print</a> <a class="excel" href="Export.aspx?page=districtregionbrandreport&type=excel&<%=Request.QueryString%>">
                            Excel</a>
            </div>
        </asp:Panel>
        
        <div id="divPageContent">
            <pinso:DistrictRegionBrand runat="server" ID="DistrictRegionBrand" />
            <pinso:DistrictRegionBrand_All runat="server" ID="DistrictRegionBrand_All" />
        </div>
        <asp:SqlDataSource ID="dsBrand" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
            SelectCommand="usp_GetBrandName" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="dsSegment" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
            SelectCommand="usp_GetSegmentName" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="dsArea" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
            SelectCommand="usp_GetAreaName" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="dsRegion" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
            SelectCommand="usp_GetRegionName" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlArea" Name="Area_ID" PropertyName="SelectedValue"
                    DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsDistrict" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
            SelectCommand="usp_GetDistrictName" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlRegion" Name="Region_ID" PropertyName="SelectedValue"
                    DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
