using System;
using System.Configuration;
using System.Data.OleDb;
using System.Web.UI;

namespace CybersecurityEducational
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Add CORS headers
            Response.AppendHeader("Access-Control-Allow-Origin", "*");
            Response.AppendHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
            Response.AppendHeader("Access-Control-Allow-Headers", "Content-Type");

            if (Request.HttpMethod != "POST")
            {
                Response.StatusCode = 405;
                Response.Write("Method Not Allowed");
                return;
            }

            string username = Request.Form["Username"];
            string email = Request.Form["Email"];
            string password = Request.Form["Password"];

            // Basic server-side validation
            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                Response.StatusCode = 400;
                Response.Write("All fields are required.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(username, @"^[a-z]+$") || username.Length < 5 || username.Length > 20)
            {
                Response.StatusCode = 400;
                Response.Write("Username must be 5-20 lowercase letters only.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                Response.StatusCode = 400;
                Response.Write("Invalid email format.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^[a-zA-Z0-9]+$") || password.Length < 8)
            {
                Response.StatusCode = 400;
                Response.Write("Password must be at least 8 characters, letters and numbers only.");
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connStr))
                {
                    conn.Open();

                    // Check if email already exists
                    string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email = ?";
                    using (OleDbCommand checkCmd = new OleDbCommand(checkEmailQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("?", email);
                        int emailCount = (int)checkCmd.ExecuteScalar();
                        if (emailCount > 0)
                        {
                            Response.StatusCode = 400;
                            Response.Write("Email already registered.");
                            return;
                        }
                    }

                    // Insert new user
                    string sql = "INSERT INTO Users (Username, Email, Password, TwoFactorEnabled) VALUES (?, ?, ?, 0); SELECT SCOPE_IDENTITY();";
                    using (OleDbCommand cmd = new OleDbCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("?", username);
                        cmd.Parameters.AddWithValue("?", email);
                        cmd.Parameters.AddWithValue("?", password);
                        int userId = Convert.ToInt32(cmd.ExecuteScalar());

                        Response.Write($"{{\"status\":\"success\",\"message\":\"User registered successfully\",\"userId\":{userId},\"username\":\"{username}\"}}");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
                Response.Write($"Error: {ex.Message}");
            }
        }
    }
}