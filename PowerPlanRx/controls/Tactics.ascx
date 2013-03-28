<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Tactics.ascx.cs" Inherits="controls_Tactics" %>

<div id="TacticsReadOnly" runat="server"  >
<div class="tileSubHeader">Tactics</div>

<telerik:RadGrid EnableEmbeddedSkins="false" SkinID="table1" runat="server" ID="rgTacticsReadOnly" AutoGenerateColumns="false" DataSourceID="dsTacticsSelectedReadOnly" 
  AllowSorting="true" AllowPaging="false" >
        <MasterTableView DataKeyNames="Campaign_ID, Tactics_ID" >
              <Columns >  
               <%-- Thumbnail --%>          
               <telerik:GridTemplateColumn HeaderText="Thumbnail" HeaderStyle-Width="16%" >
                 <ItemTemplate  >
                    <asp:HyperLink ID="hypThumbReadOnly" runat="server" ImageUrl='<%# Eval("Tactics_Thumb_Filename","~/usercontent/products/thumbnails/{0}") %>'
                      NavigateUrl='<%# Eval("Tactics_Image_Filename","~/usercontent/products/{0}") %>' Target="_blank" >
                    </asp:HyperLink>
              </ItemTemplate>
               </telerik:GridTemplateColumn>
            <%-- Thumbnail End  --%> 
            
                <telerik:GridBoundColumn DataField="Tactics_Name" HeaderText="Tactic Name" UniqueName="Tactics_Name" ReadOnly="true"  HeaderStyle-Width="16%"   />
                <telerik:GridBoundColumn DataField="Tactics_Description" HeaderText="Tactic or Program Description" UniqueName="Tactics_Description" ReadOnly="true" HeaderStyle-Width="50%"    />
                <telerik:GridTemplateColumn HeaderText="Qty Needed"  HeaderStyle-Width="16%" ItemStyle-CssClass="alignRight">
                     <ItemTemplate>
                        <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Qty","{0:n0}") %>'></asp:Label>
                      </ItemTemplate>
                 
                </telerik:GridTemplateColumn>
    
            </Columns>
        </MasterTableView>
        <ClientSettings Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true" Selecting-AllowRowSelect="false" />
 </telerik:RadGrid>
</div>

<asp:SqlDataSource runat="server" ID="dsTacticsSelectedReadOnly" ConnectionString='<%$ ConnectionStrings:impact %>' 
      SelectCommand="usp_Campaign_Tactics_SelectedList" 
        SelectCommandType="StoredProcedure" ProviderName="System.Data.SqlClient" >
        
        <SelectParameters>
            <asp:QueryStringParameter Name="Campaign_ID" QueryStringField="id" DefaultValue="" />
         </SelectParameters>
 
    </asp:SqlDataSource>    

