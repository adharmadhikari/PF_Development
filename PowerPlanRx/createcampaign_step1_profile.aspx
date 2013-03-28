<%@ Page Title="Campaign - Step 1 Plan Profile" Language="C#" MasterPageFile="~/MasterPage.master" Theme="impact" AutoEventWireup="true" CodeFile="createcampaign_step1_profile.aspx.cs" Inherits="createcampaign_step1_profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server"> 

<script type="text/javascript">   
    $(document).ready(pageReady);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(pageReady);
    function pageReady() {
        $("#ChangeComment").dialog({ autoOpen: false, modal: true, width: 400, title: "Change Comment" });
        $("#dial").dialog({ autoOpen: false, modal: true, width: 900, height: 550, title: "", resizable: false, draggable: false });
    }
    function ChangeComment() {
        document.getElementById(document.getElementById('<%=lblCommentTextID.ClientID%>').value).value = document.getElementById('<%=txtComment.ClientID%>').value;
        $("#ChangeComment").dialog('close');
    }   
    function OpenQLCommentWindow(controlID) {
        $("#ChangeCommentSubmit").show();
        document.getElementById('<%=txtComment.ClientID%>').value = document.getElementById(controlID).value;      
        document.getElementById('<%=lblCommentTextID.ClientID%>').value = controlID;

        $("#ChangeComment").dialog('open');
        $("#ChangeComment").dialog('moveToTop')
    }

    function changeRationale(url)
    {
        openModal(url, 'Change Rationale');
    }
    function opportunityAssessment(url)
    {
        openModal(url, 'Opportunity Assessment');
    }
    function openModal(url, title)
    {
        $("#dial").html("<iframe style='height:100%;width:100%'></iframe>").dialog('option', 'title', title).dialog('open').find("iframe").attr("src", url);
    }
</script>

<asp:Panel ID="pnlCampaignInfo" runat="server" >
    <asp:FormView ID="frmCampaignInfo" runat="server" DataSourceID="dsCampaignInfo" HorizontalAlign="Center" Width="100%">
        <ItemTemplate>
            <div class="tileContainerHeader">
                <div class="CampaignInfo">
                    <b>Campaign Name:</b> <asp:label ID="Label1" runat="server"  Text ='<%# Eval("Campaign_Name")%>'></asp:label>                    
                </div>
                <div class="CampaignOpp">
                    <asp:HyperLink ID="hlnkOppAssessment" runat="server" Text="View Campaign Opportunity Assessment Data" NavigateUrl='<%# string.Format("javascript:opportunityAssessment(\"campaignopportunityassessments.aspx?id={0}\")", Request.QueryString["id"]) %>'/></div>
                </div>
            
                               
        </ItemTemplate>       
    </asp:FormView>
