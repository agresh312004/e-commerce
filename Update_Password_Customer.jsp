<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Update Status</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f8ff; }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4">

    <%
        // --- 1. Define Database Configuration (Aligned with Customer_Profile.jsp) ---
        final String DB_URL = "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false";
        final String DB_USER = "root";
        final String DB_PASS = "root";
        final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

        // --- 2. Retrieve User Inputs from the form/request ---
        String oldEmail = request.getParameter("oldEmail");
        String newName = request.getParameter("name");
        String newCNo = request.getParameter("cno");
        String newPassword = request.getParameter("password"); // Optional new password

        String message = "";
        String messageColor = "text-gray-600"; 
        boolean success = false; // To control redirect only on success
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        boolean isPasswordUpdated = (newPassword != null && !newPassword.trim().isEmpty());

        try {
            if (oldEmail == null || oldEmail.trim().isEmpty() || newName == null || newName.trim().isEmpty() || newCNo == null || newCNo.trim().isEmpty()) {
                message = "Error: Email ID, Name, and Contact Number are required.";
                messageColor = "text-red-500";
            } else {
                String passwordToStore = newPassword; // NOTE: In production, HASH this!

                Class.forName(DB_DRIVER);
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                
                String sql;
                if (isPasswordUpdated) {
                    sql = "UPDATE bregister SET Name = ?, C_No = ?, Password = ? WHERE Email_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, newName);
                    stmt.setString(2, newCNo);
                    stmt.setString(3, passwordToStore);
                    stmt.setString(4, oldEmail);
                    message += "Profile updated, and password successfully changed! ";
                } else {
                    sql = "UPDATE bregister SET Name = ?, C_No = ? WHERE Email_id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, newName);
                    stmt.setString(2, newCNo);
                    stmt.setString(3, oldEmail);
                    message += "Profile updated (Name and Contact No)! ";
                }

                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    session.setAttribute("Customer_name", oldEmail); 
                    messageColor = "text-green-600";
                    success = true;
                } else {
                    message = "Error: Update failed. Customer profile not found or data unchanged.";
                    messageColor = "text-yellow-600";
                }
            }
        } catch (ClassNotFoundException e) {
            message = "JDBC Driver not found. Check your environment setup.";
            messageColor = "text-red-700";
            e.printStackTrace();
        } catch (SQLException e) {
            message = "A database error occurred: " + e.getMessage();
            messageColor = "text-red-700";
            e.printStackTrace();
        } catch (Exception e) {
            message = "An unexpected error occurred: " + e.getMessage();
            messageColor = "text-red-700";
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <div class="w-full max-w-md bg-white p-8 rounded-xl shadow-2xl border border-gray-100 text-center">
        <h1 class="text-3xl font-extrabold text-gray-800 mb-6">Profile Update</h1>
        
        <% if (!message.isEmpty()) { %>
            <div id="statusMessage" 
                 class="p-6 mb-6 rounded-lg font-bold <%= messageColor %> 
                 <%= messageColor.contains("green") ? "bg-green-100 border-green-300" : 
                     (messageColor.contains("red") ? "bg-red-100 border-red-300" : "bg-yellow-100 border-yellow-300") %> border-2">
                <%= message %>
            </div>
        <% } %>

        <% if (success) { %>
            <p id="redirectNotice" class="text-sm text-gray-600 mt-4">
                Redirecting back to your profile in <span id="countdown">5</span> seconds...
            </p>
            <script>
                let seconds = 5;
                const countdown = document.getElementById("countdown");
                const interval = setInterval(() => {
                    seconds--;
                    countdown.textContent = seconds;
                    if (seconds <= 0) {
                        clearInterval(interval);
                        window.location.href = "Customer_Profile.jsp";
                    }
                }, 1000);
            </script>
        <% } %>

        <a href="Customer_Profile.jsp" 
           class="inline-block py-2 px-6 mt-6 border border-transparent rounded-lg shadow-md text-sm font-medium text-white 
                  bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 
                  transition duration-150 transform hover:scale-[1.01]">
            ← Back to Profile
        </a>
    </div>

</body>
</html>
