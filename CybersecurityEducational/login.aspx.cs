using System;
using System.Configuration;
using System.Data.OleDb;
using System.Web.UI;

namespace CybersecurityEducational
{
    public partial class Login : Page
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

            string email = Request.Form["Email"];
            string password = Request.Form["Password"];

            // Basic server-side validation
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                Response.StatusCode = 400;
                Response.Write("All fields are required.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                Response.StatusCode = 400;
                Response.Write("Invalid email format.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^[a-zA-Z0-9]+$"))
            {
                Response.StatusCode = 400;
                Response.Write("Password must contain only letters and numbers.");
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connStr))
                {
                    conn.Open();
                    string query = "SELECT Id, Username, Password FROM Users WHERE Email = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("?", email);
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string storedPassword = reader["Password"].ToString();
                                string username = reader["Username"].ToString();
                                int userId = Convert.ToInt32(reader["Id"]);

                                if (password == storedPassword)
                                {
                                    Response.Write($"{{\"status\":\"success\",\"message\":\"Login successful\",\"userId\":{userId},\"username\":\"{username}\"}}");
                                }
                                else
                                {
                                    Response.StatusCode = 401;
                                    Response.Write("Invalid credentials.");
                                }
                            }
                            else
                            {
                                Response.StatusCode = 401;
                                Response.Write("Invalid credentials.");
                            }
                        }
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