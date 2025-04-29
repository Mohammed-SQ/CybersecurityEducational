using System;
using System.Web.UI;

namespace CybersecurityEducational
{
    public partial class Confirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Validate paymentId
                string paymentId = Request.QueryString["paymentId"];
                if (string.IsNullOrEmpty(paymentId))
                {
                    Session["ErrorMessage"] = "Invalid payment confirmation.";
                    Response.Redirect("index.aspx");
                }

                // Store the amount in session for display (since we don't query the DB here)
                if (Session["PaymentAmount"] == null)
                {
                    Session["PaymentAmount"] = "0.00";
                }
            }
        }
    }
}