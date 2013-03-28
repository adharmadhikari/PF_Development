using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Impact.Campaign;
using Impact.Utility;
using System.Net.Mail;

public partial class email_campaign_team : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
              
    }

    /// <summary>
    /// Used to send emails to the campaign team members with information about the meeting request
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    
    protected void EmailTeam(object sender, EventArgs e)
    {
        //string strToMailAddress = Utility.GetAdminEmail();
        string strToMailAddress = ((TextBox)frmGetEmailAddresses.FindControl("txtEmail")).Text;
        strToMailAddress = strToMailAddress.Replace(";",",");
        string strCCMailAddress = ((TextBox)frmGetEmailAddresses.FindControl("txtCC")).Text;
        strCCMailAddress = strCCMailAddress.Replace(";",",");
        string strFromEmailAddress = Utility.GetUserEmail((int)Session["pinsoUserID"]);

        string strSubject = ((Label)frmCampaignMeeting.FindControl("lblSubject")).Text;
        string strMeetingDate = ((TextBox)frmCampaignMeeting.FindControl("txtMeetingDate")).Text;
        string strMeetingTime = ((TextBox)frmCampaignMeeting.FindControl("txtMeetingTime")).Text;
        string strMeetingLocation = ((TextBox)frmCampaignMeeting.FindControl("txtMeetingLocation")).Text;
        string strDialInNumber = ((TextBox)frmCampaignMeeting.FindControl("txtDialInNumber")).Text;
        string strParticipantCode = ((TextBox)frmCampaignMeeting.FindControl("txtParticipantCode")).Text;
        string strMeetingAgendaList = ((BulletedList)frmCampaignMeeting.FindControl("meetingAgendaList")).Items.ToString();
        string strCampaignName = ((Label)frmCampaignMeetingEmail.FindControl("lblCampaignName")).Text;
        string strWebsite = "http://training.powerplanrx.com/contents/dsp_campaign_info.asp?qCampaignId=" + Request.QueryString["id"].ToString();
        
        string strEmailSubject = Resources.Resource.EmailSubject_MeetingRequest + " " + strSubject;
        string strEmailBody = "Meeting Date: " + strMeetingDate;
        strEmailBody = strEmailBody + System.Environment.NewLine + "Meeting Time: " + strMeetingTime;
        strEmailBody = strEmailBody + System.Environment.NewLine + "Meeting Location: " + strMeetingLocation;
        strEmailBody = strEmailBody + System.Environment.NewLine + "Dial In Number: " + strDialInNumber;
        strEmailBody = strEmailBody + System.Environment.NewLine + "Participant Code: " + strParticipantCode + System.Environment.NewLine;

        strEmailBody = strEmailBody + System.Environment.NewLine + Resources.Resource.EMailBody_MeetingRequest;
        strEmailBody = strEmailBody + " " + strCampaignName + "." + System.Environment.NewLine;
        strEmailBody = strEmailBody + Resources.Resource.EMailBody_MeetingRequest2 + System.Environment.NewLine;

        //strEmailBody = strEmailBody + System.Environment.NewLine + strMeetingAgendaList + System.Environment.NewLine;
        strEmailBody = strEmailBody + System.Environment.NewLine + "1) Review the market opportunity and rationale for this campaign";
        strEmailBody = strEmailBody + System.Environment.NewLine + "2) Review key information about the Health Plan";
        strEmailBody = strEmailBody + System.Environment.NewLine + "3) Review the Campaign Timeline to understand key dates and milestones";
        strEmailBody = strEmailBody + System.Environment.NewLine + "4) Define the share and volume goals to be achieved";
        strEmailBody = strEmailBody + System.Environment.NewLine + "5) Define the tactics and messages that will be used to execute the campaign" + System.Environment.NewLine;

        strEmailBody = strEmailBody + System.Environment.NewLine + Resources.Resource.EMailBody_NextSteps + System.Environment.NewLine;

        strEmailBody = strEmailBody + System.Environment.NewLine + Resources.Resource.EMailBody_Review + strCampaignName + Resources.Resource.EMailBody_Review2 + System.Environment.NewLine;

        strEmailBody = strEmailBody + strWebsite + System.Environment.NewLine;

        strEmailBody = strEmailBody + System.Environment.NewLine + Resources.Resource.EMailSignature_MeetingRequest + System.Environment.NewLine;
        strEmailBody = strEmailBody + System.Environment.NewLine + Session["FirstName"].ToString();

        Utility.SendEMail(strToMailAddress, strCCMailAddress, strFromEmailAddress, strEmailSubject, strEmailBody, MailPriority.High);

        //Hide email controls and show status message
        pnlMessage.Visible = true;
        frmCampaignMeeting.Visible = false;
        frmCampaignMeetingEmail.Visible = false;
        frmGetEmailAddresses.Visible = false;
    }    
        
}
