<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %> 
<%
    // Check if logout is requested
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session = request.getSession(false);
        if (session != null) {
            // --- CRITICAL CHANGE: REMOVE ONLY THE SPECIFIC ATTRIBUTE ---
            session.removeAttribute("Customer_name"); 
            // NOTE: The rest of the session remains active, but the user is logged out.
            // If you are using "Customer_name" for all login checks, this is sufficient.
        }
        // Redirect to login page
        response.sendRedirect("BuyerLog.jsp"); 
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <style>
        body {
            font-family: Poppins, sans-serif;
            background: linear-gradient(135deg, #f0f8ff, #e0f7fa);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .profile-container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
            text-align: center;
        }
        h2 {
            color: #007bff;
            margin-bottom: 30px;
            font-size: 24px;
        }
        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .form-group input[readonly] {
            background-color: #f5f5f5;
            cursor: default;
        }
        .btn-update {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 10px;
        }
        .btn-update:hover {
            background-color: #1e7e34;
        }
        .btn-back {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }
    </style>
    <script>
            function destroySessionAndRedirect()
            {
            // redirect to same page with ?action=logout to trigger the server-side logic
            window.location.href = 'Customer_Profile.jsp?action=logout';
            }
    </script>
</head>

<body>

<%
    // NOTE: This line assumes "Customer_name" holds the Email_id for the DB query. 
    // If "Customer_name" holds the actual name, you need to use the email stored elsewhere (e.g., in a separate session variable like "customerEmail").
    String customerEmail = (String) session.getAttribute("Customer_name"); 
    String name = "";
    String cNo = "";
    String password = ""; 

    if (customerEmail == null) {
        // If email is not in session, redirect to login
        response.sendRedirect("BuyerLog.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // 1. Load Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 2. Establish Connection (Adjust Database name if necessary)
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false",
            "root", "root"
        );

        // 3. Prepare SQL Statement
        String sql = "SELECT Name, C_No, Password FROM bregister  WHERE Email_id = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, customerEmail);

        // 4. Execute Query
        rs = ps.executeQuery();

        if (rs.next()) {
            // Retrieve data
            name = rs.getString("Name");
            cNo = rs.getString("C_No");
            password = rs.getString("Password"); 
        } else {
            // Customer record not found
            out.println("<p style='color:red;'>Error: Customer profile not found!</p>");
            return;
        }

    } catch (Exception e) {
        out.println("<div class='profile-container'><p style='color:red;'>Database Error: " + e.getMessage() + "</p></div>");
        // Log the error (e.printStackTrace() in a real application)
        return;
    } finally {
        // 5. Close Resources
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }
%>

<div class="profile-container">
    <h2>👤 Edit Customer Profile</h2>

    <form action="Update_Password_Customer.jsp" method="post">
        
        <div class="form-group">
            <label for="email">Email ID</label>
            <input type="email" id="email" name="email" value="<%= customerEmail %>" readonly>
            <input type="hidden" name="oldEmail" value="<%= customerEmail %>">
        </div>

        <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= name %>" required>
        </div>

        <div class="form-group">
            <label for="cno">Contact Number (C_No)</label>
            <input type="text" id="cno" name="cno" value="<%= cNo %>" required>
        </div>

        <div class="form-group">
            <label for="password">New Password</label>
            <!-- Important: This is a poor security practice, use password hashing in production. -->
            <input type="password" id="password" name="password" placeholder="Leave blank to keep current password">
        </div>

        <button type="submit" class="btn-update">Update Profile</button>
    </form>
    
    <a href="Customer_interface.jsp" class="btn-back">← Back to Shopping</a>
    <br><br>
    <button class="btn" onclick="destroySessionAndRedirect()">Logout</button>

</div>

</body>
</html>
