using System;
using System.Web.UI;

namespace CybersecurityEducational
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle logout
            if (Request.QueryString["logout"] == "true")
            {
                Session["Username"] = null;
                Session["UserId"] = null;
                Response.Redirect("index.aspx");
            }
        }
    }
}