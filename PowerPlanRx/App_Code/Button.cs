using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Impact
{
    /// <summary>
    /// Summary description for Button
    /// </summary>
    public class CustomButton : Button
    {
        public CustomButton()
        {
        }

        public override void RenderBeginTag(HtmlTextWriter writer)
        {
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "coreBtn");
            writer.RenderBeginTag(HtmlTextWriterTag.Span);
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "bg");
            writer.RenderBeginTag(HtmlTextWriterTag.Span);
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "bg2");
            writer.RenderBeginTag(HtmlTextWriterTag.Span);
            
            base.RenderBeginTag(writer);
        }

        public override void RenderEndTag(HtmlTextWriter writer)
        {

            
            base.RenderEndTag(writer);
            
            writer.RenderEndTag();
            writer.RenderEndTag();
            writer.RenderEndTag();
        }
    }
}