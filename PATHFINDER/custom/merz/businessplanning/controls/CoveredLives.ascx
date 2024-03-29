﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CoveredLives.ascx.cs" Inherits="controls_CoveredLives" %>
<div id="lfView">
    <asp:FormView runat="server" ID="frVwPICovLives" CssClass="totalCL" DataSourceID="dsPlanInfo" CellPadding="0" CellSpacing="0" Width="100%">
        <ItemTemplate>
        <table  class="genTable" cellpadding="0" cellspacing="0" border="0" >
                <tr runat="server" visible='<%# ShowTotalCoveredLives && Convert.ToInt32(Eval("Total_Covered")) != 0%>'>
                    <td style="width:65% !important"><asp:Literal runat="server" Text='<%$ Resources:Resource, Label_Covered_Lives %>' />&nbsp;</td>
                    <td  class="rn alignRight" width="50%"><%# Eval("Total_Covered", "{0:n0}")%>&nbsp;</td>
                </tr>
                <tr runat="server" visible='<%# ShowPharmLives && Convert.ToInt32(Eval("Total_Pharmacy")) != 0%>'>
                    <td style="width:35% !important"><asp:Literal ID="Literal1" runat="server" Text='<%$ Resources:Resource, Label_Total_Pharmacy_Lives %>' />&nbsp;</td>
                    <td class="rn alignRight" width="50%"><%# Eval("Total_Pharmacy", "{0:n0}")%>&nbsp;</td>
                </tr>
            </table>         
        </ItemTemplate> 
    </asp:FormView>     

     <telerik:RadGrid SkinID="radTable" runat="server" ID="gridCoveredLives" AllowSorting="true"  AllowPaging="false" AllowFilteringByColumn="false" EnableEmbeddedSkins="false"
     DataSourceID="dsCoveredLives">        
        <MasterTableView autogeneratecolumns="false" ClientDataKeyNames="Plan_ID" AllowSorting="false">
           <Columns>
            <telerik:GridBoundColumn DataField="Covered_Lives_Type_Name" UniqueName="Covered_Lives_Type_Name" HeaderText="Lives Distribution" HeaderStyle-Width="65%" ItemStyle-CssClass="firstCol" />
            <telerik:GridBoundColumn DataField="Covered_Lives" HeaderText="" UniqueName="Covered_Lives" HeaderStyle-Width="35%" DataFormatString="{0:n0}"  ItemStyle-CssClass="alignRight" />
            </Columns>  
            <SortExpressions>
                <telerik:GridSortExpression FieldName="Covered_Lives_Order" SortOrder="Ascending" />   
            </SortExpressions>               
        </MasterTableView>           
    </telerik:RadGrid>
    
     <telerik:RadGrid SkinID="radTable" runat="server" ID="gridProductCoveredLives" AllowSorting="false"  AllowPaging="false" AllowFilteringByColumn="false" EnableEmbeddedSkins="false" DataSourceID="dsproductCoveredLives">        
        <MasterTableView autogeneratecolumns="false" ClientDataKeyNames="Prod_ID">
           <Columns>
            <telerik:GridBoundColumn DataField="Prod_Type_Name" UniqueName="Prod_Type_Name" HeaderText="Product Lives Distribution" HeaderStyle-Width="50%" ItemStyle-CssClass="firstCol" />
            <telerik:GridBoundColumn DataField="TotalProdTypePharmacyLives" HeaderText="" UniqueName="TotalProdTypePharmacyLives" HeaderStyle-Width="50%" DataFormatString="{0:n0}"  ItemStyle-CssClass="alignRight" />
            </Columns>  
            <SortExpressions>
                <telerik:GridSortExpression FieldName="Prod_Type_ID" SortOrder="Ascending" />   
            </SortExpressions>               
        </MasterTableView>           
    </telerik:RadGrid>   
</div> 
  
    <asp:EntityDataSource ID="dsCoveredLives" runat="server" EntitySetName="V_CoveredLivesSet" ConnectionString="name=PathfinderEntities" DefaultContainerName="PathfinderEntities" 
         AutoGenerateOrderByClause="false" Select="" 
        Where="(it.Covered_Lives_Order=4 or it.Covered_Lives_Order=5 or it.Covered_Lives_Order=6  or it.Covered_Lives_Order=7  or it.Covered_Lives_Order=8) and it.Plan_ID =@Plan_ID" > 
        <WhereParameters>       
            <asp:QueryStringParameter QueryStringField="plan_ID" Name="Plan_ID" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>
    
    <asp:SqlDataSource ID="dsproductCoveredLives" runat="server" ConnectionString="<%$ ConnectionStrings:Pathfinder %>" 
        SelectCommand="usp_MedD_ProductCoveredLives" SelectCommandType="StoredProcedure">      
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="Prod_ID" Name="Prod_ID" Type="Int32" /> 
            <asp:QueryStringParameter QueryStringField="Plan_State" Name="Prod_State" Type="string" />            
        </SelectParameters>
    </asp:SqlDataSource> 
    
    <asp:EntityDataSource ID="dsPlanInfo" runat="server" EntitySetName="PlanInfoSet" ConnectionString="name=PathfinderEntities" DefaultContainerName="PathfinderEntities" 
        AutoGenerateWhereClause="true">
        <WhereParameters>       
            <asp:QueryStringParameter QueryStringField="plan_ID" Name="Plan_ID" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>