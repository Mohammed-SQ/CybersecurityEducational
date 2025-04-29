using System;
using System.Data.SqlClient; // Updated to use SqlClient
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace CybersecurityEducational
{
    public partial class Account : System.Web.UI.Page
    {
        private string connectionString;
        private int loginAttempts = 0;
        private const int MAX_LOGIN_ATTEMPTS = 3;

        protected void Page_Load(object sender, EventArgs e)
        {
            connectionString = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;

            // Handle logout
            if (Request.QueryString["logout"] == "true")
            {
                Session["Username"] = null;
                Session["UserId"] = null; // FIXED: Changed from Id to UserId
                Response.Redirect("account.aspx");
            }

            // Check if user is already logged in
            if (Session["Username"] != null)
            {
                LoginPanel.Visible = false;
                RegistrationPanel.Visible = false;
                ShowSuccess(RegistrationPanel, "Already Logged In", "You are already logged in, hop in to courses, or feel free to learn courses now.");
                ShowSuccess(LoginPanel, "Already Logged In", "You are already logged in, hop in to courses, or feel free to learn courses now.");
            }

            // Load login attempts from session
            if (Session["LoginAttempts"] != null)
            {
                loginAttempts = (int)Session["LoginAttempts"];
            }
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            // Server-side validation for registration fields
            if (string.IsNullOrWhiteSpace(regUsername.Text))
            {
                RegisterMessage.Text = "Username is required.";
                RegisterMessage.Visible = true;
                return;
            }

            if (!Regex.IsMatch(regUsername.Text, @"^[a-z]+$") || regUsername.Text.Length < 5 || regUsername.Text.Length > 20)
            {
                RegisterMessage.Text = "Username must be 5-20 lowercase letters only.";
                RegisterMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(regEmail.Text))
            {
                RegisterMessage.Text = "Email is required.";
                RegisterMessage.Visible = true;
                return;
            }

            if (!Regex.IsMatch(regEmail.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                RegisterMessage.Text = "Invalid email format.";
                RegisterMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(regPassword.Text))
            {
                RegisterMessage.Text = "Password is required.";
                RegisterMessage.Visible = true;
                return;
            }

            if (!Regex.IsMatch(regPassword.Text, @"^[a-zA-Z0-9]+$") || regPassword.Text.Length < 8)
            {
                RegisterMessage.Text = "Password must be at least 8 characters, letters and numbers only.";
                RegisterMessage.Visible = true;
                return;
            }

            if (regPassword.Text != regConfirmPassword.Text)
            {
                RegisterMessage.Text = "Passwords do not match.";
                RegisterMessage.Visible = true;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Check if email already exists
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkEmailQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", regEmail.Text);
                        int emailCount = (int)checkCmd.ExecuteScalar();
                        if (emailCount > 0)
                        {
                            RegisterMessage.Text = "Email already registered.";
                            RegisterMessage.Visible = true;
                            return;
                        }
                    }

                    // FIXED: Changed Id to UserId in the SQL query
                    string insertQuery = "INSERT INTO Users (Username, Email, Password, TwoFactorEnabled) OUTPUT INSERTED.UserId VALUES (@Username, @Email, @Password, 0)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", regUsername.Text);
                        cmd.Parameters.AddWithValue("@Email", regEmail.Text);
                        cmd.Parameters.AddWithValue("@Password", regPassword.Text);
                        int userId = (int)cmd.ExecuteScalar(); // FIXED: Changed variable name from Id to userId

                        // Auto-login after registration
                        Session["Username"] = regUsername.Text;
                        Session["UserId"] = userId; // FIXED: Changed from Id to UserId
                        ShowSuccess(RegistrationPanel, "Registration Successful!", "You are now logged in, hop in to courses, or feel free to learn courses now.");
                    }
                }
            }
            catch (Exception ex)
            {
                RegisterMessage.Text = "Error: " + ex.Message;
                RegisterMessage.Visible = true;
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            // Ensure the panel remains visible for validation errors
            LoginPanel.Visible = true;

            // Server-side validation for login fields
            if (string.IsNullOrWhiteSpace(loginEmail.Text))
            {
                LoginMessage.Text = "Email is required.";
                LoginMessage.Visible = true;
                loginEmail.CssClass += " is-invalid"; // Add Bootstrap invalid class
                return;
            }

            if (!Regex.IsMatch(loginEmail.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                LoginMessage.Text = "Invalid email format.";
                LoginMessage.Visible = true;
                loginEmail.CssClass += " is-invalid";
                return;
            }

            if (string.IsNullOrWhiteSpace(loginPassword.Text))
            {
                LoginMessage.Text = "Password is required.";
                LoginMessage.Visible = true;
                loginPassword.CssClass += " is-invalid";
                return;
            }

            if (!Regex.IsMatch(loginPassword.Text, @"^[a-zA-Z0-9]+$"))
            {
                LoginMessage.Text = "Password must contain only letters and numbers.";
                LoginMessage.Visible = true;
                loginPassword.CssClass += " is-invalid";
                return;
            }

            if (loginAttempts >= MAX_LOGIN_ATTEMPTS)
            {
                LoginMessage.Text = "Account temporarily locked! Too many failed attempts.";
                LoginMessage.Visible = true;
                loginEmail.Enabled = false;
                loginPassword.Enabled = false;
                LoginButton.Enabled = false;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    // FIXED: Changed Id to UserId in the SQL query
                    string query = "SELECT UserId, Username, Password FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", loginEmail.Text);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedPassword = reader["Password"].ToString();
                                string username = reader["Username"].ToString();
                                int userId = Convert.ToInt32(reader["UserId"]); // FIXED: Changed from Id to UserId

                                if (loginPassword.Text == storedPassword)
                                {
                                    Session["Username"] = username;
                                    Session["UserId"] = userId; // FIXED: Changed from Id to UserId
                                    Session["LoginAttempts"] = 0; // Reset attempts on successful login
                                    ShowSuccess(LoginPanel, "Login Successful!", "You are now logged in, hop in to courses, or feel free to learn courses now.");
                                }
                                else
                                {
                                    loginAttempts++;
                                    Session["LoginAttempts"] = loginAttempts;
                                    LoginMessage.Text = "Login failed. Attempt " + loginAttempts + " of " + MAX_LOGIN_ATTEMPTS + ".";
                                    LoginMessage.Visible = true;
                                    loginEmail.CssClass += " is-invalid";
                                    loginPassword.CssClass += " is-invalid";
                                }
                            }
                            else
                            {
                                loginAttempts++;
                                Session["LoginAttempts"] = loginAttempts;
                                LoginMessage.Text = "Login failed. Attempt " + loginAttempts + " of " + MAX_LOGIN_ATTEMPTS + ".";
                                LoginMessage.Visible = true;
                                loginEmail.CssClass += " is-invalid";
                                loginPassword.CssClass += " is-invalid";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LoginMessage.Text = "Error: " + ex.Message;
                LoginMessage.Visible = true;
            }
        }

        protected void Verify2FAButton_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["UserId"] == null) // FIXED: Changed from Id to UserId
            {
                ShowSuccess(twoFactorDemo, "Authentication Required", "Please log in first.");
                return;
            }

            string code = verificationCode.Text;
            if (string.IsNullOrWhiteSpace(code) || !Regex.IsMatch(code, @"^[0-9]{6}$"))
            {
                ShowSuccess(twoFactorDemo, "Invalid Code", "Please enter a valid 6-digit code.");
                return;
            }

            if (code == "123456")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        // FIXED: Changed Id to UserId in the SQL query
                        string updateQuery = "UPDATE Users SET TwoFactorEnabled = 1 WHERE UserId = @UserId";
                        using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"]));
                            cmd.ExecuteNonQuery();
                        }
                    }
                    ShowSuccess(twoFactorDemo, "Verification Successful!", "2FA is now enabled for your account.");
                }
                catch (Exception ex)
                {
                    ShowSuccess(twoFactorDemo, "Error", "Error: " + ex.Message);
                }
            }
            else
            {
                ShowSuccess(twoFactorDemo, "Invalid Code", "The verification code is incorrect.");
            }
        }

        protected void SavePaymentButton_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null) // FIXED: Changed from Id to UserId
            {
                PaymentMessage.Text = "Please log in to save payment details.";
                PaymentMessage.Visible = true;
                return;
            }

            // Server-side validation for payment fields
            if (string.IsNullOrWhiteSpace(cardName.Text))
            {
                PaymentMessage.Text = "Cardholder name is required.";
                PaymentMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(cardNumber.Text) || !Regex.IsMatch(cardNumber.Text, @"^[0-9]{16}$"))
            {
                PaymentMessage.Text = "Enter a valid 16-digit card number.";
                PaymentMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(expiryMonth.Text) || !Regex.IsMatch(expiryMonth.Text, @"^(0[1-9]|1[0-2])$"))
            {
                PaymentMessage.Text = "Enter a valid month (01-12).";
                PaymentMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(expiryYear.Text) || !Regex.IsMatch(expiryYear.Text, @"^[0-9]{4}$"))
            {
                PaymentMessage.Text = "Enter a valid year (e.g., 2025).";
                PaymentMessage.Visible = true;
                return;
            }

            int year = Convert.ToInt32(expiryYear.Text);
            int month = Convert.ToInt32(expiryMonth.Text);
            DateTime currentDate = DateTime.Now;
            DateTime expiryDate = new DateTime(year, month, DateTime.DaysInMonth(year, month));
            if (expiryDate < currentDate)
            {
                PaymentMessage.Text = "Card has expired.";
                PaymentMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(cvv.Text) || !Regex.IsMatch(cvv.Text, @"^[0-9]{3,4}$"))
            {
                PaymentMessage.Text = "Enter a valid CVV (3 or 4 digits).";
                PaymentMessage.Visible = true;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string insertQuery = "INSERT INTO Payments (UserId, CardName, CardNumber, ExpiryMonth, ExpiryYear, CVV) VALUES (@UserId, @CardName, @CardNumber, @ExpiryMonth, @ExpiryYear, @CVV)";
                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"])); // FIXED: Changed from Id to UserId
                        cmd.Parameters.AddWithValue("@CardName", cardName.Text);
                        cmd.Parameters.AddWithValue("@CardNumber", cardNumber.Text);
                        cmd.Parameters.AddWithValue("@ExpiryMonth", Convert.ToInt32(expiryMonth.Text));
                        cmd.Parameters.AddWithValue("@ExpiryYear", Convert.ToInt32(expiryYear.Text));
                        cmd.Parameters.AddWithValue("@CVV", cvv.Text);
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowSuccess(PaymentPanel, "Payment Saved!", "Your payment details have been saved successfully.");
            }
            catch (Exception ex)
            {
                PaymentMessage.Text = "Error: " + ex.Message;
                PaymentMessage.Visible = true;
            }
        }

        private void ShowSuccess(Panel container, string title, string message)
        {
            container.Controls.Clear();
            container.Controls.Add(new LiteralControl(
                "<div class='text-center py-4'>" +
                "<i class='fas fa-check-circle text-success' style='font-size: 4rem;'></i>" +
                "<h4 class='mt-4 mb-3'>" + title + "</h4>" +
                "<p>" + message + "</p>" +
                "<button class='btn btn-primary btn-animated mt-3' onclick='location.reload()'>Back to Demo</button>" +
                "</div>"
            ));
        }
    }
}
