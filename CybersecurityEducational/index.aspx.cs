using System;

namespace CybersecurityEducational
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Handle logout
                if (Request.QueryString["logout"] != null && Request.QueryString["logout"].ToString() == "true")
                {
                    Session.Abandon(); // Clear the session
                    Response.Redirect("index.aspx"); // Redirect to index.aspx
                }
            }
            catch (Exception ex)
            {
                // Store error message in session to display on the page
                Session["ErrorMessage"] = "An error occurred: " + ex.Message;
                Response.Redirect("index.aspx");
            }
        }
    }
}