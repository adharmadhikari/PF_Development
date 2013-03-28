/// <reference name="MicrosoftAjax.js"/>
/// <reference path="~/content/scripts/jquery-1.3.2-vsdoc.js"/>


		var windowHeight = $(window);
		var divHeight = windowHeight.height(); 
		var divWidth = windowHeight.width();


		$(document).ready(pageReady);
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(pageReady);
		
		function pageReady()
		{
		    $("#forgotPassword").dialog({ autoOpen: false, modal: true, width:600, title:"Forgot Password Request" });
		    
		    $("body").addClass("login");
		    $(".header").hide();
		    if($("form").attr("action") != "reauthenticate.aspx")
		        
		    $(".textBoxReadOnly").parent().parent().parent().addClass("readOnlyBox");

		    var userBox = $("#ctl00_main_Login1_UserName").attr("value");

		    if (userBox)
		    {
		        $("#ctl00_main_Login1_Password").focus();
		    } else
		    {
		        $("#ctl00_main_Login1_UserName").focus();
		    }
		    if (userBox)
		    {
		        $("#ctl00_main_Login1_LabelUserName").hide();
		    } else
		    {
		        $("#ctl00_main_Login1_LabelUserName").show();

		    }
		}

 function resetUserName()
 {
        $(".textBoxReadOnly").attr("readOnly", false).attr("class", "textBox userName").focus().select();
        $(".textBox").parent().parent().parent().removeClass("readOnlyBox");
        $("#ctl00_main_Login1_UserName").attr("value", "");
        $("#ctl00_main_Login1_UserName").focus();
        $("#ctl00_main_Login1_LabelUserName").show();

 }
 

 function forgotPassword()
 {
     $("#forgotPasswordSubmit").show();
     $("#forgotPasswordStatus").hide();
     $("#forgotPassword").dialog('open');
 }

 function submitEmail()
 {
     $("#forgotPasswordStatus").text("Submitting request...").show();
     PageMethods.SubmitEmail($get("txtEmail").value
            , function(r) { if (r) $("#forgotPasswordSubmit").hide(); $("#forgotPasswordStatus").text(r ? "Request submitted successfully." : "Request failed: Please verify the email address you entered is valid."); }
            , function() { $("#forgotPasswordSubmit").hide(); $("#forgotPasswordStatus").text("Request failed: Please try again later."); });
     return false;
 }

 Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(initializeRequest);
 function initializeRequest(o, a)
 {
     $("#spanProgress").show();
 }

 Sys.Net.WebRequestManager.add_completedRequest(completeRequest);
 function completeRequest(o, a)
 {
     $("#spanProgress").hide();
 }    