</asp:Panel>  
<asp:Panel ID="pnlReadonly" runat="server" Visible="true">       
         <asp:FormView ID="frmPlanInfoReadOnly" runat="server" DataSourceID="dsCampaignInfo" Width="100%">
         <ItemTemplate>
         <div class="tileSubHeader">
            Plan Information
            </div>
           <table class="formPlanInfo">                 
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPlanName" runat="server" text="Plan Name:"></asp:label>            
                    
                 </td>
                 <td>
                    <asp:label ID="lblSelPlanName" runat="server"  Text='<%# Eval("Plan_Name")%>'></asp:label>
                 </td>            
                <td class="formRight"> 
                    <asp:label ID="lblTotalLives" runat="server" text="Total Lives:"></asp:label>            
                    
                </td>
                <td>
                    <asp:Label ID="lblPlanTotalLives" runat="server" Text='<%# Eval("Total_Lives", "{0:n0}")%>'></asp:Label>                   
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblFormularyChange" runat="server" text="Formulary Change?"></asp:label>  
                </td>
                <td>                  
                    <asp:RadioButton ID="radFChangeNo" runat="server" GroupName="FormularyChange" Text = "No" Checked="true" Enabled="false"/>
                    <asp:RadioButton ID="radFChangeYes" runat="server" GroupName="FormularyChange" Text = "Yes" checked='<%#Eval("Formulary_Change_Status")%>' Enabled="false"/>                    
                </td>
                <td class="formRight">
                    <asp:label ID="lblPharmacyLives" runat="server" text="Pharmacy Lives:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblPlanPharmacyLives" runat="server"  Text='<%# Eval("Pharmacy_Lives", "{0:n0}")%>'></asp:Label>                    
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblEffectiveDate" runat="server" text="Formulary Change Effective Date:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblFormularyEffectiveDate" runat="server"  Text='<%#Eval("Formulary_Change_Eff_Date")%>'></asp:Label>
                </td>
                <td class="formRight">
                    <asp:label ID="lblPlanPenetration" runat="server" text="Plan Penetration in Region:" ></asp:label>
                </td>
                <td>
                    <asp:label ID="lblPlanPenetrateRegion" runat="server"  Text='<%#Eval("Plan_Penetrate_Region")%>'></asp:label>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPlanParticipation" runat="server" text="Plan Participation in PT:" ></asp:label>
                </td>
                <td>
                    <asp:RadioButton ID="radParticipationNo" runat="server" GroupName="PlanParticipation" 
                        Text = "No" Checked="true" Enabled="false"/>
                    <asp:RadioButton ID="radParticipationYes" runat="server" GroupName="PlanParticipation" Text = "Yes"  
                        Checked='<%#Eval("Plan_Participation_PT")%>' Enabled="false"/>
                </td>
                <td class="formRight">
                    <asp:label ID="lblContractShareGoal" runat="server" text="Contract Share Goal:" ></asp:label>
                </td>
                <td>
                    <asp:label ID="lblContract_Share_Goal" runat="server"  Text='<%#Eval("Contract_Share_Goal")%>'></asp:label>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblKeyEmployers" runat="server" text="Key Employers:" ></asp:label>
               </td>
               <td>
                    <asp:label ID="lblKey_Employers" runat="server"  Text='<%#Eval("Key_Employers")%>'></asp:label>
                </td>
                <td class="formRight">
                    <asp:label ID="lblKEOtherfacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:label ID="lblOtherFacts1" runat="server"  Text='<%#Eval("Other_Facts1")%>' MaxLength="50"></asp:label>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblAffPhyGroups" runat="server" text="Affiliated Physician Groups:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblAffiliated_Phys_Groups" runat="server"  Text='<%#Eval("Affiliated_Phys_Groups")%>'></asp:Label>
                </td>
                <td class="formRight">
                    <asp:label ID="lblAffPhyGroupOtherFacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblOther_Facts2" runat="server"  Text='<%#Eval("Other_Facts2")%>'></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblNationalAccAff" runat="server" text="National Account Affiliation:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblNational_Account_Affiliates" runat="server"  Text='<%#Eval("National_Account_Affiliates")%>'></asp:Label>
                </td>
                <td class="formRight">
                    <asp:label ID="lblNationalAccAffOtherfacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblOther_Facts3" runat="server"  Text='<%#Eval("Other_Facts3")%>'></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPBMAffiliation" runat="server" text="PBM Affiliation:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblPBM_Affiliation" runat="server"  Text='<%#Eval("PBM_Affiliation")%>' MaxLength="50"></asp:label>
                </td>
                <td class="formRight">
                    <asp:label ID="lblPBMAffOtherFacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:Label ID="lblOther_Facts4" runat="server"  Text='<%#Eval("Other_Facts4")%>' MaxLength="50"></asp:Label>
                </td>
            </tr>        
            <tr>
                <td colspan="4">            
                    <asp:label ID="lblCampaignRational" runat="server" text="Rationale for the Campaign:" ></asp:label>
                
                    <asp:label ID="CampaignRationale" runat="server"  Text='<%#Eval("Campaign_Rationale")%>'></asp:label>                     
                   
                </td>        
            </tr>            
         </table>
         </ItemTemplate> 
         </asp:FormView> 
         <!--datalist-->         
         <asp:DataList ID="dlProdInfoReadOnly" runat="server" DataKeyField="Brand_Name" RepeatDirection="Horizontal" CssClass="CampProdInfo" DataSourceID="dsCampaignProductFormulary">
             <ItemTemplate>   
                <div class="tileSubHeader">  
                    <asp:Label ID="Brand_NameLabel" runat="server" Text='<%# Eval("Brand_Name") %>' />                   
                </div>
                <table class="formProdList">
                    <tr>
                        <td class="formRight"><asp:Label ID="lblTierPosition" runat ="server" Text="Tier:" ></asp:Label></td>
                        <td><asp:Label ID="txtProduct_Tier" runat="server" Text='<%# Eval("Product_Tier") %>'  /></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblCopay" runat ="server" Text="Co-Pay:" ></asp:Label></td>
                        <td><asp:Label ID="txtProduct_Copay" runat="server" Text='<%# Eval("Product_Copay") %>' />
                    </td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblPA" runat ="server" Text="PA:" ></asp:Label></td>
                        <td><asp:Label ID="Product_PA" runat="server" Text='<%# Eval("Product_PA") %>' /></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblPACommnets" runat ="server" Text="PA Comments:" ></asp:Label></td>
                        <td><asp:Label ID="Product_PA_Comment" runat="server" Text='<%# Eval("Product_PA_Comment") %>' /></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblQL" runat ="server" Text="QL:" ></asp:Label></td>
                        <td><asp:Label ID="Product_QL" runat="server" Text='<%# Eval("Product_QL") %>' /></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblQLComments" runat ="server" Text="QL Comments:" ></asp:Label></td>
                        <td><asp:Label ID="Product_QL_Comment" runat="server" 
                        Text ='<%# (Eval("Product_QL_Comment").ToString().Substring(0, Math.Min(Eval("Product_QL_Comment").ToString().Length, 50)))%>'/></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblST" runat ="server" Text="ST:" ></asp:Label></td>
                        <td><asp:Label ID="Product_ST" runat="server" Text='<%# Eval("Product_ST") %>' /></td>
                    </tr>
                    <tr>
                        <td class="formRight"><asp:Label ID="lblSTComments" runat ="server" Text="ST Comments:" ></asp:Label></td>
                        <td> <asp:Label ID="Product_ST_Comment" runat="server" Text='<%# Eval("Product_ST_Comment") %>' /></td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
