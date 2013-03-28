﻿<%@ WebHandler Language="C#" Class="OpenBusinessDocument" %>

using System;
using System.Web;
using PathfinderClientModel;
using Pinsonault.Application.UnitedThera;
using System.Linq;
using System.IO;
using System.Configuration;


public class OpenBusinessDocument : Pinsonault.Web.GenericHttpHandler
{
    
    protected override void InternalProcessRequest(HttpContext context)
    {
        string id = context.Request.QueryString["Document_ID"];
        if (!string.IsNullOrEmpty(id))
        {
            int docID = 0;
            if (Int32.TryParse(id, out docID))
            {
                using (PathfinderUnitedTheraEntities dataContext = new PathfinderUnitedTheraEntities())
                {
                    var query = from d in dataContext.RCReportPlanDocumentsSet
                                where d.Document_ID == docID
                                select d;

                    RCReportPlanDocuments document = query.FirstOrDefault();

                    if (document != null)
                    {
                        context.Response.Clear();

                        string ext = Path.GetExtension(document.Document_Original_File);

                        context.Response.ContentType = System.Net.Mime.MediaTypeNames.Application.Octet;
                        context.Response.AppendHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", document.Document_Original_File));
                        if (File.Exists(Path.Combine(Pinsonault.Web.Support.GetClientFolder("CCRDocuments"), Path.ChangeExtension(document.Document_ID.ToString(), ext))))
                        {
                            context.Response.WriteFile(Path.Combine(Pinsonault.Web.Support.GetClientFolder("CCRDocuments"), Path.ChangeExtension(document.Document_ID.ToString(), ext)));
                        }
                        else
                        {
                         //context.Response.Redirect("Error.aspx");
                            throw new HttpException(404, "file not found.");
                        }
                       
                    }
                }
            }
        }        
    }
    public override bool IsReusable
    {
        get {
            return false;
        }
    }

}