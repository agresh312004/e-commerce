<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.*" %> 
<%
    // Check if logoutis called  is requested
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
         session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // destroy session
        }
        response.sendRedirect("Sellerlog.jsp"); // redirect to login page
        return;
    }
%>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard</title>
    <style>
        /* Basic page setup */
        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Dashboard container */
        .dashboard {
            background: #fff;
            width: 400px;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .dashboard h2 {
            color: #333;
            margin-bottom: 25px;
            font-size: 24px;
        }

        /* Buttons styling */
        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            margin: 10px 0;
            background: #2193b0;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .btn:hover {
            background: #6dd5ed;
            color: #000;
        }

        /* Message box styling */
        .message-box {
            display: none;
            margin-top: 20px;
        }

        textarea {
            width: 100%;
            height: 100px;
            border-radius: 10px;
            border: 1px solid #ccc;
            padding: 10px;
            resize: none;
            font-size: 14px;
        }

        .close-btn {
            background: #ff5f6d;
            margin-top: 10px;
        }

        .close-btn:hover {
            background: #ff9966;
        }
    </style>
</head>
<body>
    <div class="dashboard">
         <%
        session = request.getSession(false);
        if (session == null || session.getAttribute("Email") == null) {
            response.sendRedirect("Sellerlog.jsp");
            return;
        }
        %>
        <h2>Welcome,  <%= ((String)session.getAttribute("Email")).replaceAll("@gmail.com","") %></h2>
        <button class="btn" onclick="location.href='Seller_Add_Interface.jsp'">Add Items</button>
        <button class="btn" onclick="location.href='Delete_List.jsp'">Delete Items</button>
        <button class="btn" onclick="location.href='Seller_Interface.jsp'">Inventory</button>
        <button class="btn" onclick="location.href='View_Products.jsp'">View Products</button>
        <button class="btn" onclick="location.href='View_List_U.jsp'">Update Product</button>
        <button class="btn" onclick="destroySessionAndRedirect()">Logout</button>


        <button class="btn" onclick="toggleMessageBox()">Messages</button>

        <!-- Hidden Message Box -->
        <div class="message-box" id="msgBox">
            <textarea placeholder="Write your message here..."></textarea>
            <button class="btn close-btn" onclick="toggleMessageBox()">Close</button>
        </div>
    </div>

    <script>
         
        function toggleMessageBox() {
            const box = document.getElementById('msgBox');
            box.style.display = box.style.display === 'block' ? 'none' : 'block';
        }
        
        
        function destroySessionAndRedirect() {
            // redirect to same page with ?action=logout to destroy session
            window.location.href = 'Seller_Interface.jsp?action=logout';
        }
    </script>
    
   
</body>
</html>
