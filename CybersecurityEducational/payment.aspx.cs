using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Configuration;
using System.Web.UI.WebControls;

namespace CybersecurityEducational
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null || Session["UserId"] == null)
                {
                    Session["ErrorMessage"] = "Please log in to proceed with payment.";
                    Response.Redirect("account.aspx");
                    return;
                }

                Debug.WriteLine("Session UserId: " + Session["UserId"]);

                string plan = Request.QueryString["plan"] != null ? Request.QueryString["plan"].ToLower() : null;
                if (string.IsNullOrEmpty(plan) || (plan != "free" && plan != "standard" && plan != "premium"))
                {
                    Session["ErrorMessage"] = "Invalid plan selected.";
                    Response.Redirect("index.aspx#pricing");
                    return;
                }
            }
            else
            {
                Response.Write("DEBUG: Page_Load - IS PostBack. Calling ProcessPayment().<br />");
                ProcessPayment(null, EventArgs.Empty);
                Response.Write("DEBUG: Page_Load - ProcessPayment() finished.<br />");
            }
        }

        protected void ProcessPayment(object sender, EventArgs e)
        {
            Response.Write("DEBUG: ProcessPayment() started.<br />");
            try
            {
                Response.Write("DEBUG: Form fields received:<br />");
                foreach (string key in Request.Form.AllKeys)
                {
                    Response.Write("  " + key + " = " + Server.HtmlEncode(Request.Form[key]) + "<br />");
                }

                string cardholderName = Request.Form["cardholderName"];
                string cardNumber = Request.Form["cardNumber"];
                string expiryDate = Request.Form["expiryDate"];
                string cvv = Request.Form["cvv"];
                string amountStr = Request.Form["amount"];

                Response.Write("DEBUG: ProcessPayment() - Retrieved form data.<br />");
                Response.Write("DEBUG: cardholderName = " + (cardholderName ?? "NULL") + "<br />");
                Response.Write("DEBUG: cardNumber = " + (cardNumber ?? "NULL") + "<br />");
                Response.Write("DEBUG: expiryDate = " + (expiryDate ?? "NULL") + "<br />");
                Response.Write("DEBUG: cvv = " + (cvv ?? "NULL") + "<br />");
                Response.Write("DEBUG: amountStr = " + (amountStr ?? "NULL") + "<br />");

                Debug.WriteLine("Received form data - CardholderName: " + cardholderName + ", CardNumber: " + cardNumber + ", ExpiryDate: " + expiryDate + ", CVV: " + cvv + ", Amount: " + amountStr);

                if (string.IsNullOrEmpty(cardholderName) || string.IsNullOrEmpty(cardNumber) || string.IsNullOrEmpty(expiryDate) || string.IsNullOrEmpty(cvv) || string.IsNullOrEmpty(amountStr))
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Missing fields. Redirecting.<br />");
                    Session["ErrorMessage"] = "All payment fields are required.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                string[] expiryParts = expiryDate.Split(new char[] { '/' });
                int expiryMonth;
                int expiryYear;
                if (expiryParts.Length != 2 || !int.TryParse(expiryParts[0], out expiryMonth) || !int.TryParse(expiryParts[1], out expiryYear))
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Invalid expiry date format. Redirecting.<br />");
                    Session["ErrorMessage"] = "Invalid expiry date format (MM/YY).";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                if (expiryMonth < 1 || expiryMonth > 12)
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Invalid expiry month. Redirecting.<br />");
                    Session["ErrorMessage"] = "Expiry month must be between 1 and 12.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                if (cardholderName.Length > 200)
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Cardholder name too long. Redirecting.<br />");
                    Session["ErrorMessage"] = "Cardholder name must not exceed 200 characters.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                if (cardNumber.Length > 40)
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Card number too long. Redirecting.<br />");
                    Session["ErrorMessage"] = "Card number must not exceed 40 characters.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                if (cvv.Length != 3)
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Invalid CVV length. Redirecting.<br />");
                    Session["ErrorMessage"] = "CVV must be exactly 3 digits.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                decimal amount;
                if (!decimal.TryParse(amountStr, out amount))
                {
                    Response.Write("DEBUG: ProcessPayment() - Validation failed: Invalid amount. Redirecting.<br />");
                    Session["ErrorMessage"] = "Invalid payment amount.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                Response.Write("DEBUG: ProcessPayment() - Basic validations passed.<br />");

                string plan = Request.QueryString["plan"] != null ? Request.QueryString["plan"].ToLower() : "free";

                string newRole;
                switch (plan)
                {
                    case "free":
                        newRole = "Novice";
                        break;
                    case "standard":
                        newRole = "Pro";
                        break;
                    case "premium":
                        newRole = "Elite";
                        break;
                    default:
                        newRole = "Novice";
                        break;
                }

                string connectionString;
                try
                {
                    connectionString = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;
                    if (string.IsNullOrEmpty(connectionString))
                    {
                        throw new Exception("Connection string 'CyberDB' is empty or not configured.");
                    }
                    Response.Write("DEBUG: ProcessPayment() - Connection string retrieved.<br />");
                }
                catch (Exception ex)
                {
                    Response.Write("DEBUG: ProcessPayment() - Connection string error. Redirecting.<br />");
                    Debug.WriteLine("Connection string error: " + ex.Message);
                    Session["ErrorMessage"] = "Database configuration error. Please contact support.";
                    Response.Redirect("payment.aspx?plan=" + Request.QueryString["plan"]);
                    return;
                }

                int userId;
                if (Session["UserId"] == null || !int.TryParse(Session["UserId"].ToString(), out userId))
                {
                    Response.Write("DEBUG: ProcessPayment() - Invalid UserId in session. Redirecting to account.<br />");
                    Session["ErrorMessage"] = "Invalid user ID in session.";
                    Response.Redirect("account.aspx");
                    return;
                }
                Response.Write("DEBUG: ProcessPayment() - UserId validated: " + userId + ".<br />");
                Debug.WriteLine("UserId from session: " + userId);

                bool userExists = false;
                try
                {
                    using (SqlConnection connCheck = new SqlConnection(connectionString))
                    {
                        connCheck.Open();
                        string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE UserId = @UserId";
                        using (SqlCommand cmdCheck = new SqlCommand(checkUserQuery, connCheck))
                        {
                            cmdCheck.Parameters.AddWithValue("@UserId", userId);
                            int userCount = (int)cmdCheck.ExecuteScalar();
                            userExists = (userCount > 0);
                        }
                    }

                    if (!userExists)
                    {
                        Response.Write("DEBUG: ProcessPayment() - User ID " + userId + " does not exist. Redirecting to account.<br />");
                        Debug.WriteLine("User with ID " + userId + " does not exist in the database.");
                        Session["ErrorMessage"] = "User account not found. Please log in again.";
                        Response.Redirect("account.aspx");
                        return;
                    }
                    Response.Write("DEBUG: ProcessPayment() - User ID " + userId + " confirmed to exist.<br />");
                }
                catch (Exception ex)
                {
                    Response.Write("DEBUG: ProcessPayment() - Error checking user existence: " + ex.Message + ". Continuing to transaction.<br />");
                    Debug.WriteLine("Error checking user existence: " + ex.Message);
                }

                Response.Write("DEBUG: ProcessPayment() - Attempting database transaction.<br />");
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    Response.Write("DEBUG: ProcessPayment() - Database connection opened.<br />");

                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        Response.Write("DEBUG: ProcessPayment() - Transaction started.<br />");
                        try
                        {
                            string insertQuery = @"
                                INSERT INTO Payments (UserId, CardHolderName, CardNumber, ExpiryMonth, ExpiryYear, CVV, Amount, CreatedAt)
                                OUTPUT INSERTED.PaymentId
                                VALUES (@UserId, @CardHolderName, @CardNumber, @ExpiryMonth, @ExpiryYear, @CVV, @Amount, GETDATE())";

                            Response.Write("DEBUG: ProcessPayment() - Preparing INSERT query.<br />");
                            int paymentId;
                            using (SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@UserId", userId);
                                cmd.Parameters.AddWithValue("@CardHolderName", cardholderName);
                                cmd.Parameters.AddWithValue("@CardNumber", cardNumber);
                                cmd.Parameters.AddWithValue("@ExpiryMonth", expiryMonth);
                                cmd.Parameters.AddWithValue("@ExpiryYear", expiryYear);
                                cmd.Parameters.AddWithValue("@CVV", cvv);
                                cmd.Parameters.AddWithValue("@Amount", amount);

                                Debug.WriteLine("Executing query: " + insertQuery);
                                Debug.WriteLine("Parameters - UserId: " + userId + ", CardHolderName: " + cardholderName + ", CardNumber: " + cardNumber + ", ExpiryMonth: " + expiryMonth + ", ExpiryYear: " + expiryYear + ", CVV: " + cvv + ", Amount: " + amount);

                                Response.Write("DEBUG: ProcessPayment() - Executing INSERT query.<br />");
                                paymentId = (int)cmd.ExecuteScalar();
                                Response.Write("DEBUG: ProcessPayment() - INSERT query executed. PaymentId: " + paymentId + ".<br />");
                                if (paymentId <= 0)
                                {
                                    throw new Exception("Payment record insertion failed (invalid PaymentId).");
                                }
                            }

                            string updateQuery = @"
                                UPDATE Users
                                SET Role = @Role
                                WHERE UserId = @UserId";

                            Response.Write("DEBUG: ProcessPayment() - Preparing UPDATE query.<br />");
                            using (SqlCommand cmd = new SqlCommand(updateQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@Role", newRole);
                                cmd.Parameters.AddWithValue("@UserId", userId);

                                Debug.WriteLine("Executing query: " + updateQuery);
                                Debug.WriteLine("Parameters - Role: " + newRole + ", UserId: " + userId);

                                Response.Write("DEBUG: ProcessPayment() - Executing UPDATE query.<br />");
                                int rowsAffectedUpdate = cmd.ExecuteNonQuery();
                                Response.Write("DEBUG: ProcessPayment() - UPDATE query executed. Rows affected: " + rowsAffectedUpdate + ".<br />");
                                if (rowsAffectedUpdate <= 0)
                                {
                                    throw new Exception("User role update failed. User ID may not exist.");
                                }
                            }

                            transaction.Commit();
                            Response.Write("DEBUG: ProcessPayment() - Transaction committed. Redirecting to confirmation.<br />");
                            Debug.WriteLine("Payment record inserted and user role updated successfully.");

                            Session["PaymentAmount"] = amount.ToString("F2");

                            Response.Redirect("confirmation.aspx?paymentId=" + paymentId);
                        }
                        catch (Exception ex)
                        {
                            Response.Write("DEBUG: ProcessPayment() - EXCEPTION in transaction block!<br />");
                            transaction.Rollback();
                            Debug.WriteLine("Transaction failed: " + ex.Message + "\nStack Trace: " + ex.StackTrace);

                            Response.Write("<div style=\"color:red; border:1px solid red; padding:10px; margin:20px;\">");
                            Response.Write("<h3>Payment Transaction Failed</h3>");
                            Response.Write("<p><strong>Error:</strong> " + Server.HtmlEncode(ex.Message) + "</p>");
                            Response.Write("<p><strong>Stack Trace:</strong><br />" + Server.HtmlEncode(ex.StackTrace).Replace("\n", "<br />") + "</p>");
                            Response.Write("<p><a href=\"payment.aspx?plan=" + Request.QueryString["plan"] + "\">Return to Payment Page</a></p>");
                            Response.Write("</div>");

                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("DEBUG: ProcessPayment() - EXCEPTION outside transaction block!<br />");
                Debug.WriteLine("Exception occurred: " + ex.Message + "\nStack Trace: " + ex.StackTrace);

                Response.Write("<div style=\"color:red; border:1px solid red; padding:10px; margin:20px;\">");
                Response.Write("<h3>Payment Processing Error</h3>");
                Response.Write("<p><strong>Error:</strong> " + Server.HtmlEncode(ex.Message) + "</p>");
                Response.Write("<p><strong>Stack Trace:</strong><br />" + Server.HtmlEncode(ex.StackTrace).Replace("\n", "<br />") + "</p>");
                Response.Write("<p><a href=\"payment.aspx?plan=" + Request.QueryString["plan"] + "\">Return to Payment Page</a></p>");
                Response.Write("</div>");

                Response.End();
            }
            Response.Write("DEBUG: ProcessPayment() finished normally (should have redirected or shown error).<br />");
        }
    }
}