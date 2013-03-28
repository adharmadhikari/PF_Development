<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddEditRCRScript.ascx.cs" Inherits="custom_controls_AddEditCCRScript" %>
<script type="text/javascript">
    //global variables
    var contactData = [];
    var selectedContact = 0;
    var totalContacts = 0;

    $(document).ready(function() {
        if ('<%= Request.QueryString["LinkClicked"] %>' == "AddIR") {
            selectedContact = 1;
            totalContacts = 1; 
            pagination();
        }
        else {
            selectedContact = 1
            totalContacts = $("#ctl00_main_hdnContacts").val().split(",").length;
          
            //set variables based on data passed to hidden fields
            var contacts = $("#ctl00_main_hdnContacts").val().split(",");
            
            for(var i = 0; i < contacts.length; i++)
            {
                var contact = contacts[i].split("|");
                contactData[i + 1] = {
                    Name:  contact[0],
                    Title: contact[1],
                    Phone: contact[2]
                }
                //console.log(keyContactData[i + 1].Name);
                //console.log(keyContactData[i + 1].Title);
                //console.log(keyContactData[i + 1].Phone);
            }
            $('#ctl00_main_formViewRCR_rcrNameText').val(contactData[selectedContact].Name);
            $('#ctl00_main_formViewRCR_rcrTitleText').val(contactData[selectedContact].Title);
            $('#ctl00_main_formViewRCR_rcrPhoneText').val(contactData[selectedContact].Phone);
            pagination();       
        }
        
        //bind svae dat to keyup event so Data saves
        $('#ctl00_main_formViewRCR_rcrNameText, #ctl00_main_formViewRCR_rcrTitleText, #ctl00_main_formViewRCR_rcrPhoneText').keyup(function () {
            saveContactData();
        });

        $("#ctl00_main_formViewRCR_rdRCRDate").datepicker();
        $("#ctl00_main_formViewRCR_rdFollowUpDate").datepicker();
       
        $(".RadComboBox .rcbArrowCell A").height(21);

        //Fix IE drop down arrow issue with RadDropList/ItemTemplate
        if ($.browser.msie)
            new cmd(null, fixDropdowns, null, 500);

        //Fix multiple submit issue by disabling enter key
        //$("#AddCCRMain").keypress(function(e) {
        //    if (e.which == 13)
        //        return false;
        //});

        //hide other issue textbox and label
        $('.otherIssue').hide();
        $("#ctl00_main_formViewRCR_rdlIssue")
        //Disable use of up/down arrows to select items in checkbox dropdowns
        $("#ctl00_main_formViewRCR_rdlProductsDiscussed_Input").keydown(function(e) {
            if (e.which == 13 || e.which == 38 || e.which == 40)
                return false;
        });

        //Fix possible editing of radComboBox
        $("#ctl00_main_formViewRCR_rdlProductsDiscussed_Input").attr("readOnly", "readonly");    
    });

    function newIssueContact() {
        //maximum of 5 contacts
        if (totalContacts < 5) {
            //add new key contact to object
            saveContactData();
            //increment contact counters
            totalContacts += 1;
            selectedContact = totalContacts;
            $('#rcrSelectedContact').text(selectedContact);
            $('#rcrTotalContacts').text(totalContacts);
            $('#ctl00_main_formViewRCR_rcrNameText').val('');
            $('#ctl00_main_formViewRCR_rcrTitleText').val('');
            $('#ctl00_main_formViewRCR_rcrPhoneText').val(''); 
        } else {
            $('.contactValidation').html('Maximum of 5 contacts allowed');
        }
        pagination();
    }

    function saveContactData() {
        //save entered contact data
        contactData[selectedContact] = {
            Name: $('#ctl00_main_formViewRCR_rcrNameText').val(),
            Title: $('#ctl00_main_formViewRCR_rcrTitleText').val(),
            Phone: $('#ctl00_main_formViewRCR_rcrPhoneText').val(),
        }
        //console.log('contact added at index: ' + selectedContact);
        //console.log('current name: ' + contactData[selectedContact].Name);
        //console.log($('#ctl00_main_formViewRCR_rcrNameText').val());
        setHdnFields();
    }

    function setHdnFields() {
        var hdnContacts = $("#ctl00_main_hdnContacts");
        hdnContacts.val('');
        for (var i = 1; i < contactData.length; i++) {
            hdnContacts.val(hdnContacts.val() + contactData[i].Name + '|' + contactData[i].Title + '|' + contactData[i].Phone + ',');
        }
    }

    function prevContact() {
        saveContactData();
        if (selectedContact > 1) {
            selectedContact -= 1;
            $('#ctl00_main_formViewRCR_rcrNameText').val(contactData[selectedContact].Name);
            $('#ctl00_main_formViewRCR_rcrTitleText').val(contactData[selectedContact].Title);
            $('#ctl00_main_formViewRCR_rcrPhoneText').val(contactData[selectedContact].Phone);
        }
        pagination();
    }

    function nextContact() {
        saveContactData(); 
        if (selectedContact + 1 <= totalContacts) {
            selectedContact += 1;
            $('#ctl00_main_formViewRCR_rcrNameText').val(contactData[selectedContact].Name);
            $('#ctl00_main_formViewRCR_rcrTitleText').val(contactData[selectedContact].Title);
            $('#ctl00_main_formViewRCR_rcrPhoneText').val(contactData[selectedContact].Phone);
        } 
        pagination();
    }

    function pagination() {
        $('#rcrSelectedContact').text(selectedContact);
        $('#rcrTotalContacts').text(totalContacts);

        if (selectedContact == 1 && totalContacts == 1) {
            $('.pagerPrev').addClass('grey');
            $('.pagerNext').addClass('grey');
        }
        else if (selectedContact == 1 && totalContacts > 1) {
            $('.pagerPrev').addClass('grey');
            $('.pagerNext').removeClass('grey');
        }
        else if (selectedContact == totalContacts) {
            $('.pagerPrev').removeClass('grey');
            $('.pagerNext').addClass('grey');
        }
        else {
            $('.pagerNext').removeClass('grey');
            $('.pagerPrev').removeClass('grey');
        } 
    }

    function fixDropdowns()
    {
        $("#ctl00_main_formViewRCR_rdlProductsDiscussed table").width($("#ctl00_main_formViewCCR_rdlProductsDiscussed table").width() - 2);
        $("#ctl00_main_formViewRCR_rdlProductsDiscussed ").width($("#ctl00_main_formViewRCR_rdlProductsDiscussed ").width() - 1);
    }
    
    function ClearForm()
    {
        //Reset the form values.
        document.forms[0].reset();

        $("#ctl00_main_hdnPrdsDisccused").val('');
        $("#ctl00_main_hdnContacts").val('');

        //reset contacts
        contactData = [];
        selectedContact = 1;
        totalContacts = 1;
        pagination();

        $("#spanProducts ul").html('');

        if ($.browser.msie && $.browser.version < 7)
        {
            $("#aspnetForm input[type=checkbox]").removeAttr("defaultChecked");
            $("#aspnetForm input[type=checkbox]").removeAttr("checked");
            $("#aspnetForm input[type=checkbox]").attr("defaultChecked", false);
            $("#aspnetForm input[type=checkbox]").attr("checked", false);
        }

        $("#AddRCRMain input[type != submit]").val("");
    }

    function UpdChkSelection() 
    {
        var hdnPrdsDisc = $("#ctl00_main_hdnPrdsDisccused");

        $("#ctl00_main_formViewRCR_rdlProductsDiscussed input[type=checkbox]").removeAttr("checked");
        var str = hdnPrdsDisc.val();
        var t ="<ul>";
        if (str) 
        {
            var a = str.split(",");
            
            for (var i = 0; i < a.length; i++)
            {
                $("#ctl00_main_formViewRCR_rdlProductsDiscussed #p" + a[i] + " input").attr("checked", true);

                if ($.browser.msie && $.browser.version < 7)
                    $("#ctl00_main_formViewRCR_rdlProductsDiscussed #p" + a[i] + " input").attr("defaultChecked", "defaultChecked");
                     
                t = t + "<li id=pp" + a[i] + ">" + $("#p" + a[i] + " label").text() + "</li>";
            }
            
            t = t + "</ul>"
            $("#spanProducts").append(t);            
        }
       
    }

    function ProdsDiscussChanged(sender, ProdDisID) 
    {
        var tree_ul = $('#spanProducts ul').children();            
        var t = "";

        if (sender.checked == false) 
        {
            if (tree_ul) 
            {
                var b = "p" + ProdDisID;
                $("#p" + b).remove();
            }
        }
        if (sender.checked == true) 
        {
            if ($('#spanProducts > ul').size() > 0) 
            {
                t = t + "<li id=pp" + ProdDisID + ">" + $("#p" + ProdDisID + " label").text() + "</li>";
                $("#spanProducts ul").append(t);
            }
            else 
            {
                t = "<ul>" + "<li id=pp" + ProdDisID + ">" + $("#p" + ProdDisID + " label").text() + "</li></ul>";
                $("#spanProducts").append(t);
            }
        }

        var strPlans = "";
        var a = [];
        var hdnPrdsDisc = $("#ctl00_main_hdnPrdsDisccused");
        var IDs = ProdDisID;

        if (window.event)
            window.event.cancelBubble = true;

        //Get currently selected list of PoductsDiscussedIDs.
        if (hdnPrdsDisc.length > 0)
            strPlans = hdnPrdsDisc.val();

        //Get list of selected ProductsDiscussedIDs in an array.
        if (strPlans != "")
            a = strPlans.split(",");

        //Remove the current IDs(ProductDiscussedID) from the array.
        a = $.grep(a, function(i) { return i != IDs; }, false);

        //If checkbox is checked and the array length is less than 10 then add the selected ProductsDiscussedIDs to the list
        //Please note that the current plan selection allows maximum of 10 selected plans.
        if (sender.checked) 
        {
            if (a.length < 10) 
                a[a.length] = IDs;
            else 
            {
                sender.checked = false;
                $alert("A maximum of 10 Drugs can be selected.", "Products Discussed");
            }
        }

        strPlans = a.join(",");
        hdnPrdsDisc.val(strPlans);
    }
    
    function setProdDiscussedText(sender, args)
    {
        setTimeout(function () {
            var hdnPrdsDisc = $("#ctl00_main_hdnPrdsDisccused");
            var strPlans = "";

            //Get currently selected list of ProductsDiscussedIDs.
            if (hdnPrdsDisc.length > 0)
                strPlans = hdnPrdsDisc.val();

            //If list is not empty then update product dropdown message to 'Change Selection' else '-Select Products Discussed-'.
            if (strPlans != "")
                sender.set_text("-Change Selection-");
            else
                sender.set_text("-Select Products Discussed-");
        }, 500);
    }

    function issueChanged(sender, eventArgs) {
        if (sender.get_text() == 'Other') {
            $('.otherIssue').show();
        } else {
            $('.otherIssue').hide();
        }
    }

//for disabling other text
    function disableOtherText(id, disabled)
    {
        if (disabled)
            $("#" + id).attr("readonly", true).val("");
        else
            $("#" + id).attr("readonly", false);
    }    
   
</script>
