<%@ Page Title="PowerPlanRx - Step 4 Best Practices" Language="C#" MasterPageFile="~/MasterPage.master" ValidateRequest="false" AutoEventWireup="true" Theme="impact" CodeFile="createcampaign_step4_bestpractices.aspx.cs" Inherits="createcampaign_step4_bestpractices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    
    <div class="tileContainerHeader">Campaign Close and Lessons Learned (Best Practices)</div>
    <asp:FormView runat="server" ID="formView"  DataSourceID="dsCampaignBestPractices" DataKeyNames="Campaign_ID" DefaultMode="ReadOnly" Width="100%">        
        
        <ItemTemplate>  
        <table cellpadding="0" cellspacing="0" border="0" class="formPlanInfo"> 
            <col width="30%" />
            <col width="70%"   />
        <tr>    
            <td class="formRight"><asp:Label ID="lblGoalAchievement" runat="server" Text="Goal Achievement (yes/no and why?)"></asp:Label></td>
            <td><asp:RadioButton ID="GoalAchievement_No" GroupName="btnGoalAchievement" runat="server" Text="No" checked="true" Enabled="false" />
            <asp:RadioButton ID="GoalAchievement_Yes" GroupName="btnGoalAchievement" runat="server" Text="Yes" checked='<%#Eval("Goal_Achieved")%>' Enabled="false" />  </td>          
            </tr>
            <tr>  
            <td colspan="2"><asp:Label runat="server" ID="lblGoal_Achieved_Reason" Text='<%# Eval("Goal_Achieved_Reason") %>' /> </td>
            </tr>
            <tr>  
            <td class="formRight"><asp:Label ID="lblFeedback" runat="server" Text="Account (health plan) response/feedback to campaign?"></asp:Label> </td>
            <td><asp:Label runat="server" ID="lblFeedback_Result" Text='<%# Eval("Feedback") %>' />
            </tr>
            <tr>  
            <td class="formRight"><asp:Label ID="lblTactics_Effectiveness" runat="server" Text="Which tactics were effective/not effective and why?"></asp:Label> </td>
            <td><asp:Label runat="server" ID="lblTactics_Effectiveness_Result" Text='<%# Eval("Tactics_Effectiveness") %>' /> </td>
            </tr>
            <tr>  
            <td class="formRight"><asp:Label ID="lblProcess_Effectiveness" runat="server" Text="What parts of the process were effective/not effective and why?"></asp:Label> </td>
            <td><asp:Label runat="server" ID="lblProcess_Effectiveness_Result" Text='<%# Eval("Process_Effectiveness") %>' /> </td>
            </tr>
            <tr>  
            <td class="formRight"><asp:Label ID="lblFuture_Impl_Opp" runat="server" Text="Future implications and opportunities for the account?"></asp:Label> </td>
            <td><asp:Label runat="server" ID="lblFuture_Impl_Opp_Result" Text='<%# Eval("Future_Impl_Opp") %>' /> </td>
            </tr> 
            </table>         
        </ItemTemplate>
        
        <EditItemTemplate>
            <table cellpadding="0" cellspacing="0" border="0" class="formPlanInfo">
                <col width="30%" />
                <col width="70%" />
                <tr>
                    <td class="formRight">
                        <asp:Label ID="lblGoalAchievement" runat="server" Text="Goal Achievement (yes/no and why?)"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="GoalAchievement_No" GroupName="btnGoalAchievement" runat="server"
                            Text="No" Checked="true" />
                        <asp:RadioButton ID="GoalAchievement_Yes" GroupName="btnGoalAchievement" runat="server"
                            Text="Yes" Checked='<%# Bind("Goal_Achieved")%>' />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:TextBox runat="server" ID="txtGoalAchieved" TextMode="MultiLine" Text='<%# Bind("Goal_Achieved_Reason") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblFeedback" runat="server" Text="Account (health plan) response/feedback to campaign?"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFeedback" TextMode="MultiLine" Text='<%# Bind("Feedback") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTactics" runat="server" Text="Which tactics were effective/not effective and why?"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtTactics" TextMode="MultiLine" Text='<%# Bind("Tactics_Effectiveness") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblParts" runat="server" Text="What parts of the process were effective/not effective and why?"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtParts" TextMode="MultiLine" Text='<%# Bind("Process_Effectiveness") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblFuture" runat="server" Text="Future implications and opportunities for the account?"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtFuture" TextMode="MultiLine" Text='<%# Bind("Future_Impl_Opp") %>' />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        
    </asp:FormView>
    <div class="notice">Best Practices must be compliant with PRB and corporate policies</div>
    
    <asp:SqlDataSource runat="server" ID="dsCampaignBestPractices" 
        ConnectionString='<%$ ConnectionStrings:impact %>' 
        SelectCommand="usp_GetCampaignBestPractices_By_Campaign_Id" SelectCommandType="StoredProcedure"
        UpdateCommand="usp_Campaign_UpdateBestPractices" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter SessionField="fullName" Name="userName" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

