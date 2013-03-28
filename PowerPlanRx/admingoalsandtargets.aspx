<%@ Page Title="PowerPlanRx - Manage Goals" Theme="impact" Language="C#" MasterPageFile="~/admin.master" AutoEventWireup="true" CodeFile="admingoalsandtargets.aspx.cs" Inherits="admingoalsandtargets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="content" Runat="Server">
    <script type="text/javascript">

    $(document).ready(function()
    {
        $("#a1").addClass("selected");
    }); 
    
        function preSelectPlan(sender, args)
        {
            args.set_cancel(<%= EditMode.ToString().ToLower() %>);
        }
        
        function selectPlan(sender, args)
        {
            var h = $get('ctl00_ctl00_main_main_content_hSelectedPlanID');
            h.value = args.getDataKeyValue("Plan_ID");
            
            __doPostBack();
        }


        function onTrxChanged(o, mb)
        {
            var p = o.parentNode;
            while (p && p.tagName != "TR")
            {
                p = p.parentNode;
            }

            if (p)
            {
                var j1 = $(p).find(".trx input");
                var j2 = $(p).find(".mst input");
                var val = (j1.val() / mb) * 100;
                if(!isNaN(val))
                    j2.val(parseFloat(val).format("n2"));

                validateGoals();
            }
        }
        function onMstChanged(o, mb)
        {
            var p = o.parentNode;
            while (p && p.tagName != "TR")
            {
                p = p.parentNode;
            }

            if (p)
            {
                var j1 = $(p).find(".mst input");
                var j2 = $(p).find(".trx input");
                var val = (j1.val() / 100) * mb;
                if(!isNaN(val))
                    j2.val(Math.round(val));

                validateGoals();
            }
        }

        function validateGoals()
        {
            var valid = true;

            $(".invalid").removeClass("invalid");

            $(".trx input").each(function()
            {
                var t = $(this);
                if (isNaN(t.val()))
                {
                    t.addClass("invalid");
                    valid = false;                
                }
            });
                        
            $(".mst input").each(function()
            {
                var t = $(this);
                if (isNaN(t.val()) || t.val() < 0 || t.val() > 100)
                {
                    t.addClass("invalid");
                    valid = false;
                }
            });

            return valid;
        }
        
    </script>

    <telerik:RadComboBox runat="server" ID="rcbAccountExec" EnableEmbeddedSkins="false" SkinID="impactGen" DataSourceID="dsAccountExec" DataTextField="Name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged" />
    <telerik:RadComboBox runat="server" ID="rcbBrand" EnableEmbeddedSkins="false" SkinID="impactGen" DataSourceID="dsBrand" DataTextField="Name" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged" />
    <telerik:RadComboBox runat="server" ID="rcbMonth" EnableEmbeddedSkins="false" SkinID="impactGen" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged" >
        <Items>
            <telerik:RadComboBoxItem Text="January" Value="1" />
            <telerik:RadComboBoxItem Text="February" Value="2" />
            <telerik:RadComboBoxItem Text="March" Value="3" />
            <telerik:RadComboBoxItem Text="April" Value="4" />
            <telerik:RadComboBoxItem Text="May" Value="5" />
            <telerik:RadComboBoxItem Text="June" Value="6" />
            <telerik:RadComboBoxItem Text="July" Value="7" />
            <telerik:RadComboBoxItem Text="August" Value="8" />
            <telerik:RadComboBoxItem Text="September" Value="9" />
            <telerik:RadComboBoxItem Text="October" Value="10" />
            <telerik:RadComboBoxItem Text="November" Value="11" />
            <telerik:RadComboBoxItem Text="December" Value="12" />
        </Items>
    </telerik:RadComboBox>
    <telerik:RadComboBox runat="server" ID="rcbYear" EnableEmbeddedSkins="false" SkinID="impactGen" DataSourceID="dsYear" DataValueField="Data_Year" DataTextField="Data_Year" AutoPostBack="true" OnSelectedIndexChanged="OnSelectedIndexChanged" />
    <asp:HiddenField runat="server" ID="hSelectedPlanID" OnValueChanged="OnSelectedPlanChanged" />
    <telerik:RadSplitter runat="server" ID="radSplit" EnableEmbeddedBaseStylesheet="false" >
        <telerik:RadPane runat="server" ID="radPanePlans" Scrolling="None">
            <div>
                <pinso:CustomButton runat="server" ID="btnEditPlans" OnClick="OnEditPlans" Text="Edit" />
                <pinso:CustomButton runat="server" ID="btnSavePlans" OnClick="OnSavePlans" Text="Save" Visible="false" OnClientClick="return validateGoals()" />
                <pinso:CustomButton runat="server" ID="btnCancel1" OnClick="OnCancel" Text="Cancel" />            
            </div>        
            <telerik:RadGrid runat="server" ID="gridPlans" Height="90%" DataSourceID="dsPlans" EnableEmbeddedSkins="false" SkinID="table1" AutoGenerateColumns="false"  ClientSettings-ClientEvents-OnRowSelected="selectPlan" ClientSettings-ClientEvents-OnRowSelecting="preSelectPlan">
                <MasterTableView DataKeyNames="Plan_ID, Brand_ID, Data_Year, Data_Month, MB_Trx" ClientDataKeyNames="Plan_ID" AllowSorting="true">
                    <Columns>
                        <telerik:GridBoundColumn DataField="Plan_Name" HeaderText="Plan" />
                        <telerik:GridTemplateColumn HeaderText="Brand Trx" SortExpression="Brand_Trx" ItemStyle-CssClass="alignRight">
                            <ItemTemplate>
                                <span class="trx">
                                    <asp:Literal runat="server" Text='<%# Eval("Brand_Trx") %>' Visible='<%# !this.EditMode %>' />                                
                                    <asp:TextBox ID="txtBrandTrx" runat="server" Width="40px" SkinID="textBoxRight" Text='<%# Eval("Brand_Trx") %>' Enabled='<%# (int)Eval("MB_Trx") > 0 %>' Visible='<%# this.EditMode %>' onchange='<%# Eval("MB_Trx","onTrxChanged(this, {0})") %>' />
                                </span>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="MB_Trx" HeaderText="MB Trx"  ItemStyle-CssClass="alignRight"/>                        
                        <telerik:GridTemplateColumn HeaderText="Goal" SortExpression="Brand_Mst" ItemStyle-CssClass="alignRight">
                            <ItemTemplate>
                                <span class="mst">
                                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("Brand_Mst") %>' Visible='<%# !this.EditMode %>' />                                
                                    <asp:TextBox ID="txtBrandMst" runat="server" Width="40px" SkinID="textBoxRight" Text='<%# Eval("Brand_Mst") %>' Enabled='<%# (int)Eval("MB_Trx") > 0 %>' Visible='<%# this.EditMode %>' onchange='<%# Eval("MB_Trx","onMstChanged(this, {0})") %>' />
                                </span>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                        
                    </Columns>
                </MasterTableView>
                <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-ScrollHeight="350px" Scrolling-UseStaticHeaders="true" />
            </telerik:RadGrid>
        </telerik:RadPane>        
        <telerik:RadPane runat="server" Scrolling="None">       
            <asp:Panel runat="server" ID="panelDistrictButtons">
                <pinso:CustomButton runat="server" ID="btnEditDistricts" OnClick="OnEditDistricts" Text="Edit" />
                <pinso:CustomButton runat="server" ID="btnSaveDistricts" OnClick="OnSaveDistricts" Text="Save" Visible="false" OnClientClick="return validateGoals()"  />    
                <pinso:CustomButton runat="server" ID="btnCancel2" OnClick="OnCancel" Text="Cancel" />
            </asp:Panel>
            <telerik:RadGrid runat="server" ID="gridDistricts" DataSourceID="dsDistricts" Height="90%" AutoGenerateColumns="false" EnableEmbeddedSkins="false" SkinID="table1">
                <MasterTableView DataKeyNames="Plan_ID, District_ID, Brand_ID, Data_Year, Data_Month, MB_Trx" AllowSorting="true">
                    <Columns>
                        <telerik:GridBoundColumn DataField="District_ID" HeaderText="District" />
                        <telerik:GridTemplateColumn HeaderText="Brand Trx" SortExpression="Brand_Trx" ItemStyle-CssClass="alignRight">
                            <ItemTemplate>
                                <span class="trx">
                                    <asp:Literal ID="Literal2" runat="server" Text='<%# Eval("Brand_Trx") %>' Visible='<%# !this.EditModeDistricts %>' />
                                    <asp:TextBox ID="txtBrandTrx" runat="server" Width="40px" SkinID="textBoxRight" Text='<%# Eval("Brand_Trx") %>' Enabled='<%# (int)Eval("MB_Trx") > 0 %>' Visible='<%# this.EditModeDistricts %>'  onchange='<%# Eval("MB_Trx","onTrxChanged(this, {0})") %>' />
                                </span>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="MB_Trx" HeaderText="MB Trx"  ItemStyle-CssClass="alignRight" />                        
                        <telerik:GridTemplateColumn HeaderText="Goal" SortExpression="Brand_Mst" ItemStyle-CssClass="alignRight">
                            <ItemTemplate>
                                <span class="mst">
                                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("Brand_Mst") %>' Visible='<%# !this.EditModeDistricts %>' />                                
                                    <asp:TextBox ID="txtBrandMst" runat="server" SkinID="textBoxRight" Width="40px" Text='<%# Eval("Brand_Mst") %>' Enabled='<%# (int)Eval("MB_Trx") > 0 %>' Visible='<%# this.EditModeDistricts %>' onchange='<%# Eval("MB_Trx","onMstChanged(this, {0})") %>' />
                                </span>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>                        
                    </Columns>
                </MasterTableView>    
                <ClientSettings Scrolling-AllowScroll="true" Scrolling-ScrollHeight="350px" />
            </telerik:RadGrid>
        </telerik:RadPane>        
    </telerik:RadSplitter>
    
    <asp:SqlDataSource runat="server" ID="dsAccountExec" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select User_F_Name + ' ' + User_L_Name as Name, Territory_ID as ID from user_mast where title_id = 1 order by name" />
    <asp:SqlDataSource runat="server" ID="dsBrand" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select distinct brand_id as id, brand_name as name from lkp_products where is_campaign_brand = 1 order by name" />
    <asp:SqlDataSource runat="server" ID="dsYear" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select distinct data_year from plan_goals order by data_year desc" />
    <asp:SqlDataSource runat="server" ID="dsPlans" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select * from V_Admin_PlanGoals where data_year=@year and data_month=@month and territory_id = @territory and brand_id = @brand">
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbAccountExec" PropertyName="SelectedValue" Name="territory" DefaultValue="" />
            <asp:ControlParameter ControlID="rcbBrand" PropertyName="SelectedValue" Name="brand" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="rcbYear" PropertyName="SelectedValue" Name="year" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="rcbMonth" PropertyName="SelectedValue" Name="month" DefaultValue="0" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="dsDistricts" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select * from V_Admin_PlanDistrictGoals where data_year=@year and data_month=@month and territory_id = @territory and brand_id = @brand and plan_id = @plan">
        <SelectParameters>
            <asp:ControlParameter ControlID="hSelectedPlanID" PropertyName="Value" Name="plan" DefaultValue="" />
            <asp:ControlParameter ControlID="rcbAccountExec" PropertyName="SelectedValue" Name="territory" DefaultValue="" />
            <asp:ControlParameter ControlID="rcbBrand" PropertyName="SelectedValue" Name="brand" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="rcbYear" PropertyName="SelectedValue" Name="year" DefaultValue="0" Type="Int32" />
            <asp:ControlParameter ControlID="rcbMonth" PropertyName="SelectedValue" Name="month" DefaultValue="0" Type="Int32" />
        </SelectParameters>    
    </asp:SqlDataSource>
</asp:Content>


