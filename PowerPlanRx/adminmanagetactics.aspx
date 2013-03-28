<%@ Page Title="PowerPlanRx - Manage Tactics" Language="C#" MasterPageFile="~/admin.master" Theme="impact" AutoEventWireup="true" CodeFile="adminmanagetactics.aspx.cs" Inherits="adminmanagetactics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="content" Runat="Server">
    
    <script type="text/javascript">

    $(document).ready(function()
    {
        $("#a4").addClass("selected");
    }); 
    
        function validatePage(validationGroup)
        {
            var valid = true;

            $(".invalid").removeClass("invalid");

            $("." + validationGroup + " input").each(
            function()
            {
                if (!$.trim(this.value))
                {
                    valid = false;
                    $(this).addClass("invalid");
                }
            }
            );

            return valid;
        }
    </script>
    
    <telerik:RadComboBox runat="server" ID="rcbBrand" DataSourceID="dsBrand" EnableEmbeddedSkins="false" SkinID="impactGen" AppendDataBoundItems="true" DataTextField="Name" DataValueField="ID" AutoPostBack="true">
        <Items>
            <telerik:RadComboBoxItem Text="--Generic Tactics--" Value="0" />
        </Items>
    </telerik:RadComboBox>

    <asp:FormView runat="server" ID="formView" DataSourceID="dsTactics" DefaultMode="Insert">
        <InsertItemTemplate>
            <div style="vertical-align:top;padding:10px">
                Tactic Name: 
                <span class="newTacticName">
                    <asp:TextBox runat="server" ID="txtName" Text='<%# Bind("Tactics_Name") %>' />
                </span>
                Tactic Description: <asp:TextBox runat="server" ID="txtDescription" Text='<%# Bind("Tactics_Description") %>' Width="400px"/>            
                <pinso:CustomButton runat="server" ID="btnAdd" Text="Add" CommandName="insert" OnClientClick="return validatePage('newTacticName')" />            
            </div>
        </InsertItemTemplate>
    </asp:FormView>
    
    <div style="float:right;padding:5px">    
        <pinso:CustomButton runat="server" ID="btnEdit" Text="Edit" OnClick="OnEdit" />
        <pinso:CustomButton runat="server" ID="btnSave" Text="Save" OnClick ="OnSave" OnClientClick="return validatePage('tacticName')" />
        <pinso:CustomButton runat="server" ID="btnCancel" Text="Cancel" OnClick="OnCancel" />
    </div>
    
    <telerik:RadGrid runat="server" ID="radGrid" AutoGenerateColumns="false" DataSourceID="dsTactics" EnableEmbeddedSkins="false" SkinID="table1">
        <MasterTableView DataKeyNames="Tactics_ID, Tactic_Update_ID, UpdatePending" AllowSorting="true">
            <Columns>
                <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Tactics_Name" HeaderStyle-Width="25%">
                    <ItemTemplate>
                        <span class="tacticName">
                            <asp:Literal runat="server" Text='<%# Eval("Tactics_Name") %>' Visible='<%# !EditMode %>' />
                            <asp:TextBox ID="txtName" runat="server" Width="90%" Text='<%# Eval("Tactics_Name") %>' Visible='<%# EditMode %>' />
                        </span>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Tactics_Description" HeaderStyle-Width="65%">
                    <ItemTemplate>
                        <asp:Literal runat="server" Text='<%# Eval("Tactics_Description") %>' Visible='<%# !EditMode %>' />
                        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Tactics_Description") %>' Visible='<%# EditMode %>' Width="95%" />                    
                    </ItemTemplate>                
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="10%" SortExpression="UpdatePending" HeaderText="Update Pending">
                    <ItemTemplate>
                        <asp:Literal ID="Literal1" runat="server" Text='<%# (bool)Eval("UpdatePending") ? "Yes" : "" %>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>                            
            </Columns>
        </MasterTableView>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" />
    </telerik:RadGrid>

    
    <asp:SqlDataSource runat="server" ID="dsBrand" ConnectionString='<%$ ConnectionStrings:impact %>' SelectCommand="select distinct brand_id as id, brand_name as name from lkp_products where is_campaign_brand = 1 order by name" />
    
    <asp:SqlDataSource runat="server" ID="dsTactics" ConnectionString='<%$ ConnectionStrings:impact %>' 
                        SelectCommand="select * from V_Admin_Tactics where IsNull(brand_id,0) = IsNull(@Brand,0) order by Tactics_Name"
                        InsertCommand="usp_Admin_UpdateTactic" InsertCommandType="StoredProcedure"
                        >
        <SelectParameters>
            <asp:ControlParameter ControlID="rcbBrand" PropertyName="SelectedValue" DefaultValue="0" Type="Int32" Name="Brand" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="rcbBrand" PropertyName="SelectedValue" DefaultValue="0" Type="Int32" Name="Brand_ID" />
            <asp:SessionParameter SessionField="FullName" DefaultValue="" Name="UserName" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
