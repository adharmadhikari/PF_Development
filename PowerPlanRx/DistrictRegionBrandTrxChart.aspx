<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DistrictRegionBrandTrxChart.aspx.cs" Inherits="DistrictRegionBrandTrxChart" %>
<%@ Register Src="~/controls/DistrictRegionBrand.ascx" TagName="DistrictRegionBrand" TagPrefix="pinso" %>
<%@ Register Src="~/controls/DistrictRegionBrand_All.ascx" TagName="DistrictRegionBrand_All" TagPrefix="pinso" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
 
      <div>
      
          <asp:HiddenField ID="hdnQString" runat="server" />
          <%--<a href="javascript:exportFile('hdnQString','DistrictRegionBrand','DistrictRegionBrand_All','DistrictRegionBrandTrxchart','pdf')" >PDF</a>        
          <a href="javascript:PrintPage('divPageContent','District Region Brand')" >Print</a> --%>
          
          <div id="divPageContent" >                      
                     
                    <asp:Label ID ="lblPageHeading" runat="server" Text="District/Region Profile - Brand TRx - Pie Chart" ></asp:Label>
                    <pinso:DistrictRegionBrand runat="server" ID="DistrictRegionBrand" />  
                    <pinso:DistrictRegionBrand_All runat="server" ID="DistrictRegionBrand_All" />
               
               
         </div>
     </div>  
    </form>
</body>
</html>
