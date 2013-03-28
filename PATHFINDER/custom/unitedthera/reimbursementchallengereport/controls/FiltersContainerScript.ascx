<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FiltersContainerScript.ascx.cs" Inherits="custom_controls_FiltersContainerScript" %>
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

            //            customercontactreport_content_resize ();
            //contactreports_content_resize();
            standardreports_content_resize();

            $(".datePicker").datepicker();
            
        }

        function filters_pageUnloaded(sender, args) {
            
            $removeHandler($get("requestReportButton"), "click", requestReport);
            $removeHandler($get("clearFiltersButton"), "click", clearReportFilters);

            clientManager.remove_pageLoaded(filters_pageLoaded, "moduleOptionsContainer");
            clientManager.remove_pageUnloaded(filters_pageUnloaded, "moduleOptionsContainer");
        }

        

        function formatDate(value) {
            return value.getMonth() + 1 + "/" + value.getDate() + "/" + value.getYear();
        }

        function requestReport() {
            var data = $getContainerData("filtersContainer");
            //var products = [];
            //var filteredValues = [];
            ////get all possible combos of three products
            //var combos = combine([1, 2, 3]);

            //if (data["Products_Discussed_ID"]) {
            //    var prodIds = data["Products_Discussed_ID"].value;
            //    //find all combos that contain product ids
            //    for (var i = 0; i < combos.length; i++) {
            //        for (var k = 0; k < prodIds.length; k++) {
            //            if ($.inArray(parseInt(prodIds[k]), combos[i]) != -1) {
            //                //only add unique values
            //                if(!(combos[i] in filteredValues))
            //                filteredValues.push(combos[i]);
            //            }
            //        }
            //    }

            //    //join filtered Values arrays via ' ', as per database column
            //    for (var j = 0; j < filteredValues.length; j++) {
            //        products[j] = filteredValues[j].join(' ')
            //    }
            //} else {
            //    //create new data param since it doesnt exist
            //    data["Products_Discussed_ID"] = new Pathfinder.UI.dataParam("Products_Discussed_ID", "", "System.String", "");
            //    for (var j = 0; j < combos.length; j++) {
            //        products[j] = combos[j].join(' ')
            //    }
            //}

            //data["Products_Discussed_ID"].dataType = "System.String";
            //data['Products_Discussed_ID'].value = products;
            //// var test = $('#searchListSelectionPlan_Name_DATA').val();
            if ($get('Plan_ID') && $('#Plan_ID_DATA').val() != "")
                data["Plan_ID"] = $('#Plan_ID_DATA').val().split(',');
            else
                delete data["Plan_ID"];

            if ($validateContainerData("filtersContainer", data, '<%= Resources.Resource.Label_Report_Filters %>')) {
                data["__options"] = $getContainerData("optionsContainer");
                clientManager.set_SelectionData(data);
            }
        }

        //var combine = function (a) {
        //    var fn = function (n, src, got, all) {
        //        if (n == 0) {
        //            if (got.length > 0) {
        //                all[all.length] = got;
        //            }
        //            return;
        //        }
        //        for (var j = 0; j < src.length; j++) {
        //            fn(n - 1, src.slice(j + 1), got.concat([src[j]]), all);
        //        }
        //        return;
        //    }
        //    var all = [];
        //    for (var i = 0; i < a.length; i++) {
        //        fn(i, a, [], all);
        //    }
        //    all.push(a);
        //    return all;
        //}

       
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

        function sectionDropDownClosed(s, a) {
            var data = $getContainerData("filtersContainer");
            refreshPlanList(data);
        }

        function refreshPlanList(data) {
            var PlanID = $get('Plan_ID');

            if (PlanID != null) {
                if (!PlanID && !PlanID.control) return;
            }

            clearPlanSelectionList();
            var section = data["Section_ID"];

            if (section && section.get_value()) {
                var filtersection = '';
                if ($.isArray(section.value)) {
                    //reset section selection if PBM is selected with other sections. PBM should be selected seperately, it can't be selected with other sections
                    $.each(section.get_value(), function (k, o) {
                        if (filtersection == '') filtersection = "(Section_ID eq " + o;
                        else filtersection = filtersection + " or Section_ID eq " + o;
                    });
                }
                else {
                    filtersection = "(Section_ID eq " + section.get_value();
                }

                var planlist = $('.searchTextBoxFilter #Plan_ID')[0];
                if (planlist && planlist.SearchList) {
                    planlist = planlist.SearchList;
                    filtersection += " ) and substringof('{0}',Plan_Name)&$top=50&$orderby=Plan_Name";

                    planlist.set_queryFormat("$filter=" + filtersection);
                    planlist.set_queryValues();
                }
            }
                //All Sections
            else {
                var planlist = $('.searchTextBoxFilter #Plan_ID')[0];
                if (planlist && planlist.SearchList) {
                    planlist = planlist.SearchList;
                    filtersection = "substringof('{0}',Plan_Name)&$top=50&$orderby=Plan_Name";
                    planlist.set_queryFormat("$filter=" + filtersection);
                    planlist.set_queryValues();
                }
            }
        }

        function clearPlanSelectionList() {
            var planlist = $('.searchTextBoxFilter #Plan_ID')[0];
            if (planlist && planlist.SearchList) {
                planlist = planlist.SearchList;
                planlist.clearSearchListSelection();
            }
        }
                
    </script>