</asp:Panel>
<asp:Panel ID="pnlEdit" runat="server" Visible="false">
    <asp:Panel ID="pnlPlanInfo" runat="server" >
      <asp:FormView ID="frmPlanInfo" runat="server" DataSourceID="dsCampaignInfo" Width="100%">
         <ItemTemplate>
         <div class="tileSubHeader">
            Plan Information
            </div>
           <table class="formPlanInfo">                 
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPlanName" runat="server" text="Plan Name:"></asp:label>            
                    
                 </td>
                 <td>
                    <asp:label ID="lblSelPlanName" runat="server"  Text='<%# Eval("Plan_Name")%>'></asp:label>
                 </td>            
                <td class="formRight"> 
                    <asp:label ID="lblTotalLives" runat="server" text="Total Lives:"></asp:label>            
                    
                </td>
                <td>
                    <asp:TextBox ID="txtPlanTotalLives" runat="server" Text='<%# Eval("Total_Lives")%>' MaxLength="13" style="text-align: right;" ></asp:TextBox>
                    <ajax:MaskedEditExtender ID="meeTotalLives" runat="server" TargetControlID="txtPlanTotalLives" Mask="9,999,999,999" MessageValidatorTip="true" MaskType="Number" InputDirection="RightToLeft" DisplayMoney="None" AcceptNegative="None" ErrorTooltipEnabled="true" AutoComplete="false" > 
                    </ajax:MaskedEditExtender> 
                    <ajax:MaskedEditValidator ID="mevTotalLives" runat="server" ControlExtender="meeTotalLives"  ControlToValidate="txtPlanTotalLives" MaximumValue="2147483647" MaximumValueMessage="Please enter a smaller number." Display="Dynamic"></ajax:MaskedEditValidator>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblFormularyChange" runat="server" text="Formulary Change?"></asp:label>  
                </td>
                <td>                  
                    <asp:RadioButton ID="radFChangeNo" runat="server" GroupName="FormularyChange" Text = "No" Checked="true" />
                    <asp:RadioButton ID="radFChangeYes" runat="server" GroupName="FormularyChange" Text = "Yes" checked='<%#Eval("Formulary_Change_Status")%>'/>                    
                </td>
                <td class="formRight">
                    <asp:label ID="lblPharmacyLives" runat="server" text="Pharmacy Lives:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtPlanPharmacyLives" runat="server"  Text='<%# Eval("Pharmacy_Lives")%>' MaxLength="13" style="text-align: right;" ></asp:TextBox>
                    <ajax:MaskedEditExtender ID="meePharmacyLives" runat="server" TargetControlID="txtPlanPharmacyLives" Mask="9,999,999,999" MessageValidatorTip="true" MaskType="Number" InputDirection="RightToLeft" DisplayMoney="None" AcceptNegative="None" ErrorTooltipEnabled="true" AutoComplete="false" > 
                    </ajax:MaskedEditExtender>  
                    <ajax:MaskedEditValidator ID="mevPharmacyLives" runat="server" ControlExtender="meePharmacyLives"  ControlToValidate="txtPlanPharmacyLives" MaximumValue="2147483647" MaximumValueMessage="Please enter a smaller number." Display="Dynamic"></ajax:MaskedEditValidator>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblEffectiveDate" runat="server" text="Formulary Change Effective Date:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtEffectiveDate" runat="server"  Text='<%#Eval("Formulary_Change_Eff_Date")%>' MaxLength="10"></asp:TextBox>                  
                    <ajax:CalendarExtender runat="server" ID="calEffectiveDate" TargetControlID="txtEffectiveDate" />
                    <asp:CompareValidator ID="cvalDate" runat="server"  ErrorMessage="Invalid Date!" ControlToValidate="txtEffectiveDate" 
                    Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                </td>
                <td class="formRight">
                    <asp:label ID="lblPlanPenetration" runat="server" text="Plan Penetration in Region:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtPlanPenetration" runat="server"  Text='<%#Eval("Plan_Penetrate_Region")%>' MaxLength="20"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPlanParticipation" runat="server" text="Plan Participation in PT:" ></asp:label>
                </td>
                <td>
                    <asp:RadioButton ID="radParticipationNo" runat="server" GroupName="PlanParticipation" 
                        Text = "No" Checked="true" />
                    <asp:RadioButton ID="radParticipationYes" runat="server" GroupName="PlanParticipation" Text = "Yes"  Checked='<%#Eval("Plan_Participation_PT")%>'/>
                </td>
                <td class="formRight">
                    <asp:label ID="lblContractShareGoal" runat="server" text="Contract Share Goal:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtContractShareGoal" runat="server"  Text='<%#Eval("Contract_Share_Goal")%>' MaxLength="20"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblKeyEmployers" runat="server" text="Key Employers:" ></asp:label>
               </td>
               <td>
                    <asp:TextBox ID="txtKeyEmployers" runat="server"  Text='<%#Eval("Key_Employers")%>' MaxLength="50"></asp:TextBox>
                </td>
                <td class="formRight">
                    <asp:label ID="lblKEOtherfacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtKEOtherFacts" runat="server"  Text='<%#Eval("Other_Facts1")%>' MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblAffPhyGroups" runat="server" text="Affiliated Physician Groups:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtAffPhyGroups" runat="server"  Text='<%#Eval("Affiliated_Phys_Groups")%>' MaxLength="50"></asp:TextBox>
                </td>
                <td class="formRight">
                    <asp:label ID="lblAffPhyGroupOtherFacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtAffPhyGroupOtherFacts" runat="server"  Text='<%#Eval("Other_Facts2")%>' MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblNationalAccAff" runat="server" text="National Account Affiliation:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtNationalAccAff" runat="server"  Text='<%#Eval("National_Account_Affiliates")%>' MaxLength="50"></asp:TextBox>
                </td>
                <td class="formRight">
                    <asp:label ID="lblNationalAccAffOtherfacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtNationalAccAffOtherfacts" runat="server"  Text='<%#Eval("Other_Facts3")%>' MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formRight">
                    <asp:label ID="lblPBMAffiliation" runat="server" text="PBM Affiliation:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtPBMAffiliation" runat="server"  Text='<%#Eval("PBM_Affiliation")%>' MaxLength="50"></asp:TextBox>
                </td>
                <td class="formRight">
                    <asp:label ID="lblPBMAffOtherFacts" runat="server" text="Other Facts:" ></asp:label>
                </td>
                <td>
                    <asp:TextBox ID="txtPBMAffOtherFacts" runat="server"  Text='<%#Eval("Other_Facts4")%>' MaxLength="50"></asp:TextBox>
                </td>
            </tr>        
            <tr>
                <td colspan="4">            
                    <asp:label ID="lblCampaignRational" runat="server" text="Rationale for the Campaign:" ></asp:label>
                
                    <asp:label ID="CampaignRationale" runat="server"  Text='<%#Eval("Campaign_Rationale")%>'></asp:label>
                    <asp:HyperLink runat="server" ID="linkRationale" Text="Change Rationale" NavigateUrl='<%# string.Format("javascript:changeRationale(\"Campaign_Rationale.aspx?Plan_ID={0}&Brand_ID={1}&id={2}\")", Eval("Plan_ID"), Eval("Brand_ID"), Request.QueryString["id"])%>' />
                </td>        
            </tr>
             <asp:label ID="lblPlanID" runat="server" text='<%#Eval("Plan_ID")%>' Visible="false"></asp:label>   
             <asp:label ID="lblBrandID" runat="server" text='<%#Eval("Brand_ID")%>' Visible="false"></asp:label>
         </table>
         </ItemTemplate> 
         </asp:FormView> 
    </asp:Panel> 
                 
    <asp:Panel ID="pnlProductInfo" runat="server" >
        <asp:DataList ID="dlCampaignProdInfo" runat="server" DataKeyField="Brand_Name" RepeatDirection="Horizontal" CssClass="CampProdInfo">   
        <ItemTemplate>
            <div class="tileSubHeader">  
                <asp:Label ID="Brand_NameLabel" runat="server" Text='<%# Eval("Brand_Name") %>' />
                <asp:Label ID="CampaignID" runat="server" Text = '<%#Eval("Campaign_ID")%>' Visible="false"></asp:Label>
                <asp:Label ID ="Product_ID" runat="server" Text='<%#Eval("Product_ID")%>' Visible="false"></asp:Label>
            </div>
            <table class="formPlanInfo">
                <tr>
                    <td class="formRight"><asp:Label ID="lblTierPosition" runat ="server" Text="Tier:" ></asp:Label></td>
                    <td><asp:Label ID="txtProduct_Tier" runat="server" Text='<%# Eval("Product_Tier") %>'  /></td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblCopay" runat ="server" Text="Co-Pay:" ></asp:Label></td>
                    <td><asp:Label ID="txtProduct_Copay" runat="server" Text='<%# Eval("Product_Copay") %>' />
                </td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblPA" runat ="server" Text="PA:" ></asp:Label></td>
                    <td><asp:Label ID="Product_PA" runat="server" Text='<%# Eval("Product_PA") %>' /></td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblPACommnets" runat ="server" Text="PA Comments:" ></asp:Label></td>
                    <td><asp:Label ID="Product_PA_Comment" runat="server" 
                        Text='<%# Eval("PA_Comment_ID") %>' Visible="false" />              
                        <telerik:RadComboBox runat="server"  EnableEmbeddedSkins="false" SkinID="impactGen" ID="ddlProduct_PA_Comment" 
                            DataSourceID="dsPAComment" DataTextField="PA_Comments" DataValueField="PA_Comment_ID" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="..Select a PA Comment.." Value="0" />
                            </Items>
                        </telerik:RadComboBox> 
                    </td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblQL" runat ="server" Text="QL:" ></asp:Label></td>
                    <td><asp:Label ID="Product_QL" runat="server" 
                Text='<%# Eval("Product_QL") %>' /></td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblQLComments" runat ="server" Text="QL Comments:" ></asp:Label></td>
                    <td><asp:TextBox ID="txtProduct_QL_Comment" runat="server" MaxLength="500" 
                Text ='<%# Eval("Product_QL_Comment") %>' /> <asp:HyperLink id="hypQL" runat="server" Text="Change QL"></asp:HyperLink></td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblST" runat ="server" Text="ST:" ></asp:Label></td>
                    <td><asp:Label ID="Product_ST" runat="server" 
                Text='<%# Eval("Product_ST") %>' /></td>
                </tr>
                <tr>
                    <td class="formRight"><asp:Label ID="lblSTComments" runat ="server" Text="ST Comments:" ></asp:Label></td>
                    <td> <asp:Label ID="Product_ST_Comment" runat="server" Text='<%# Eval("ST_Comment_ID") %>' Visible="false" />
                        <telerik:RadComboBox EnableEmbeddedSkins="false" SkinID="impactGen" runat="server" ID="ddlProduct_ST_Comment" 
                            DataSourceID="dsSTComment" DataTextField="ST_Comments" DataValueField="ST_Comment_ID" AppendDataBoundItems="true">
                            <Items>
                                <telerik:RadComboBoxItem Text="..Select a ST Comment.." Value="0" />
                            </Items>
                        </telerik:RadComboBox>   
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>     
    </asp:Panel>     
         
    <div id="ChangeComment" style="display:none;">
        <div id="ChangeCommentSubmit">
            <div>Please provide the QL Comment</div>
            <asp:TextBox runat="server" ID="txtComment" TextMode="MultiLine" Width="400px" Height="200" MaxLength="500"/>
            <asp:Label ID="lblCommentTextID" runat="server" ForeColor="White"></asp:Label>
            <asp:Button runat="server" ID="btnSubmitComment" Text="OK" OnClientClick="ChangeComment()" />
        </div>       
    </div>
   </asp:Panel>    
    <asp:SqlDataSource ID="dsCampaignInfo" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
        SelectCommand="usp_GetCampaignInfoByCampaignID" SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" />
        </SelectParameters>      
    </asp:SqlDataSource> 
    <asp:SqlDataSource ID="dsCampaignStatus" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
        SelectCommand="usp_Campaign_IsActive" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" />                    
        </SelectParameters>
     </asp:SqlDataSource>
     <asp:SqlDataSource ID="dsPAComment" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
        SelectCommand="usp_GetPAComments" SelectCommandType="StoredProcedure">        
     </asp:SqlDataSource> 
     <asp:SqlDataSource ID="dsSTComment" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
        SelectCommand="usp_GetSTComments" SelectCommandType="StoredProcedure">        
     </asp:SqlDataSource>  
     <asp:SqlDataSource ID="dsCampaignProductFormulary" runat="server" ConnectionString="<%$ ConnectionStrings:impact %>"
        SelectCommand="usp_GetCampaignProductFormulary" SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" />
        </SelectParameters>      
    </asp:SqlDataSource> 
    <div id="dial" style="display:none"></div>
</asp:Content>

