using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;
using PathfinderModel;
using Pinsonault.Application.UnitedThera;
using Pinsonault.Web;

public partial class custom_pinso_customercontactreports_all_AddEditCCReports : PageBase
{
    protected void Page_Init(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            setComboValues();
            loadContacts();
            this.formViewRCR.Visible = true;
        }
        if (Request.QueryString["LinkClicked"] == "AddIR")
        {
            this.formViewRCR.ChangeMode(FormViewMode.Insert);    
        }

       // dsProductsDiscussed.ConnectionString = Pinsonault.Web.Session.ClientConnectionString;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {          
            this.Msglbl.Visible = false;
            Page.ClientScript.RegisterStartupScript(typeof(Page), "Update", "UpdChkSelection();", true);                   
            //Print.Visible = Request.QueryString["LinkClicked"].Equals("EditIR");
            titleText.Text = String.Format("{0} Issue - {1}", Request.QueryString["LinkClicked"].Replace("IR", ""), Request.QueryString["PlanName"]);           
        }
    }

    //this method is called to reset the form to original values
    protected void resetFormView(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(typeof(Page), "Update", "UpdChkSelection();", true);
        setComboValues();
        loadContacts();
        this.formViewRCR.DataBind();
    }
    protected void setComboValues()
    {
        // Sets hidden field values for Products Discussed, so it can be updated via Javascirpt
        string strCallreportId = System.Web.HttpContext.Current.Request.QueryString["IRID"];
        string strPlanID = System.Web.HttpContext.Current.Request.QueryString["PlanID"];
        int planID = Convert.ToInt32(strPlanID);
        int RC_Report_ID = 0;


        if (strCallreportId != null && strCallreportId != "")
        {
            RC_Report_ID = System.Convert.ToInt32(strCallreportId);
        }
        if (RC_Report_ID != 0)
        {
            using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
            {

                //Get Products Discussed Values
                var ssPrdsDiscuss = (from d in context.RCReportProductsDiscussedSet
                                     where d.RC_Report_ID == RC_Report_ID
                                     select d).ToList().Select(d => string.Format("{0}", d.Products_Discussed_ID.ToString()));
                //Comma separate individual record's data.
                hdnPrdsDisccused.Value = string.Join(",", ssPrdsDiscuss.ToArray());             
            }
        }
        else 
        { 
            hdnPrdsDisccused.Value = "";            
            hdnIssues.Value = "";
        }
    }

    protected void loadContacts()
    {
        //this function loads contacts into hdnContacts field
        string reportId = System.Web.HttpContext.Current.Request.QueryString["IRID"];
        int RC_Report_ID = 0;
        hdnContacts.Value = "";

        if (reportId != null && reportId != "")
        {
            RC_Report_ID = System.Convert.ToInt32(reportId);
        }
        if (RC_Report_ID != 0)
        {
            using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
            {
                var ssContacts =     (from d in context.RCReportContactsSet
                                     where d.RC_Report_ID == RC_Report_ID
                                     select d).ToList();
                
                string[] contactList = new string[ssContacts.Count];
                //add contacts to hidden field
                for(int i = 0; i < ssContacts.Count; i++)
                {
                    contactList[i] = ssContacts[i].Name + "|" + ssContacts[i].Title + "|" + ssContacts[i].Phone;
                }

                //save all values in hidden field
                hdnContacts.Value = string.Join(",", contactList);
            }
        }
    }

    protected void ProcessRequest(string BtnClicked)
    {      
        Page.ClientScript.RegisterStartupScript(typeof(Page), "Update", "UpdChkSelection();", true);
        //Create a new Reimbursement Issue Report if Contact_Report_ID is null in Query String else retrieve the the Contact Report
        string msg = "";
        string strCallreportId = System.Web.HttpContext.Current.Request.QueryString["IRID"];
        int RC_Report_ID = 0;
        if (strCallreportId != null && strCallreportId != "")
        {
            RC_Report_ID = System.Convert.ToInt32(strCallreportId);
        }
        
        using (PathfinderUnitedTheraEntities context = new PathfinderUnitedTheraEntities())
        {
            RCReports rcrView;
            if (RC_Report_ID != 0)
            {
                //      Retrive Issue Report with RC_Report_ID
                rcrView = context.RCReportsSet.FirstOrDefault(c => c.RC_Report_ID == RC_Report_ID);
                msg = "<br/><b>Reimbursement Issue Report has been updated successfully.</b><br/><br/>";
                rcrView.Contact_Date = Convert.ToDateTime(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdRCRDate"))).Text);

                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdFollowUpDate"))).Text))
                    rcrView.Followup_Date = Convert.ToDateTime(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdFollowUpDate"))).Text);
                else
                    rcrView.Followup_Date = null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlNAM"))).SelectedValue))
                    rcrView.NAM_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlNAM"))).SelectedValue);
                else
                    rcrView.NAM_ID = null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlStatus"))).SelectedValue))
                    rcrView.Status_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlStatus"))).SelectedValue);
                else
                    rcrView.Status_ID = null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlIssues"))).SelectedValue))
                    rcrView.Issue_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlIssues"))).SelectedValue);
                else
                    rcrView.Issue_ID = null;

                //if there is an Other_Issue not listed
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdOther_Issue"))).Text))
                    rcrView.Other_Issue = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdOther_Issue"))).Text);
                else
                    rcrView.Other_Issue = null;

                //Team Comments
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrTeamComments"))).Text))
                    rcrView.Team_Comments = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrTeamComments"))).Text);
                else
                    rcrView.Team_Comments = null;

                //ASSIST Description
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrDesc"))).Text))
                    rcrView.ASSIST_Desc = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrDesc"))).Text);
                else
                    rcrView.ASSIST_Desc = null;
               
               
               rcrView.User_ID = Pinsonault.Web.Session.UserID;
               rcrView.Client_ID = Pinsonault.Web.Session.ClientID;
               rcrView.Modified_DT = DateTime.UtcNow;
               rcrView.Modified_BY = Pinsonault.Web.Session.FullName;
             }
            else
            {
                //Create a new Reimbursement Issue Report
                rcrView = new RCReports();
                rcrView.Plan_ID = System.Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["PlanID"]);
                rcrView.Created_DT = DateTime.UtcNow;
                rcrView.Created_BY = Pinsonault.Web.Session.FullName;
                msg = "<br/><b>Reimbursement Issue Report has been added successfully.</b><br/><br/>";

                rcrView.Contact_Date = Convert.ToDateTime(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdRCRDate"))).Text);
                
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdFollowUpDate"))).Text))
                    rcrView.Followup_Date = Convert.ToDateTime(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdFollowUpDate"))).Text);
                else
                    rcrView.Followup_Date = null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlNAM"))).SelectedValue))
                    rcrView.NAM_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlNAM"))).SelectedValue);
                else
                    rcrView.NAM_ID= null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlStatus"))).SelectedValue))
                    rcrView.Status_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlStatus"))).SelectedValue);
                else
                    rcrView.Status_ID = null;

                if (!string.IsNullOrEmpty(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlIssues"))).SelectedValue))
                    rcrView.Issue_ID = Convert.ToInt32(((Telerik.Web.UI.RadComboBox)(this.formViewRCR.FindControl("rdlIssues"))).SelectedValue);
                else
                    rcrView.Issue_ID = null;

                //if there is an Other_Issue not listed
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdOther_Issue"))).Text))
                    rcrView.Other_Issue = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rdOther_Issue"))).Text);
                else
                    rcrView.Other_Issue = null;

                //Team Comments
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrTeamComments"))).Text))
                    rcrView.Team_Comments = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrTeamComments"))).Text);
                else
                    rcrView.Team_Comments = null;

                //ASSIST Description
                if (!string.IsNullOrEmpty(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrDesc"))).Text))
                    rcrView.ASSIST_Desc = Convert.ToString(((System.Web.UI.WebControls.TextBox)(this.formViewRCR.FindControl("rcrDesc"))).Text);
                else
                    rcrView.ASSIST_Desc = null;

                rcrView.User_ID = Pinsonault.Web.Session.UserID;
                rcrView.Client_ID = Pinsonault.Web.Session.ClientID;
                rcrView.Modified_DT = DateTime.UtcNow;
                rcrView.Modified_BY = Pinsonault.Web.Session.FullName;
                rcrView.Report_Status = true;
                context.AddToRCReportsSet(rcrView);

            }

            context.SaveChanges();
            // There can be multiple Products Discussed and Issues for any Report

            // get the Products_Discussed_IDs From The Issue_Report_Products_Discussed Table 
            var ssPrdsDiscuss = from d in context.RCReportProductsDiscussedSet
                                where d.RC_Report_ID == rcrView.RC_Report_ID
                                select d;
            //delete everytime all the products discussed id's in Issue_Report_Products_Discussed for a particular RC_Report_ID
            //so that if a user changes selection of products any no of times the changes always reflect the latest selection in the database
            foreach (var plan in ssPrdsDiscuss) context.DeleteObject(plan);

            var ssContacts = from k in context.RCReportContactsSet
                           where k.RC_Report_ID == rcrView.RC_Report_ID
                           select k;
            //delete the existing contacts
            foreach (var plan in ssContacts) context.DeleteObject(plan);
            context.SaveChanges();

            //Add Contacts
            if (!String.IsNullOrEmpty(hdnContacts.Value.ToString()))
            {
                    //Split the data by comma 
                    string[] contacts = hdnContacts.Value.ToString().Split(new Char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 0; i < contacts.Length;i++)
                    {
                        string[] contact = contacts[i].Split(new Char[] { '|' });
                        int contactID = i;
                        RCReportContacts rcrContact = new RCReportContacts();
                        rcrContact.RC_Report_ID = rcrView.RC_Report_ID;
                        rcrContact.Contact_ID = Convert.ToInt32(contactID);
                        rcrContact.Name = contact[0]; //Name
                        rcrContact.Title = contact[1]; //Title
                        rcrContact.Phone = contact[2]; //Phone
                        context.AddToRCReportContactsSet(rcrContact);
                    }
               // context.SaveChanges();
            }
            
            //add Products Discussed
            if (!String.IsNullOrEmpty(hdnPrdsDisccused.Value.ToString()))
            {
                if (hdnPrdsDisccused.Value.ToString().IndexOf(",") > 0)
               {
                    //Split the data by comma 
                    string[] proDisids = hdnPrdsDisccused.Value.ToString().Split(new Char[] { ',' });
                    foreach (string ids in proDisids)
                    {
                        int proID = Convert.ToInt32(ids);
                        RCReportProductsDiscussed rcrPD = new RCReportProductsDiscussed();
                        rcrPD.RC_Report_ID = rcrView.RC_Report_ID;
                        rcrPD.Products_Discussed_ID = Convert.ToInt32(proID);
                        context.AddToRCReportProductsDiscussedSet(rcrPD);
                    }

               }
                else
               {
                    string proDisid = hdnPrdsDisccused.Value.ToString();
                    RCReportProductsDiscussed rcrPD = new RCReportProductsDiscussed();
                    rcrPD.RC_Report_ID = rcrView.RC_Report_ID;
                    rcrPD.Products_Discussed_ID = Convert.ToInt32(proDisid);
                    context.AddToRCReportProductsDiscussedSet(rcrPD);
               }

               // context.SaveChanges();
           }           
            context.SaveChanges();
            // send email notifications
            string emailBody;
            bool test =((System.Web.UI.HtmlControls.HtmlInputCheckBox)(this.formViewRCR.FindControl("notifyAdmin"))).Checked;
            string emailCC = null;
            if (hdnNotifyAdmin.Value == "true")
            {
                emailCC = "bmulvihill@pinsonault.com, mbewalder@pinsonault.com";
            }
            else
            {
                emailCC = "";
            }
            string emailSubject;
            //update
            if (RC_Report_ID != 0)
            {
                emailSubject = "Reimbursement Challenge Report Updated";
                emailBody = "An update has been made to the reimbursement challenge report that was created on " + rcrView.Contact_Date + " for " + Request.QueryString["PlanName"];
                emailBody += "<br>To view details, change the report's status, or provide NAM Comments, please visit PathfinderRx.";
                }
            //new rc report
            else
            {
                emailSubject = "New Reimbursement Challenge Report Created";
                emailBody = "A reimbursement challenge report was created on " + rcrView.Contact_Date + " for " + Request.QueryString["PlanName"];
                emailBody += "<br>To view details, change the report's status, or provide NAM Comments, please visit PathfinderRx.";
            }
            bool emailSuccess = Pinsonault.Web.Support.SendEmail(Pinsonault.Web.Support.UserEmail, "bmulvihill@pinsonault.com, mbewalder@pinsonault.com", emailCC, emailSubject, emailBody, true, MailPriority.High);
           
        }

        //Calls Javascript function RefreshCCRs() to refresh CCR list parent grid.       
        Page.ClientScript.RegisterClientScriptBlock(typeof(Page), "RefreshCCRs", "RefreshCCRs();", true);
        this.Msglbl.Text = msg;
        this.Msglbl.Visible = true;
        formViewRCR.Visible = false;
    }


    protected void Addbtn_Click(object sender, EventArgs e)
    {
        ProcessRequest("Add");
    }

    protected void Editbtn_Click(object sender, EventArgs e)
    {
        ProcessRequest("Edit");
    }

}
