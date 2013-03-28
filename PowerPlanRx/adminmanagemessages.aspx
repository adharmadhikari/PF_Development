<%@ Page Title="PowerPlanRx - Manage Messages" Language="C#" MasterPageFile="~/admin.master" Theme="impact" AutoEventWireup="true" CodeFile="adminmanagemessages.aspx.cs" Inherits="adminmanagemessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="content" Runat="Server">
    <script type="text/javascript">

    $(document).ready(function()
    {
        $("#a5").addClass("selected");
    }); 
    
        function validatePage(validationGroup)
        {
            var valid = true;

            $(".invalid").removeClass("invalid");

            $("." + validationGroup + " textarea").each(
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
            <telerik:RadComboBoxItem Text="--Generic Messages--" Value="0" />
        </Items>
    </telerik:RadComboBox>

    <asp:FormView runat="server" ID="formView" DataSourceID="dsMessages" DefaultMode="Insert">
        <InsertItemTemplate>
            <div style="vertical-align:top;padding:10px">
                Message: 
                <span class="newMessageName">
                    <asp:TextBox runat="server" ID="txtName" Text='<%# Bind("Message_Name") %>' Rows="4" Columns="150" TextMode="MultiLine" />
                </span>
                <pinso:CustomButton runat="server" ID="btnAdd" Text="Add" CommandName="insert" OnClientClick="return validatePage('newMessageName')" />
            </div>
        </InsertItemTemplate>
    </asp:FormView>

    <div style="float:right;padding:5px">
        <pinso:CustomButton runat="server" ID="btnEdit" Text="Edit" OnClick="OnEdit" />
        <pinso:CustomButton runat="server" ID="btnSave" Text="Save" OnClick ="OnSave" OnClientClick="return validatePage('messageName')" />
        <pinso:CustomButton runat="server" ID="btnCancel" Text="Cancel" OnClick="OnCancel" />    
    </div>
        
    <telerik:RadGrid runat="server" ID="radGrid" AutoGenerateColumns="false" DataSourceID="dsMessages" EnableEmbeddedSkins="false" SkinID="table1">
        <MasterTableView DataKeyNames="Message_ID, Message_Update_ID, UpdatePending" AllowSorting="true">
            <Columns>      
                <telerik:GridTemplateColumn HeaderText="Message" SortExpression="Message_Name">
                    <ItemTemplate>
                        <span class="messageName">
                            <asp:Literal runat="server" Text='<%# Eval("Message_Name") %>' Visible='<%# !EditMode %>' />
                            <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Message_Name") %>' Visible='<%# EditMode %>' TextMode="MultiLine" Rows="4" Columns="125" />
                        </span>
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
    
    <asp:SqlDataSource runat="server" ID="dsMessages" ConnectionString='<%$ ConnectionStrings:impact %>' 
                        SelectCommand="select * from V_Admin_Messages where IsNull(brand_id,0) = IsNull(@Brand,0) order by Message_Name"
                        InsertCommand="usp_Admin_UpdateMessage" InsertCommandType="StoredProcedure"
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


