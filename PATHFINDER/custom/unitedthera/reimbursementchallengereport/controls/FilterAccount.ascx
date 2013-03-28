<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FilterAccount.ascx.cs" Inherits="custom_controls_FilterAccount" %>
<div class="filterGeo">
<asp:Literal runat="server" ID="filterLabel" Text="Account Name" />
</div>

<div class="searchTextBoxFilter">
    <input type="text" id="Plan_ID" class="textBox" />
</div>


<%-- IMPORTANT - QueryFormat and QueryValues are handled in javascript due to dependency on FilterMarketSegment --%>
 <pinso:SearchList runat="server" Target="Plan_ID" ClientManagerID="mainSection" ContainerID="moduleOptionsContainer" OffsetX="-6"
                                
                                    ServiceUrl="services/pathfinderservice.svc/PlanInfoListViewSet" 
                                    QueryFormat="$filter=substringof('{0}',Plan_Name)&$top=50&$orderby=Plan_Name" 
                                    QueryValues=""
                                    DataField="Plan_ID" 
                                    TextField="Plan_Name"
                                    MultiSelect="true" 
                                    MultiSelectHeaderText="Selected Accounts"
                                    WaterMarkText="Type to search"
                                    ID="searchlist"/>

 