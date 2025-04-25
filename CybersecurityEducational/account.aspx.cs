using System;
using System.Data.OleDb;
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
                Session["UserId"] = null;
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
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();

                    // Check if email already exists
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = ?";
                    using (OleDbCommand checkCmd = new OleDbCommand(checkEmailQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("?", regEmail.Text);
                        int emailCount = (int)checkCmd.ExecuteScalar();
                        if (emailCount > 0)
                        {
                            RegisterMessage.Text = "Email already registered.";
                            RegisterMessage.Visible = true;
                            return;
                        }
                    }

                    // Insert new user with plain text password
                    string insertQuery = "INSERT INTO Users (Username, Email, Password, TwoFactorEnabled) VALUES (?, ?, ?, 0); SELECT SCOPE_IDENTITY();";
                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("?", regUsername.Text);
                        cmd.Parameters.AddWithValue("?", regEmail.Text);
                        cmd.Parameters.AddWithValue("?", regPassword.Text);
                        int userId = Convert.ToInt32(cmd.ExecuteScalar());

                        // Auto-login after registration
                        Session["Username"] = regUsername.Text;
                        Session["UserId"] = userId;
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
            // Server-side validation for login fields
            if (string.IsNullOrWhiteSpace(loginEmail.Text))
            {
                LoginMessage.Text = "Email is required.";
                LoginMessage.Visible = true;
                return;
            }

            if (!Regex.IsMatch(loginEmail.Text, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                LoginMessage.Text = "Invalid email format.";
                LoginMessage.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(loginPassword.Text))
            {
                LoginMessage.Text = "Password is required.";
                LoginMessage.Visible = true;
                return;
            }

            if (!Regex.IsMatch(loginPassword.Text, @"^[a-zA-Z0-9]+$"))
            {
                LoginMessage.Text = "Password must contain only letters and numbers.";
                LoginMessage.Visible = true;
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
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT Id, Username, Password FROM Users WHERE Email = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", loginEmail.Text);
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedPassword = reader["Password"].ToString();
                                string username = reader["Username"].ToString();
                                int userId = Convert.ToInt32(reader["Id"]);

                                if (loginPassword.Text == storedPassword)
                                {
                                    Session["Username"] = username;
                                    Session["UserId"] = userId;
                                    Session["LoginAttempts"] = 0; // Reset attempts on successful login
                                    ShowSuccess(LoginPanel, "Login Successful!", "You are now logged in, hop in to courses, or feel free to learn courses now.");
                                }
                                else
                                {
                                    loginAttempts++;
                                    Session["LoginAttempts"] = loginAttempts;
                                    LoginMessage.Text = $"Login failed. Attempt {loginAttempts} of {MAX_LOGIN_ATTEMPTS}.";
                                    LoginMessage.Visible = true;
                                }
                            }
                            else
                            {
                                loginAttempts++;
                                Session["LoginAttempts"] = loginAttempts;
                                LoginMessage.Text = $"Login failed. Attempt {loginAttempts} of {MAX_LOGIN_ATTEMPTS}.";
                                LoginMessage.Visible = true;
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
            if (Session["Username"] == null || Session["UserId"] == null)
            {
                ShowSuccess((Panel)FindControl("twoFactorDemo"), "Authentication Required", "Please log in first.");
                return;
            }

            string code = Request.Form["verificationCode"];
            if (string.IsNullOrWhiteSpace(code) || !Regex.IsMatch(code, @"^[0-9]{6}$"))
            {
                ShowSuccess((Panel)FindControl("twoFactorDemo"), "Invalid Code", "Please enter a valid 6-digit code.");
                return;
            }

            if (code == "123456")
            {
                try
                {
                    using (OleDbConnection conn = new OleDbConnection(connectionString))
                    {
                        conn.Open();
                        string updateQuery = "UPDATE Users SET TwoFactorEnabled = 1 WHERE Id = ?";
                        using (OleDbCommand cmd = new OleDbCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("?", Convert.ToInt32(Session["UserId"]));
                            cmd.ExecuteNonQuery();
                        }
                    }
                    ShowSuccess((Panel)FindControl("twoFactorDemo"), "Verification Successful!", "2FA is now enabled for your account.");
                }
                catch (Exception ex)
                {
                    ShowSuccess((Panel)FindControl("twoFactorDemo"), "Error", "Error: " + ex.Message);
                }
            }
            else
            {
                ShowSuccess((Panel)FindControl("twoFactorDemo"), "Invalid Code", "The verification code is incorrect.");
            }
        }

        protected void SavePaymentButton_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
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
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string insertQuery = "INSERT INTO Payments (UserId, CardName, CardNumber, ExpiryMonth, ExpiryYear, CVV) VALUES (?, ?, ?, ?, ?, ?)";
                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("?", Convert.ToInt32(Session["UserId"]));
                        cmd.Parameters.AddWithValue("?", cardName.Text);
                        cmd.Parameters.AddWithValue("?", cardNumber.Text);
                        cmd.Parameters.AddWithValue("?", Convert.ToInt32(expiryMonth.Text));
                        cmd.Parameters.AddWithValue("?", Convert.ToInt32(expiryYear.Text));
                        cmd.Parameters.AddWithValue("?", cvv.Text);
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
                $@"<div class='text-center py-4'>
                    <i class='fas fa-check-circle text-success' style='font-size: 4rem;'></i>
                    <h4 class='mt-4 mb-3'>{title}</h4>
                    <p>{message}</p>
                    <button class='btn btn-primary btn-animated mt-3' onclick='location.reload()'>Back to Demo</button>
                </div>"
            ));
        }
    }
}