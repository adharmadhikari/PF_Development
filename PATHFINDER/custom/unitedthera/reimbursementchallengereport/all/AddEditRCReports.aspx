<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Modal.master" AutoEventWireup="true"
    CodeFile="AddEditRCReports.aspx.cs" Inherits="custom_pinso_customercontactreports_all_AddEditCCReports" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="~/custom/unitedthera/reimbursementchallengereport/controls/AddEditRCRScript.ascx" tagname="CCRScript" tagprefix="pinso" %>
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
        function RefreshGrid() 
        {
            return window.top.$find("ctl00_ctl00_Tile3_Tile6_CCRGridList1_gridCCReports");
        }

        function RefreshCCRs() 
        {
            RefreshGrid().get_masterTableView().rebind();
            window.setTimeout(CloseWin, 2000);
        }
        
        function ConfirmMsg() 
        {
            window.setTimeout(CloseWin, 2000);
        }
        
        function CloseWin() 
        {
            var manager = window.top.GetRadWindowManager();           

            var window1 = manager.getWindowByName("AddIR");
            if (window1 != null)
                window1.close();

            var window2 = manager.getWindowByName("EditIR");
            if (window2 != null)
                window2.close();
        }

        function onPrintClicked() {
            var querystring = window.location.search;
            var CRID = '<%= Request.QueryString["CRID"] %>';
            var data = { Contact_Report_ID: CRID };
            window.top.clientManager.set_SelectionData(data, 1);
            var type = 'print';
                       
            window.top.clientManager.exportView(type, true, 'reimbursementchallengereport');

        }

        function notifyAdminChanged(checkbox) {
            if (checkbox.checked) {
                $("#ctl00_main_hdnNotifyAdmin").val("true");
            } else {
                $("#ctl00_main_hdnNotifyAdmin").val("false");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="title" runat="Server">
    <asp:Literal runat="server" ID="titleText" />
    <pinso:CCRScript ID ="CCRScript1" runat="server" />    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="tools" runat="server">  
    <%-- <a href="javascript:onPrintClicked()" style='margin-right:15px'><asp:Label ID="Print" runat="server" Text="Print" ></asp:Label></a>  --%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="main" runat="Server">
    <asp:HiddenField ID="PlanNameHdn" runat="server" Value="" Visible="false" />
    <asp:HiddenField Id="hdnPrdsDisccused" runat="server" Value="" Visible="true" />   
    <asp:HiddenField ID ="hdnIssues" runat="server" Value="" Visible="true" />  
    <asp:HiddenField ID ="hdnContacts" runat="server" Value="" Visible="true" /> 
    <asp:HiddenField ID="hdnNotifyAdmin" runat="server" Value="true" Visible="true" />
    <div id="AddCCRMain" class="ccrModalContainer reimbursementchallengereport">
    <asp:FormView runat="server" ID="formViewRCR" CellPadding="0" Width="100%" DataSourceID="dsRCReport">
        <ItemTemplate>
          <table width="100%" >
                <tr>
                    <td valign="top" style="width:50%;">
                        <table align="left" >
                            <tr align="left">
                                <td width="140px">
                                    <label for="rdRCRDate">Report Date *</label>
                                </td>
                                <td>
                                    <asp:TextBox id="rdRCRDate" TabIndex="1" name="Contact_Date" runat="server" CssClass="datePicker" class="datePicker" style="margin-bottom: 2px;" value='<%# Eval("Contact_Date", "{0:M/dd/yyyy}") %>' />                                    
                                    <asp:CompareValidator runat="server" ID="compareDate" ControlToValidate="rdRCRDate" ErrorMessage="Please enter a valid report date." Display="None" Type="Date" Operator="DataTypeCheck" />   
                                </td>
                            </tr>
                            <tr align="left">
                                <td colspan="2"><label>Products Discussed *</label></td>                                
                            </tr>
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px;">
                                    <div id="spanProducts">
                                    <telerik:RadComboBox runat="server" ID="rdlProductsDiscussed" DataSourceID="dsProductsDiscussed"
                                         TabIndex="2" Skin="pathfinder" Width="300px" DropDownWidth="300px"
                                         EnableEmbeddedSkins="false" DataTextField="Drug_Name" DataValueField="Products_Discussed_ID"
                                         AppendDataBoundItems="true" AllowCustomText="True" Text="-Select Products Discussed-" OnClientDropDownClosed="setProdDiscussedText" OnClientLoad="setProdDiscussedText">
                                         <ItemTemplate>
                                            <span id='<%# String.Format("p{0}",Eval("Products_Discussed_ID")) %>'>
                                               <asp:CheckBox runat="server" ID="chkProductDiscussed" Text ='<%# Eval("Drug_Name") %>' 
                                                             onclick='<%# string.Format("ProdsDiscussChanged(this,{0})", Eval("Products_Discussed_ID")) %>' 
                                                              />
                                               </span>
                                         </ItemTemplate>
                                      </telerik:RadComboBox>
                                    </div>
                                </td>
                            </tr>
                            <tr align="left" valign="top">
                                <td colspan="2" style="padding-left: 5px; ">
                                    Issue *</td>
                            </tr>  
                           
                            <tr align="left" valign="top">
                                <td colspan="2" style="padding-left: 5px; ">
                                        <telerik:RadComboBox runat="server" ID="rdlIssues" DataSourceID="dsIssues"
                                         TabIndex="3" Skin="pathfinder" Width="300px" DropDownWidth="300px"
                                         EnableEmbeddedSkins="false" DataTextField="Issue_Name" DataValueField="Issue_ID"
                                         AppendDataBoundItems="true" SelectedValue='<%# Eval("Issue_ID") %>' OnClientDropDownClosed="issueChanged">
                                            <Items>
                                            <telerik:RadComboBoxItem Text="-Select Issue-" Value="0" Selected="true"/>
                                        </Items>
                                      </telerik:RadComboBox>
                                </td>
                            </tr>
                             <tr align="left" valign="top">
                                   <td width="130px" style="padding-bottom: 5px;">
                                        <div class="otherIssue">
                                        <label for ="rdOther_Issue">If selecting Other:</label>
                                        </div>
                                    </td>
                                    <td style="padding-bottom : 5px;">
                                        <div class="otherIssue">
                                        <asp:TextBox id="rdOther_Issue" TabIndex="4" name="Other_Issue" runat="server" Text='<%# Eval("Other_Issue") %>'  />
                                        </div>
                                    </td>
                            </tr>
                            <tr align="left">
                                <td width="130px" style="padding-bottom : 5px;">
                                    <label for ="rdFollowUpDate"> Follow-up Date:</label>
                                </td>
                                <td style="padding-bottom : 5px;">
                                    <asp:TextBox id="rdFollowUpDate" TabIndex="5" name="Followup_Date" runat="server" CssClass="datePicker" class="datePicker" value='<%# Eval("Followup_Date", "{0:M/dd/yyyy}") %>' />
                                    </td>
                            </tr>
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px; ">
                                     NAM Team Comments:
                                    <asp:TextBox id="rcrTeamComments" Columns = "64" MaxLength="255"  Rows="3" TextMode="MultiLine"  
                                        runat="server" Text='<%# Eval("Team_Comments") %>'  TabIndex="6" Width="300px"
                                        visible='true'/>                                                                
                                    <pinso:MaxLengthValidator ID="MaxLengthValidator1" runat="server" ControlToValidate="rcrTeamComments" ErrorMessage="Team Comments must be less than 255 characters." MaxLength="255" Display="None" />
                             
                                </td>
                            </tr>
                        </table>          
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="2" >
                            <tr align="left">
                                <td width="100px"> 
                                    <label for="rdlNAM">NAM Name*</label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="rdlNAM" runat="server"
                                        AppendDataBoundItems="true" DataSourceID="dsNAM" 
                                        DataTextField="FullName" DataValueField="User_ID" 
                                        DropDownWidth="250px" EnableEmbeddedSkins="false" 
                                        Skin="pathfinder" Width="250px" TabIndex="7"
                                        SelectedValue='<%# Eval("NAM_ID") %>'>
                                        <Items>
                                            <telerik:RadComboBoxItem Text="-Select NAM-" Value="0" Selected="true"/>
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr align="left">
                                <td colspan="2">
                                    <label id="desc" runat="server" visible='true'>
                                    ASSIST Description of Issue/Notes*</label>
                                </td>
                            </tr>     
                            <tr align="right">
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 5px;">                                  
                                   <asp:TextBox id="rcrDesc" Columns = "64" MaxLength="255"  Rows="4" TextMode="MultiLine"  
                                        runat="server" Text='<%# Eval("ASSIST_Desc") %>' TabIndex="8" width="100%"
                                        visible='true'/>                                                                
                                   <pinso:MaxLengthValidator ID="MaxLengthValidator12" runat="server" ControlToValidate="rcrDesc" ErrorMessage="Description must be less than 255 characters." MaxLength="255" Display="None" />
                                </td>
                            </tr> 
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 5px;">
                                    <div id ="rcrContactForm">
                                        <div class="contactHeader">Contacts</div>
                                        <p>Contact <span id="rcrSelectedContact"></span> of <span id="rcrTotalContacts"></span>
                                            <span id="pagerLeft" class="pagination">
                                                <img class="pagerPrev" src="../../../../App_Themes/pathfinder/images/arwLft.gif" onclick="prevContact(); return false" />
                                            </span>
                                            <span id="pagerRight" class="pagination">
                                                <img class="pagerNext" src="../../../../App_Themes/pathfinder/images/arwRt.gif" onclick="nextContact(); return false" />
                                            </span>
                                        </p>
                                            <div class="contactInput">
                                                <label id="rcrContactName" >Name*</label>
                                                <input type="text" id="rcrNameText" runat="server" tabindex="9"/>
                                                <label id="rcrContactTitle">Title*</label>
                                                <input type="text" id="rcrTitleText" runat="server" tabindex="10"/>
                                                <label id="rcrContactPhone" >Phone*</label>
                                                <input type="text" id="rcrPhoneText" runat="server" tabindex="11"/>
                                                <div class="contactValidation"></div>                           
                                                <input type="button" id="rcrContactAdd" value="Add Another Contact" onclick="newIssueContact(); return false"/>         
                                            </div>                                        
                                        </div>

                                </td>
                            </tr>
                            <tr align="left">
                                 <td> 
                                    <label for="rdlNAM">Status*</label>
                                </td>
                                <td>
                                       <telerik:RadComboBox ID="rdlStatus" runat="server"
                                        AppendDataBoundItems="true" DataSourceID="dsStatus" 
                                        DataTextField="Status_Name" DataValueField="Status_ID" 
                                        DropDownWidth="250px" EnableEmbeddedSkins="false" 
                                        Skin="pathfinder" Width="250px" TabIndex="12"
                                        SelectedValue='<%# Eval("Status_ID") %>'>
                                        <Items>
                                            <telerik:RadComboBoxItem Text="-Select Status-" Value="0" Selected="true"/>
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
            </table>             
                                </tr>
            <tr>    
            <td colspan="2">     
                <pinso:ClientValidator ID= "RequiredVal" Target="rdRCRDate" Required ="true" Text="Please select a Date" runat="server"/>
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator1" controltovalidate="rdRCRDate" display="none" errormessage="Reimbursement Issue Report Date required" runat="server" />
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator3" controltovalidate="rdlProductsDiscussed" display="none" InitialValue="-Select Products Discussed-" errormessage="Products Discussed Required" runat="server" />
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator6" controltovalidate="rdlIssues" display="none" InitialValue="-Select Issue-" errormessage="You must select an issue(s)" runat="server" />       
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator7" controltovalidate="rdlNAM" display="none" InitialValue="-Select NAM-" errormessage="You must provide NAM" runat="server" />       
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator4" controltovalidate="rdlStatus" display="none" InitialValue="-Select Status-" errormessage="You must provide a status" runat="server" />              
                <asp:CompareValidator ID="comparefieldvalidator4" ControlToCompare="rdRCRDate" operator="GreaterThan" type="Date" ControlToValidate="rdFollowupDate" Display="None" ErrorMessage="Follow-up Date must be greater than the Reimbursement Issue Report Date" runat="server" />
               <%-- <asp:CompareValidator ID="phoneFieldValidator" runat="server" ControlToValidate="rcrPhoneText" Type="Integer" Operator="DataTypeCheck" Display="None" ErrorMessage="Phone field must be a number!" />
           --%>
                <div style="height:15px;">
                    <asp:ValidationSummary runat="server" ID="validationSummary" DisplayMode="List" />
                </div>
            </td>   
            </tr> 
              </table>
            <div class="adminEmail">
                  Notify Admin<input type ="checkbox" checked="checked" onclick="notifyAdminChanged(this)" runat="server" id="notifyAdmin" class="noborder" /> 
            </div>           
            <div class="modalFormButtons">
                 <pinso:CustomButton TabIndex="13" ID="btnEdit" runat="server" Text="Update" Visible="true" OnClick="Editbtn_Click" />
                 <pinso:CustomButton ID="btnReset" TabIndex="10" runat="server" Text="Reset" OnClick="resetFormView" />                     
            </div>
        </ItemTemplate>
        <InsertItemTemplate>
          <table width="100%" >
                <tr>
                    <td valign="top" style="width: 50%;">
                        <table align="left" >
                            <tr align="left">
                                <td width="140px">
                                    <label for="rdRCRDate">Report Date *</label>
                                </td>
                                <td>
                                    <asp:TextBox id="rdRCRDate" TabIndex="1" name="Contact_Date" runat="server" CssClass="datePicker" class="datePicker" style="margin-bottom: 2px;" value='<%# Eval("Contact_Date", "{0:M/dd/yyyy}") %>' />                                    
                                    <asp:CompareValidator runat="server" ID="compareDate" ControlToValidate="rdRCRDate" ErrorMessage="Please enter a valid report date." Display="None" Type="Date" Operator="DataTypeCheck" />   
                                </td>
                            </tr>
                            <tr align="left">
                                <td colspan="2"><label>Products Discussed *</label></td>                                
                            </tr>
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px;">
                                    <div id="spanProducts">
                                    <telerik:RadComboBox runat="server" ID="rdlProductsDiscussed" DataSourceID="dsProductsDiscussed"
                                         TabIndex="2" Skin="pathfinder" Width="300px" DropDownWidth="300px"
                                         EnableEmbeddedSkins="false" DataTextField="Drug_Name" DataValueField="Products_Discussed_ID"
                                         AppendDataBoundItems="true" AllowCustomText="True" Text="-Select Products Discussed-" 
                                         OnClientDropDownClosed="setProdDiscussedText" OnClientLoad="setProdDiscussedText">
                                         <ItemTemplate>
                                            <span id='<%# String.Format("p{0}",Eval("Products_Discussed_ID")) %>'>
                                               <asp:CheckBox runat="server" ID="chkProductDiscussed" Text ='<%# Eval("Drug_Name") %>' 
                                                             onclick='<%# string.Format("ProdsDiscussChanged(this,{0})", Eval("Products_Discussed_ID")) %>' 
                                                              />
                                               </span>
                                         </ItemTemplate>
                                      </telerik:RadComboBox>
                                    </div>
                                </td>
                            </tr>
                            <tr align="left" valign="top">
                                <td colspan="2" style="padding-left: 5px; ">
                                    Issue *</td>
                            </tr>  
                           
                            <tr align="left" valign="top">
                                <td colspan="2" style="padding-left: 5px; ">
                                        <telerik:RadComboBox runat="server" ID="rdlIssues" DataSourceID="dsIssues"
                                         TabIndex="3" Skin="pathfinder" Width="300px" DropDownWidth="300px"
                                         EnableEmbeddedSkins="false" DataTextField="Issue_Name" DataValueField="Issue_ID"
                                         AppendDataBoundItems="true" SelectedValue='<%# Eval("Issue_ID") %>' OnClientDropDownClosed="issueChanged">
                                            <Items>
                                            <telerik:RadComboBoxItem Text="-Select Issue-" Value="0" Selected="true"/>
                                        </Items>
                                      </telerik:RadComboBox>
                                </td>
                            </tr>
                             <tr align="left" valign="top">
                                    <td width="130px" style="padding-bottom: 5px;">
                                        <div class="otherIssue">
                                        <label for ="rdOther_Issue">If selecting Other:</label>
                                        </div>
                                    </td>
                                    <td style="padding-bottom : 5px;">
                                        <div class="otherIssue">
                                        <asp:TextBox id="rdOther_Issue" TabIndex="4" name="Other_Issue" runat="server" Text='<%# Eval("Other_Issue") %>'  />
                                        </div>
                                    </td>
                            </tr>
                            <tr align="left">
                                <td width="130px" style="padding-bottom : 5px;">
                                    <label for ="rdFollowUpDate"> Follow-up Date:</label>
                                </td>
                                <td>
                                     <asp:TextBox id="rdFollowUpDate" TabIndex="5" name="Followup_Date" runat="server" CssClass="datePicker" class="datePicker" style="margin-bottom: 2px;" value='<%# Eval("Followup_Date", "{0:M/dd/yyyy}") %>' />
                                </td>
                            </tr>
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px; ">
                                     NAM Team Comments:
                                    <asp:TextBox id="rcrTeamComments" Columns = "64" Width="300px" MaxLength="255"  Rows="4" TextMode="MultiLine"  
                                        runat="server" Text=''  TabIndex="6"
                                        visible='true'/>                                                                
                                    <pinso:MaxLengthValidator ID="MaxLengthValidator1" runat="server" ControlToValidate="rcrTeamComments" ErrorMessage="Team Comments must be less than 255 characters." MaxLength="255" Display="None" />                             
                                </td>
                            </tr>
                        </table>          
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="2" >
                            <tr align="left" >
                                <td width="100px"  style="padding-left: 5px;padding-bottom : 2px;"> 
                                    <label for="rdlNAM">NAM Name*</label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="rdlNAM" runat="server"
                                        AppendDataBoundItems="true" DataSourceID="dsNAM" 
                                        DataTextField="FullName" DataValueField="User_ID" 
                                        DropDownWidth="250px" EnableEmbeddedSkins="false" 
                                        Skin="pathfinder" Width="250px" TabIndex="7"
                                        SelectedValue='<%# Eval("User_ID") %>'>
                                        <Items>
                                            <telerik:RadComboBoxItem Text="-Select NAM-" Value="0" Selected="true"/>
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr> 
                            <tr align="left">
                                <td colspan="2"  style="padding-left: 5px;padding-bottom : 5px;">
                                    <label id="desc" runat="server" visible='true'>
                                    ASSIST Description of Issue/Notes</label>
                                </td>
                            </tr>     
                            <tr align="right">
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 5px;">                                  
                                   <asp:TextBox id="rcrDesc" Columns = "64" Rows="4" MaxLength="255" Width="100%"  TextMode="MultiLine"  
                                        runat="server" Enabled="true" TabIndex="8"
                                        visible='true'/>                                                                
                                   <pinso:MaxLengthValidator ID="MaxLengthValidator12" runat="server" ControlToValidate="rcrDesc" ErrorMessage="Description must be less than 255 characters." MaxLength="255" Display="None" />
                                </td>
                            </tr> 
                            <tr align="left">
                                <td colspan="2" style="padding-left: 5px;padding-bottom : 5px;">
                                    <div id ="rcrContactForm">
                                        <div class="contactHeader">Contacts</div>
                                        <p>Contact <span id="rcrSelectedContact"></span> of <span id="rcrTotalContacts"></span>
                                            <span id="pagerLeft" class="pagination">
                                                <img class="pagerPrev" src="../../../../App_Themes/pathfinder/images/arwLft.gif" onclick="prevContact(); return false" />
                                            </span>
                                            <span id="pagerRight" class="pagination">
                                                <img class="pagerNext" src="../../../../App_Themes/pathfinder/images/arwRt.gif" onclick="nextContact(); return false" />
                                            </span>
                                        </p>
                                            <div class="contactInput">
                                                <label id="rcrContactName" >Name</label>
                                                <input type="text" id="rcrNameText" runat="server" tabindex="9"/>
                                                <label id="rcrContactTitle">Title</label>
                                                <input type="text" id="rcrTitleText" runat="server" tabindex="10"/>
                                                <label id="rcrContactPhone" >Phone</label>
                                                <input type="text" id="rcrPhoneText" runat="server" tabindex="11"/> 
                                                <div class="contactValidation"></div>                              
                                                <input type="button" id="rcrContactAdd" value="Add Another Contact" onclick="newIssueContact(); return false"/>         
                                            </div>                                        
                                        </div>
                                </td>
                            </tr>
                            <tr align="left">
                                 <td> 
                                    <label for="rdlNAM">Status*</label>
                                </td>
                                <td>
                                     <telerik:RadComboBox ID="rdlStatus" runat="server"
                                        AppendDataBoundItems="true" DataSourceID="dsStatus" 
                                        DataTextField="Status_Name" DataValueField="Status_ID" 
                                        DropDownWidth="250px" EnableEmbeddedSkins="false" 
                                        Skin="pathfinder" Width="250px" TabIndex="12"
                                        SelectedValue='<%# Eval("Status_ID") %>'>
                                        <Items>
                                            <telerik:RadComboBoxItem Text="-Select Status-" Value="0" Selected="true"/>
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>   
                            </tr>
            </table>
                        </tr>
            <tr>    
            <td colspan="2">     
                <pinso:ClientValidator ID= "RequiredVal" Target="rdRCRDate" Required ="true" Text="Please select a Date" runat="server"/>
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator1" controltovalidate="rdRCRDate" display="none" errormessage="Reimbursement Issue Report Date required" runat="server" />
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator3" controltovalidate="rdlProductsDiscussed" display="none" InitialValue="-Select Products Discussed-" errormessage="Products Discussed Required" runat="server" />
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator6" controltovalidate="rdlIssues" display="none" InitialValue="-Select Issue-" errormessage="You must select an issue(s)" runat="server" />       
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator7" controltovalidate="rdlNAM" display="none" InitialValue="-Select NAM-" errormessage="You must provide NAM" runat="server" />       
                <asp:requiredfieldvalidator ID="Requiredfieldvalidator4" controltovalidate="rdlStatus" display="none" InitialValue="-Select Status-" errormessage="You must provide a status" runat="server" />              
                <asp:CompareValidator ID="comparefieldvalidator4" ControlToCompare="rdRCRDate" operator="GreaterThan" type="Date" ControlToValidate="rdFollowupDate" Display="None" ErrorMessage="Follow-up Date must be greater than the Reimbursement Issue Report Date" runat="server" />
               <%-- <asp:CompareValidator ID="phoneFieldValidator" runat="server" ControlToValidate="rcrPhoneText" Type="Integer" Operator="DataTypeCheck" Display="None" ErrorMessage="Phone field must be a number!" />
           --%>
                <div style="height:15px;">
                    <asp:ValidationSummary runat="server" ID="validationSummary" DisplayMode="List" />
                </div>
            </td>   
            </tr> 
              </table>
                <div class="adminEmail">
                  Notify Admin<input type ="checkbox" checked="checked" onclick="notifyAdminChanged(this)" runat="server" id="notifyAdmin" class="noborder" /> 
            </div>   
            <div class="modalFormButtons">                
                <pinso:CustomButton TabIndex="13" ID="btnEdit" runat="server" Text="Add" Visible="true" OnClick="Addbtn_Click" />
                <pinso:CustomButton ID="btnReset" TabIndex="10" runat="server" Text="Reset" OnClientClick="javascript:ClearForm(); return false;" />                       
            </div>
        </InsertItemTemplate>
    </asp:FormView>
    </div>

    <asp:EntityDataSource ID="dsNAM" runat="server" ConnectionString="name=PathfinderUnitedTheraEntities" DefaultContainerName="PathfinderUnitedTheraEntities" EntitySetName="AccountManagersByTerritoryViewSet">
    </asp:EntityDataSource>
    <asp:EntityDataSource runat="server" ID="dsIssues" ConnectionString="name=PathfinderUnitedTheraEntities"
        DefaultContainerName="PathfinderUnitedTheraEntities" EntitySetName="LkpRCReportIssueSet" OrderBy="it.[Issue_ID]">
    </asp:EntityDataSource>
    <asp:EntityDataSource runat="server" ID="dsProductsDiscussed" ConnectionString="name=PathfinderUnitedTheraEntities"
        DefaultContainerName="PathfinderUnitedTheraEntities" EntitySetName="LkpRCReportProductsDiscussedSet" OrderBy="it.Sort_Index, it.[Drug_Name]">
    </asp:EntityDataSource>
    <asp:EntityDataSource runat="server" ID="dsRCReport" ConnectionString="name=PathfinderUnitedTheraEntities"
        DefaultContainerName="PathfinderUnitedTheraEntities" 
        EntitySetName="RCReportsSet" AutoGenerateWhereClause="True">
        <WhereParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:QueryStringParameter QueryStringField="IRID" Name="RC_Report_ID" Type="Int32"
                ConvertEmptyStringToNull="true" />
        </WhereParameters>
        <InsertParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
        </InsertParameters>
        <UpdateParameters>
            <asp:QueryStringParameter QueryStringField="PlanID" Name="Plan_ID" Type="Int32" ConvertEmptyStringToNull="true" />
            <asp:QueryStringParameter QueryStringField="IRID" Name="RC_Report_ID" Type="Int32"
                ConvertEmptyStringToNull="true" />
        </UpdateParameters>
    </asp:EntityDataSource>   
   
    <asp:EntityDataSource ID="dsStatus" runat="server" ConnectionString="name=PathfinderUnitedTheraEntities" DefaultContainerName="PathfinderUnitedTheraEntities" EntitySetName="LkpRCReportStatusSet">
    </asp:EntityDataSource>
   
    <div>
        <asp:Label ID="Msglbl" runat="server" Text="" Visible="false"></asp:Label>
<%--        <asp:Label ID="Label2" runat="server" Text='<%= Request.Form["PlanID"]%>'></asp:Label>--%>
    </div>
</asp:Content>
 