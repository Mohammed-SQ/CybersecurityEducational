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
        string cardName = Request.Form["CardName"];
        string cardNumber = Request.Form["CardNumber"];
        string expiryMonth = Request.Form["ExpiryMonth"];
        string expiryYear = Request.Form["ExpiryYear"];
        string cvv = Request.Form["CVV"];

        // Basic server-side validation
        if (string.IsNullOrWhiteSpace(userId) || string.IsNullOrWhiteSpace(cardName) || string.IsNullOrWhiteSpace(cardNumber) || 
            string.IsNullOrWhiteSpace(expiryMonth) || string.IsNullOrWhiteSpace(expiryYear) || string.IsNullOrWhiteSpace(cvv))
        {
            Response.StatusCode = 400;
            Response.Write("All fields are required.");
            return;
        }

        if (!System.Text.RegularExpressions.Regex.IsMatch(cardNumber, @"^[0-9]{16}$"))
        {
            Response.StatusCode = 400;
            Response.Write("Enter a valid 16-digit card number.");
            return;
        }

        if (!System.Text.RegularExpressions.Regex.IsMatch(expiryMonth, @"^(0[1-9]|1[0-2])$"))
        {
            Response.StatusCode = 400;
            Response.Write("Enter a valid month (01-12).");
            return;
        }

        if (!System.Text.RegularExpressions.Regex.IsMatch(expiryYear, @"^[0-9]{4}$"))
        {
            Response.StatusCode = 400;
            Response.Write("Enter a valid year (e.g., 2025).");
            return;
        }

        int year = Convert.ToInt32(expiryYear);
        int month = Convert.ToInt32(expiryMonth);
        DateTime currentDate = DateTime.Now;
        DateTime expiryDate = new DateTime(year, month, DateTime.DaysInMonth(year, month));
        if (expiryDate < currentDate)
        {
            Response.StatusCode = 400;
            Response.Write("Card has expired.");
            return;
        }

        if (!System.Text.RegularExpressions.Regex.IsMatch(cvv, @"^[0-9]{3,4}$"))
        {
            Response.StatusCode = 400;
            Response.Write("Enter a valid CVV (3 or 4 digits).");
            return;
        }

        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["CyberDB"].ConnectionString;
            using (System.Data.OleDb.OleDbConnection conn = new System.Data.OleDb.OleDbConnection(connStr))
            {
                conn.Open();
                string insertQuery = "INSERT INTO Payments (UserId, CardName, CardNumber, ExpiryMonth, ExpiryYear, CVV) VALUES (?, ?, ?, ?, ?, ?)";
                using (System.Data.OleDb.OleDbCommand cmd = new System.Data.OleDb.OleDbCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("?", Convert.ToInt32(userId));
                    cmd.Parameters.AddWithValue("?", cardName);
                    cmd.Parameters.AddWithValue("?", cardNumber);
                    cmd.Parameters.AddWithValue("?", month);
                    cmd.Parameters.AddWithValue("?", year);
                    cmd.Parameters.AddWithValue("?", cvv);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Write("{\"status\":\"success\",\"message\":\"Payment details saved successfully\"}");
        }
        catch (Exception ex)
        {
            Response.StatusCode = 500;
            Response.Write($"Error: {ex.Message}");
        }
    }
</script>