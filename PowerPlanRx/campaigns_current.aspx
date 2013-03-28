<%@ Page Title="PowerPlanRx - Campaigns" Language="C#" MasterPageFile="~/MasterPage.master" Theme="impact" AutoEventWireup="true" CodeFile="campaigns_current.aspx.cs" Inherits="campaigns_current" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server"> 
<%--<style>
 .RadGrid a:hover {COLOR: Blue}
</style>--%>
<div class="tileContainerHeader">
<div class="CampaignInfo">Campaign Opportunity Assessment For</div>
</div>
<telerik:RadGrid runat="server" ID="gridCampaigns" SkinID="table1" EnableEmbeddedSkins="false"  AutoGenerateColumns="false" DataSourceID="dsCampaigns"  
    Width="100%" AllowPaging="true">
    
    <MasterTableView AllowSorting="true" AllowMultiColumnSorting="true" PagerStyle-Position="Top" PagerStyle-CssClass="pagerImpact">    
        <Columns>
            <telerik:GridBoundColumn HeaderText="ID" DataField="Campaign_ID" SortExpression="Campaign_ID" />
            <telerik:GridBoundColumn HeaderText="Area Name (MC)" DataField="MC_Area_Name" SortExpression="MC_Area_Name" />
            <telerik:GridBoundColumn HeaderText="Region Name (MC)" DataField="MC_Region_Name" SortExpression="MC_Region_Name" />   
            <telerik:GridBoundColumn HeaderText="NAM Territory (MC)" DataField="SAE_Territory_Name" /> 
            <telerik:GridBoundColumn HeaderText="AM Territory (MC)" DataField="MC_Territory_Name" SortExpression="MC_Territory_Name" /> 
            <telerik:GridBoundColumn HeaderText="AM" DataField="Full_Name" SortExpression="User_L_Name" /> 
            <telerik:GridHyperLinkColumn HeaderText="Campaign Name" DataTextField="Campaign_Name" DataTextFormatString="{0}" 
                DataNavigateUrlFields="Campaign_ID" DataNavigateUrlFormatString="createcampaign_step1_profile.aspx?id={0}" 
                SortExpression="Campaign_Name" />             
            <telerik:GridBoundColumn HeaderText="District Name (RTL)" DataField="RTL_District_Name" SortExpression="RTL_District_Name" />
            <telerik:GridBoundColumn HeaderText="Region Name (RTL)" DataField="RTL_Region_Name" SortExpression="RTL_Region_Name" />
            <telerik:GridBoundColumn HeaderText="Area Name (RTL)" DataField="RTL_Area_Name" SortExpression="RTL_Area_Name" />
            <telerik:GridBoundColumn HeaderText="AM Name" DataField="Full_Name" SortExpression="User_L_Name" Visible="false" />
            <telerik:GridBoundColumn HeaderText="Status" DataField="Status_Name" SortExpression="Status_Name" />
            <telerik:GridBoundColumn HeaderText="Next Phase" DataField="Next_Phase_Name" SortExpression="Next_Phase_Name" />
            <telerik:GridBoundColumn HeaderText="Date Created" DataField="Created_DT" SortExpression="Created_DT" DataFormatString="{0:d}" ItemStyle-CssClass="lastCol" />
        </Columns>        
    </MasterTableView>
    <ClientSettings>
    <Selecting AllowRowSelect="true" />
            <Scrolling AllowScroll="true" UseStaticHeaders="false" />
    </ClientSettings>
</telerik:RadGrid> 

<asp:SqlDataSource ID="dsCampaigns" runat="server"  ConnectionString="<%$ ConnectionStrings:impact %>" 
 SelectCommand="usp_GetCampaignInfo" SelectCommandType="StoredProcedure">
</asp:SqlDataSource>
</asp:Content>

