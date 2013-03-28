<%@ Page Title="PowerPlanRx - Campaign Approval" Language="C#" MasterPageFile="~/admin.master" Theme="impact" AutoEventWireup="true" CodeFile="admincampaignapproval.aspx.cs" Inherits="admincampaignapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="content" Runat="Server">
<script type="text/javascript">
    $(document).ready(function()
    {
        $("#a3").addClass("selected");
    }); 
</script>
    <telerik:RadComboBox runat="server" ID="rcbAccountExec" EnableEmbeddedSkins="false" SkinID="impactGen" DataSourceID="dsAccountExec" DataTextField="Name" DataValueField="ID" AutoPostBack="true" />

    <telerik:RadGrid runat="server" ID="radGrid" AutoGenerateColumns="false" DataSourceID="dsCampaignTeam" EnableEmbeddedSkins="false" SkinID="table1" Height="90%">
        <MasterTableView AllowSorting="true">
            <Columns>
                <telerik:GridBoundColumn DataField="Campaign_ID" HeaderStyle-Width="5%" />
                <telerik:GridBoundColumn DataField="Campaign_Name" HeaderText="Campaign" HeaderStyle-Width="30%" />
                <telerik:GridTemplateColumn HeaderText="Name" SortExpression="User_F_Name, User_L_Name" HeaderStyle-Width="10%" >
                    <ItemTemplate>
                        <asp:Literal runat="server" Text='<%# string.Format("{0} {1}", Eval("User_F_Name"), Eval("User_L_Name")) %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="Title_Name" HeaderText="Functional Area" HeaderStyle-Width="15%" />
                <telerik:GridBoundColumn DataField="Approval_Status" HeaderText="Status" HeaderStyle-Width="15%"  />                
                <telerik:GridBoundColumn DataField="Approved_DT" HeaderText="Date" HeaderStyle-Width="15%" />
                <telerik:GridTemplateColumn HeaderStyle-Width="10%" >
                    <ItemTemplate>
                        <pinso:CustomButton runat="server" ID="btnApprove" Text="Approve" CommandArgument='<%# string.Format("{0}|{1}", Eval("Campaign_ID"), Eval("Campaign_Name")) %>' OnCommand="OnApproveCampaign" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
        </ClientSettings>
    </telerik:RadGrid>
    
    <asp:SqlDataSource runat="server" ID="dsAccountExec" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select User_F_Name + ' ' + User_L_Name as Name, Territory_ID + '|' + Email as ID from user_mast where title_id = 1 and status = 1 order by name" />
    <asp:SqlDataSource runat="server" ID="dsCampaignTeam" OnSelecting="OnSelectingCampaigns" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select t.*, c.Campaign_Name from V_Campaign_Team_Approval_Status t inner join Campaign_Info c on c.Campaign_ID = t.Campaign_ID where c.Territory_ID = @territory and Status_ID = 1 and Approval_Status_Indicator = 1 order by campaign_id, t.User_F_Name, t.User_L_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbAccountExec" PropertyName="SelectedValue" Name="territory" DefaultValue="" />
        </SelectParameters>        
    </asp:SqlDataSource>
</asp:Content>

