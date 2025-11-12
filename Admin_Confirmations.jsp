<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get customer name/email from session
    session = request.getSession(false);
    if (session == null || session.getAttribute("Customer_name") == null) {
        response.sendRedirect("BuyerLog.jsp");
        return;
    }
    String email = (String) session.getAttribute("Customer_name"); // customer email from session
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Confirmations</title>
    <style>
        body {
            font-family: Poppins, sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 450px;
            margin: 80px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            color: #0d47a1;
        }
        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #1976d2;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background: #0d47a1;
        }
        .message {
            text-align: center;
            color: green;
            margin-top: 10px;
        }
        .error {
            text-align: center;
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Send Confirmation</h2>
    <form method="post">
        <!-- Email comes from session; hidden input -->
        <input type="hidden" name="email" value="<%= email %>">

        <label>Message:</label>
        <textarea name="message" rows="4" required></textarea>

        <button type="submit">Send</button>
    </form>

    <%
        // Backend logic
        String message = request.getParameter("message");

        if (message != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false", "root", "root");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO Admin_Confirmations (customer_email, message, status) VALUES (?, ?, 'Pending')");

                ps.setString(1, email);   // email from session
                ps.setString(2, message);
                ps.executeUpdate();

                out.println("<p class='message'>Confirmation message sent successfully!</p>");

                ps.close();
                con.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</div>
</body>
</html>
