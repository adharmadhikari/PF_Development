﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FiltersContainerScript.ascx.cs" Inherits="custom_controls_FiltersContainerScript" %>
<%@ OutputCache Shared="true" VaryByParam="None" Duration="120" %>  
  
    <script type="text/javascript">

        clientManager.add_pageLoaded(filters_pageLoaded, "moduleOptionsContainer");
        clientManager.add_pageUnloaded(filters_pageUnloaded, "moduleOptionsContainer");

        var _filterPageDefaults = [];
        
        function filters_pageLoaded(sender, args)
        {
            $clearAlert(); //make sure any previous alerts are cleared.
            
            $addHandler($get("requestReportButton"), "click", requestReport);
            $addHandler($get("clearFiltersButton"), "click", clearReportFilters);

            $reloadContainer("moduleOptionsContainer", clientManager.get_SelectionData());

            standardreports_content_resize();

            $(".datePicker").datepicker();
            
        }

        function filters_pageUnloaded(sender, args) {
            
            $removeHandler($get("requestReportButton"), "click", requestReport);
            $removeHandler($get("clearFiltersButton"), "click", clearReportFilters);

            clientManager.remove_pageLoaded(filters_pageLoaded, "moduleOptionsContainer");
            clientManager.remove_pageUnloaded(filters_pageUnloaded, "moduleOptionsContainer");
        }

        function requestReport()
        {
            var data = $getContainerData("filtersContainer");

            if ($validateContainerData("filtersContainer", data, '<%= Resources.Resource.Label_Report_Filters %>'))
            {
                data["__options"] = $getContainerData("optionsContainer");
                clientManager.set_SelectionData(data);
            }
        }

        function formatDate(value) {
            return value.getMonth() + 1 + "/" + value.getDate() + "/" + value.getYear();
        }
       
        function clearReportFilters()
        {
            $resetContainer("filterControls");

            //Add Current Month dates to timeframe textboxes as that is the default selection

            var e = new Date()
            var b = new Date();
            
            b.setMonth(b.getMonth() + 1);
            b.setDate(0);

            e.setMonth(e.getMonth()); 
            e.setDate(1);
            
            $('#timeFrame').hide();
            $('#txtFrom').val(e.format('MM/dd/yyyy'));
            $('#txtTo').val(b.format('MM/dd/yyyy'));
        }
                
    </script>