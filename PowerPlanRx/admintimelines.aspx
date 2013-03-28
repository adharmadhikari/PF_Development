<%@ Page Title="PowerPlanRx - Manage Timelines" Language="C#" MasterPageFile="~/admin.master" Theme="impact" AutoEventWireup="true" CodeFile="admintimelines.aspx.cs" Inherits="admintimelines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="content" Runat="Server">
    
    <script type="text/javascript">

    $(document).ready(function()
    {
        $("#a2").addClass("selected");
    }); 
    
        function onDurationChanged(sender, args)
        {
            
            var p;
            
            if (sender.get_element)
                sender = sender.get_element();
                
            p = sender.parentNode;             
            
            while (p && p.tagName != "TR")
            {
                p = p.parentNode;
            }

            if (p)
            {
                var startDate = $(p).find(".startDate input");
                if (startDate.length > 0)
                    startDate = startDate.val();
                else
                    startDate = $(p).find(".startDate").text();                    
                    
                var endDate = $(p).find(".endDate");
                var duration = $(p).find(".duration input")
                
                var dt = new Date(startDate);

                if (!isNaN(dt))
                {
                    dt.setMonth(dt.getMonth() + parseInt(duration.val()));
                    endDate.text(dt.format("M/d/yyyy"));
                }
            }

            validatePage();
        }

        function validatePage()
        {
            var valid = true;

            $(".invalid").removeClass("invalid");

            $(".startDate input").each(function()
            {
                var dt = new Date(this.value);
                if (isNaN(dt) || ( this.value != this.defaultValue && dt < new Date()) )
                {
                    valid = false;
                    $(this).addClass("invalid");
                }
            });

            return valid;
        }    
    </script>
    
    <div style="float:left">
        <telerik:RadComboBox runat="server" ID="rcbAccountExec" EnableEmbeddedSkins="false" SkinID="impactGen" DataSourceID="dsAccountExec" DataTextField="Name" DataValueField="ID" AutoPostBack="true" />
    </div>    
    <div style="float:right;padding:3px">
        <pinso:CustomButton runat="server" ID="btnEditPlans" OnClick="OnEditTimelines" Text="Edit" />
        <pinso:CustomButton runat="server" ID="btnSavePlans" OnClick="OnSaveTimelines" Text="Save" Visible="false" OnClientClick="return validatePage()" />
        <pinso:CustomButton runat="server" ID="btnCancel" OnClick="OnCancelEdit" Text="Cancel" Visible="false" CausesValidation="false" />
    </div>
    <div class="clearAll"></div>
    <telerik:RadGrid runat="server" ID="radGrid" AutoGenerateColumns="false" DataSourceID="dsTimelines" Height="90%" EnableEmbeddedSkins="false" SkinID="table1">
        <MasterTableView DataKeyNames="Campaign_ID, Campaign_Name" AllowSorting="true">
            <Columns>
                <telerik:GridBoundColumn DataField="Campaign_ID" HeaderStyle-Width="5%" />
                <telerik:GridBoundColumn DataField="Campaign_Name" HeaderText="Campaign" HeaderStyle-Width="45%" />
                <telerik:GridTemplateColumn HeaderText="Approved" SortExpression="Status_ID" HeaderStyle-Width="15%">
                    <ItemTemplate>
                        <asp:Literal runat="server" Text='<%# (int)Eval("Status_ID") == 2 ? "Yes" : ""%>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Start Date" SortExpression="Start_Date" ItemStyle-CssClass="alignRight" HeaderStyle-Width="15%">
                    <ItemTemplate>
                        <span class="startDate">
                            <asp:Literal runat="server" Text='<%# Eval("Start_Date", "{0:d}") %>' Visible='<%# !EditMode || (int)Eval("Status_ID") > 1 %>' />
                            <asp:TextBox runat="server" ID="txtStartDate" Width="70px" SkinID="textBoxRight" onchange="onDurationChanged(this)" Text='<%# Eval("Start_Date", "{0:d}") %>' Visible='<%# EditMode && (int)Eval("Status_ID") == 1 %>' />
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Duration" SortExpression="Campaign_Duration" ItemStyle-CssClass="alignRight" HeaderStyle-Width="10%">
                    <ItemTemplate>
                        <span class="duration">
                            <asp:Literal runat="server" Text='<%# Eval("Campaign_Duration") %>' Visible='<%# !EditMode %>' />                        
                            <telerik:RadComboBox runat="server" ID="dlDuration" EnableEmbeddedSkins="false" SkinID="impactGenNOSIZE" Width="50px"
                                SelectedValue='<%# Bind("Campaign_Duration") %>' OnClientSelectedIndexChanged="onDurationChanged"
                                Visible='<%# EditMode %>' 
                                >
                                <Items>
                                    <telerik:RadComboBoxItem Text="3" Value="3" />
                                    <telerik:RadComboBoxItem Text="4" Value="4" />
                                    <telerik:RadComboBoxItem Text="5" Value="5" />
                                    <telerik:RadComboBoxItem Text="6" Value="6" Selected="True" />
                                    <telerik:RadComboBoxItem Text="7" Value="7" />
                                    <telerik:RadComboBoxItem Text="8" Value="8" />
                                    <telerik:RadComboBoxItem Text="9" Value="9" />
                                    <telerik:RadComboBoxItem Text="10" Value="10" />
                                    <telerik:RadComboBoxItem Text="11" Value="11" />
                                    <telerik:RadComboBoxItem Text="12" Value="12" />
                                </Items>
                            </telerik:RadComboBox>                        
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="End Date" SortExpression="End_Date" ItemStyle-CssClass="alignRight" HeaderStyle-Width="10%">
                    <ItemTemplate>
                        <span class="endDate">
                            <%# Eval("End_Date", "{0:d}") %>
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
        </ClientSettings>
    </telerik:RadGrid>


    <asp:SqlDataSource runat="server" ID="dsAccountExec" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select User_F_Name + ' ' + User_L_Name as Name, Territory_ID + '|' + Email as ID from user_mast where title_id = 1 and status = 1 order by name" />
    <asp:SqlDataSource runat="server" ID="dsTimelines" OnSelecting="OnSelectingTimelines" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select campaign_id, campaign_name, start_date, campaign_duration, end_date, status_id from campaign_info where territory_id = @territory and status_id in (1,2)">
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbAccountExec" PropertyName="SelectedValue" Name="territory" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>


