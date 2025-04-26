<%@ Page Language="C#" %>
<%@ Import Namespace="System.Configuration" %>
<script runat="server">
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

        string userId = Request.Form["UserId"];
        string code = Request.Form["Code"];

        // Basic server-side validation
        if (string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace(code))
        {
            Response.StatusCode = 400;
            Response.Write("All fields are required.");
            return;
        }

        if (!System.Text.RegularExpressions.Regex.IsMatch(code, @"^[0-9]{6}$"))
        {
            Response.StatusCode = 400;
            Response.Write("Invalid 6-digit code.");
            return;
        }

        if (code == "123456") // Demo code
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;
                using (System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(connStr))
                {
                    conn.Open();
                    string updateQuery = "UPDATE Users SET TwoFactorEnabled = 1 WHERE Id = ?";
                    using (System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("?", Convert.ToInt32(userId));
                        cmd.ExecuteNonQuery();
                    }
                }
                Response.Write("{\"status\":\"success\",\"message\":\"2FA verified successfully\"}");
            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
                Response.Write($"Error: {ex.Message}");
            }
        }
        else
        {
            Response.StatusCode = 400;
            Response.Write("Invalid verification code.");
        }
    }
</script>