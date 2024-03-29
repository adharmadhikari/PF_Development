<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Modal.master" AutoEventWireup="true"
    CodeFile="AddEditPlanInfoVAR.aspx.cs" Inherits="custom_millennium_todaysaccounts_all_AddEditPlanInfo" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="~/custom/millennium/todaysaccounts/controls/AddEditPlanInfoScript.ascx" tagname="PlanInfoScript" tagprefix="pinso" %>
<%@ OutputCache VaryByParam="None" Duration="1" NoStore="true"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--[if lte IE 7]>
        <style type="text/css">
            .ccrModalContainer
            {
                padding: 0px !important;
            }
        </style>
    <![endif]-->
    <script type="text/javascript">
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="title" runat="Server">
    <asp:Literal runat="server" ID="titleText" />
    <pinso:PlanInfoScript ID ="PlanInfoScript1" runat="server" />    
</asp:Content><asp:Content ID="Content3" ContentPlaceHolderID="tools" runat="server">  
     </asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="Server">
    <asp:HiddenField ID="PlanNameHdn" runat="server" Value="" Visible="false" />
   
    <div id="AddPlanInfoMain" class=PlanInfoContainer style="margin-top : 15px !important;">
    <asp:FormView runat="server" ID="formViewPlanInfo" CellPadding="0" Width="100%" DataSourceID="dsPlanInfo">
        <ItemTemplate>
            <table width="100%" >
                <tr>
                    <td valign="top">
                        <table align="left" >
                        <%--<tr align="left">
                                <td width="130px">
                                    <label id="Label1"> RAM/FAM/NAE</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TextBox1" MaxLength="200"  runat="server" Width="213px" ReadOnly="true"
                                      Text='<%# Eval("User_Name") %>' />
                              </td>
                            </tr>--%>
                            <tr align="left">
                                <td width="130px">
                                    <label id="OrganizationName"> VA Facility Name *</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="txtOrganizationName" MaxLength="200" runat="server" Width="213px" TabIndex="1"
                                      Text='<%# Eval("Plan_Name") %>' />
                              </td>
                            </tr>
                            <tr align="left">
                                <td width="130px">
                                    <label id="Label3">Assigned VA VISN *</label>
                                </td>                                
                           <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rcb_va" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" SelectedValue='<%# Eval("VA_VISN") %>'
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select Affiliated VA VISN-" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="1" Value="1"/>
                                        <telerik:RadComboBoxItem Text="2" Value="2"/>
                                        <telerik:RadComboBoxItem Text="3" Value="3"/>
                                        <telerik:RadComboBoxItem Text="4" Value="4"/>
                                        <telerik:RadComboBoxItem Text="5" Value="5"/>
                                        <telerik:RadComboBoxItem Text="6" Value="6"/>
                                        <telerik:RadComboBoxItem Text="7" Value="7"/>
                                        <telerik:RadComboBoxItem Text="8" Value="8"/>
                                        <telerik:RadComboBoxItem Text="9" Value="9"/>
                                        <telerik:RadComboBoxItem Text="10" Value="10"/>
                                        <telerik:RadComboBoxItem Text="11" Value="11"/>
                                        <telerik:RadComboBoxItem Text="12" Value="12"/>
                                        <telerik:RadComboBoxItem Text="13" Value="13"/>
                                        <telerik:RadComboBoxItem Text="14" Value="14"/>
                                        <telerik:RadComboBoxItem Text="15" Value="15"/>
                                        <telerik:RadComboBoxItem Text="16" Value="16"/>
                                        <telerik:RadComboBoxItem Text="17" Value="17"/>
                                        <telerik:RadComboBoxItem Text="18" Value="18"/>
                                        <telerik:RadComboBoxItem Text="19" Value="19"/>
                                        <telerik:RadComboBoxItem Text="20" Value="20"/>
                                        <telerik:RadComboBoxItem Text="21" Value="21"/>
                                        <telerik:RadComboBoxItem Text="22" Value="22"/>
                                        <telerik:RadComboBoxItem Text="23" Value="23"/>
                                       
                                      
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                                
                            </tr>
                            <tr align="left">
                                <td width="130px">
                                    <label id="Address1">Address1</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtAddress1"  MaxLength="150"  runat="server" Width="213px" TabIndex="3"
                                     Text='<%# Eval("Address1") %>' />
                              </td>
                            </tr>    
                             <tr align="left">
                                <td width="130px">
                                    <label id="Address2">Address2</label>
                                </td>                                
                            
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtAddress2"  MaxLength="150"  runat="server" Width="213px" TabIndex="4"
                                     Text='<%# Eval("Address2") %>' />
                              </td>
                            </tr> 
                            <tr align="left">
                                <td width="130px">
                                    <label id="City">City *</label>
                                </td>                                
                          
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtCity"  MaxLength="100"  runat="server" Width="213px" TabIndex="5"
                                     Text='<%# Eval("City") %>' />
                              </td>
                            </tr>  
                                         
                            <tr align="left">
                                <td >
                                    <label for="rdlMeetingType" >State *</label><br />                                    
                                </td>
                                <td >
                                   <telerik:RadComboBox ID="rdlState" runat="server" AppendDataBoundItems="true" Width="220px"
                                        DropDownWidth="220px"  
                                        DataSourceID="dsState" TabIndex="6" Skin="pathfinder" EnableEmbeddedSkins="false" DataTextField="StateName"
                                        DataValueField="StateAbbrev" SelectedValue='<%# Eval("State") %>' >
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select State-" Value="" Selected="true" />
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                             <tr align="left">
                                <td width="130px">
                                    <label id="Zip">Zip</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtZip"  MaxLength="5"  runat="server" Width="213px" TabIndex="7"
                                     Text='<%# Eval("Zip") %>' />
                              </td>
                            </tr>  
                            <tr align="left">
                                <td width="130px">
                                    <label id="Zip4">Zip+4</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtZip4"  MaxLength="4"  runat="server" Width="213px" TabIndex="8"
                                     Text='<%# Eval("Zip_4") %>' />
                              </td>
                            </tr>  
                             <tr align="left">
                                <td width="130px">
                                    <label id="Phone">Phone</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtPhone"  runat="server" Width="213px" TabIndex="9"
                                     Text='<%# Eval("Phone") %>' />
                              </td>
                            </tr>  
                         
                                 
                        </table>          
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="2" >
                        <%--<tr align="left">
                                <td width="130px">
                                    <label id="Label1">Website</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtWebsite"  MaxLength="150"  runat="server" Width="213px"
                                     Text='<%# Eval("Website") %>' />
                              </td>
                            </tr>   --%> 
                            <tr align="left">
                                <td width="130px">
                                    <label id="Email">Email</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtEmail"  runat="server" Width="213px" TabIndex="10"
                                     Text='<%# Eval("Email") %>' />
                              </td>
                            </tr>  
                          <%--<tr align="left">
                                <td width="130px"> 
                                    <label for="rdlInOfficeDispensing">In-Office Dispensing</label>
                                </td>
                                <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rdlInOfficeDispensing" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" SelectedValue='<%# (Boolean.Parse(Eval("In_Office_Dispensing").ToString()))?"1" : "0" %>'
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="Yes" Value="1"/>
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr align="left">
                                <td width="130px"> 
                                    <label for="rdlRevlimid">Revlimid</label>
                                </td>
                                <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rdlRevlimid" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" SelectedValue='<%# (Boolean.Parse(Eval("Revlimid").ToString()))?"1" : "0" %>'
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="Yes" Value="1"/>
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> --%>
                            <tr align="left">
                                <td >
                                    <label id="ClassOfTrade">Class Of Trade</label><br />                                    
                                </td>
                                <td >
                                   <telerik:RadComboBox ID="rdlclassoftrade" runat="server" AppendDataBoundItems="true" Width="220px"
                                        DropDownWidth="220px"  
                                        DataSourceID="dsclassoftrade" TabIndex="11" Skin="pathfinder" EnableEmbeddedSkins="false" DataTextField="Class_of_Trade_Name"
                                        DataValueField="Class_of_Trade_ID" SelectedValue='<%# Eval("Class_of_Trade_ID") %>' >
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select Class Of Trade-" Value="0" Selected="true" />
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                           <%--<tr align="left">
                                <td width="130px">
                                    <label id="Customer_Master_ID">Customer Master ID</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="Txt_Customer_Master_ID"  MaxLength="30" ReadOnly="true"  runat="server" Width="213px"
                                     Text='<%# Eval("Customer_Master_ID") %>' />
                              </td>
                            </tr>   
                      <tr align="left">
                                <td width="130px">
                                    <label id="TerritoryAlignment">Territory Alignment </label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtTerritoryAlignment"  MaxLength="30" ReadOnly="true"  runat="server" Width="213px"
                                     Text='<%# Eval("Territory_Name") %>' />
                              </td>
                            </tr> --%>
                            <tr align="left">
                                <td width="130px">
                                    <label id="AffiliatedPractice">Affiliated Practice</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtAffiliatedPractice"  MaxLength="30" ReadOnly="true"  runat="server" Width="213px" TabIndex="12"
                                     Text='<%# Eval("Affiliated_Practice") %>' />
                              </td>
                            </tr>   
                        </table>
                    </td>                  
                </tr>                
            </table> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="&bull;&nbsp;VA Facility Name Required" ControlToValidate="txtOrganizationName" Display="None" />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="&bull;&nbsp;Assigned VA VISN Required" Display="None"  InitialValue="-Select Affiliated VA VISN-" ControlToValidate="rcb_va"></asp:RequiredFieldValidator>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="&bull;&nbsp;City Required" ControlToValidate="TxtCity" Display="None" />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="&bull;&nbsp;State Required" Display="None"  InitialValue="-Select State-" ControlToValidate="rdlState"></asp:RequiredFieldValidator>
             <div style="height:15px">
                <asp:RegularExpressionValidator ID="PhoneValidator" ValidationExpression="\d{3}-\d{3}-\d{4}"  
                   ControlToValidate="TxtPhone" runat="server" ErrorMessage="Invalid Phone Number"></asp:RegularExpressionValidator>
                <asp:ValidationSummary runat="server" ID="validationSummary1" DisplayMode="List" />   
            </div>
            <div class="modalFormButtons">
                 <pinso:CustomButton TabIndex="13" ID="CustomButton1" runat="server" Text="Update" Visible="true" OnClick="Editbtn_Click" />
                 <pinso:CustomButton ID="CustomButton2" TabIndex="14" runat="server" Text="Reset" OnClientClick="javascript:ClearForm(); return false;" />                     
            </div>
        </ItemTemplate>
        <InsertItemTemplate>
          <table width="100%" >
                <tr>
                    <td valign="top">
                        <table align="left" >
                            <tr align="left">
                                <td width="130px">
                                    <label id="OrganizationName"> VA Facility Name *</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="txtOrganizationName" MaxLength="200"  runat="server" Width="213px" TabIndex="1"
                                      Text='<%# Eval("Plan_Name") %>' />
                              </td>
                            </tr>
                             <tr align="left">
                                <td width="130px">
                                    <label id="Label3">Assigned VA VISN *</label>
                                </td>                                
                           <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rcb_va" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" SelectedValue='<%# Eval("VA_VISN") %>'
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select Affiliated VA VISN-" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="1" Value="1"/>
                                        <telerik:RadComboBoxItem Text="2" Value="2"/>
                                        <telerik:RadComboBoxItem Text="3" Value="3"/>
                                        <telerik:RadComboBoxItem Text="4" Value="4"/>
                                        <telerik:RadComboBoxItem Text="5" Value="5"/>
                                        <telerik:RadComboBoxItem Text="6" Value="6"/>
                                        <telerik:RadComboBoxItem Text="7" Value="7"/>
                                        <telerik:RadComboBoxItem Text="8" Value="8"/>
                                        <telerik:RadComboBoxItem Text="9" Value="9"/>
                                        <telerik:RadComboBoxItem Text="10" Value="10"/>
                                        <telerik:RadComboBoxItem Text="11" Value="11"/>
                                        <telerik:RadComboBoxItem Text="12" Value="12"/>
                                        <telerik:RadComboBoxItem Text="13" Value="13"/>
                                        <telerik:RadComboBoxItem Text="14" Value="14"/>
                                        <telerik:RadComboBoxItem Text="15" Value="15"/>
                                        <telerik:RadComboBoxItem Text="16" Value="16"/>
                                        <telerik:RadComboBoxItem Text="17" Value="17"/>
                                        <telerik:RadComboBoxItem Text="18" Value="18"/>
                                        <telerik:RadComboBoxItem Text="19" Value="19"/>
                                        <telerik:RadComboBoxItem Text="20" Value="20"/>
                                        <telerik:RadComboBoxItem Text="21" Value="21"/>
                                        <telerik:RadComboBoxItem Text="22" Value="22"/>
                                        <telerik:RadComboBoxItem Text="23" Value="23"/>
                                       
                                      
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr align="left">
                                <td width="130px">
                                    <label id="Address1">Address1</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtAddress1"  MaxLength="150"  runat="server" Width="213px" TabIndex="3"
                                     Text='<%# Eval("Address1") %>' />
                              </td>
                            </tr>    
                             <tr align="left">
                                <td width="130px">
                                    <label id="Address2">Address2</label>
                                </td>                                
                            
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtAddress2"  MaxLength="150"  runat="server" Width="213px" TabIndex="4"
                                     Text='<%# Eval("Address2") %>' />
                              </td>
                            </tr> 
                            <tr align="left">
                                <td width="130px">
                                    <label id="City">City *</label>
                                </td>                                
                          
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtCity"  MaxLength="100"  runat="server" Width="213px" TabIndex="5"
                                     Text='<%# Eval("City") %>' />
                              </td>
                            </tr>  
                                         
                            <tr align="left">
                                <td >
                                    <label for="rdlMeetingType" >State *</label><br />                                    
                                </td>
                                <td >
                                   <telerik:RadComboBox ID="rdlState" runat="server" AppendDataBoundItems="true" Width="220px"
                                        DropDownWidth="220px"  
                                        DataSourceID="dsState" TabIndex="6" Skin="pathfinder" EnableEmbeddedSkins="false" DataTextField="StateName"
                                        DataValueField="StateAbbrev" SelectedValue='<%# Eval("State") %>' >
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select State-" Value="" Selected="true" />
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                             <tr align="left">
                                <td width="130px">
                                    <label id="Zip">Zip</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtZip"  MaxLength="5"  runat="server" Width="213px" TabIndex="7"
                                     Text='<%# Eval("Zip") %>' />
                              </td>
                            </tr>  
                            <tr align="left">
                                <td width="130px">
                                    <label id="Zip4">Zip+4</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtZip4"  MaxLength="4"  runat="server" Width="213px" TabIndex="8"
                                     Text='<%# Eval("Zip_4") %>' />
                              </td>
                            </tr> 
                            <tr align="left">
                                <td width="130px">
                                    <label id="Phone">Phone</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtPhone"  runat="server" Width="213px" TabIndex="9"
                                     Text='<%# Eval("Phone") %>' />
                              </td>
                            </tr>  
                            
                        </table>          
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="2" >
                        <%--<tr align="left">
                                <td width="130px">
                                    <label id="Label1">Website</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtWebsite"  MaxLength="150"  runat="server" Width="213px"
                                     Text='<%# Eval("Website") %>' />
                              </td>
                            </tr>    --%>
                            
                            <tr align="left">
                                <td width="130px">
                                    <label id="Email">Email</label>
                                </td>                                
                           
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 2px;">                                   
                                     <asp:TextBox id="TxtEmail"  runat="server" Width="213px" TabIndex="10"
                                     Text='<%# Eval("Email") %>' />
                              </td>
                            </tr>    
                         <%-- <tr align="left">
                                <td width="130px"> 
                                    <label for="rdlInOfficeDispensing">In-Office Dispensing</label>
                                </td>
                                <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rdlInOfficeDispensing" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" 
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="Yes" Value="1"/>
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr align="left">
                                <td width="130px"> 
                                    <label for="rdlRevlimid">Revlimid</label>
                                </td>
                                <td>
                                
                                    <telerik:RadComboBox TabIndex="2" ID="rdlRevlimid" runat="server" AppendDataBoundItems="true"
                                         Skin="pathfinder" Width="220px" 
                                        DropDownWidth="220px"  EnableEmbeddedSkins="false">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="No" Value="0" Selected="true"/>
                                        <telerik:RadComboBoxItem Text="Yes" Value="1"/>
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> --%>
                            <tr align="left">
                                <td >
                                    <label id="ClassOfTrade">Class Of Trade</label><br />                                    
                                </td>
                                <td >
                                   <telerik:RadComboBox ID="rdlclassoftrade" runat="server" AppendDataBoundItems="true" Width="220px"
                                        DropDownWidth="220px"  
                                        DataSourceID="dsclassoftrade" TabIndex="11" Skin="pathfinder" EnableEmbeddedSkins="false" DataTextField="Class_of_Trade_Name"
                                        DataValueField="Class_of_Trade_ID" SelectedValue='<%# Eval("Class_of_Trade_ID") %>' >
                                    <Items>
                                        <telerik:RadComboBoxItem Text="-Select Class Of Trade-" Value="0" Selected="true" />
                                    </Items>   
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                           
                        </table>
                    </td>                  
                </tr>                
            </table> 
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="&bull;&nbsp;VA Facility Name Required" ControlToValidate="txtOrganizationName" Display="None" />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="&bull;&nbsp;Assigned VA VISN Required" Display="None"  InitialValue="-Select Affiliated VA VISN-" ControlToValidate="rcb_va"></asp:RequiredFieldValidator>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="&bull;&nbsp;City Required" ControlToValidate="TxtCity" Display="None" />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="&bull;&nbsp;State Required" Display="None"  InitialValue="-Select State-" ControlToValidate="rdlState"></asp:RequiredFieldValidator>           
             <div style="height:15px">
                <asp:RegularExpressionValidator ID="PhoneValidator" ValidationExpression="\d{3}-\d{3}-\d{4}"  
                   ControlToValidate="TxtPhone" runat="server" ErrorMessage="Invalid Phone Number"></asp:RegularExpressionValidator>
                <asp:ValidationSummary runat="server" ID="validationSummary1" DisplayMode="List" />   
            </div>
            <div class="modalFormButtons">                
                <pinso:CustomButton TabIndex="12" ID="btnEdit" runat="server" Text="Add" Visible="true" OnClick="Editbtn_Click" />
                <pinso:CustomButton ID="btnReset" TabIndex="13" runat="server" Text="Reset" OnClientClick="javascript:ClearForm(); return false;" />                       
            </div>
        </InsertItemTemplate>
    </asp:FormView>
    </div>
    <asp:EntityDataSource runat="server" ID="dsState" ConnectionString="name=PathfinderMillenniumEntities"
        DefaultContainerName="PathfinderMillenniumEntities" EntitySetName="LkpStateSet"
        EntityTypeFilter="LkpState" OrderBy="it.StateName" >
    </asp:EntityDataSource>
   
   <asp:EntityDataSource runat="server" ID="dsclassoftrade" ConnectionString="name=PathfinderMillenniumEntities"
        DefaultContainerName="PathfinderMillenniumEntities" 
        EntitySetName="LkpCustomClassofTradeSet" Where="it.Section_ID=107" OrderBy="it.Class_of_Trade_Name ">
    </asp:EntityDataSource>
    <asp:EntityDataSource runat="server" ID="dsPlanInfo" ConnectionString="name=PathfinderMillenniumEntities"
        DefaultContainerName="PathfinderMillenniumEntities" 
        EntitySetName="PlansClientViewSet" AutoGenerateWhereClause="true">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
            
        </WhereParameters>
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
        </InsertParameters>
        <UpdateParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
           
        </UpdateParameters>
    </asp:EntityDataSource>
    
    
    <div>
        <asp:Label ID="Msglbl" runat="server" Text="" Visible="false"></asp:Label>
        <asp:Label ID="Label2" runat="server" Text='<%= Request.Form["PlanID"]%>' Visible="false"></asp:Label>
    </div>
</asp:Content>
