<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.*" %>
<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Logout logic
    String action = request.getParameter("action");
    if ("logout".equals(action)) {
        session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("Sellerlog.jsp"); 
        return;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard | Inventory Management</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <style>
        /* ---------------------- CSS Variables & Base Styles ---------------------- */
        :root {
            --primary-blue: #4a90e2; /* A slightly softer, more vibrant blue */
            --primary-dark-blue: #3a7bd5;
            --gradient-start: #6dd5ed; /* Lighter blue for gradients */
            --gradient-end: #2193b0;   /* Darker teal for gradients */
            --text-dark: #2c3e50; /* Darker, more prominent text */
            --text-light: #7f8c8d; /* Muted text */
            --background-body: #f0f2f5; /* Off-white background */
            --background-card: #ffffff;
            --shadow-light: rgba(0, 0, 0, 0.08);
            --shadow-medium: rgba(0, 0, 0, 0.12);
            --border-light: #e0e6ed;
            --red-logout: #e74c3c;
            --red-logout-hover: #c0392b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif; /* Changed font to Poppins */
        }

        body {
            background-color: var(--background-body);
            display: flex;
            min-height: 100vh;
            color: var(--text-dark);
            line-height: 1.6;
            overflow-x: hidden; /* Prevent horizontal scroll */
        }

        a {
            text-decoration: none;
            color: var(--primary-blue);
            transition: color 0.3s ease;
        }

        a:hover {
            color: var(--primary-dark-blue);
        }

        /* ---------------------- SIDEBAR ---------------------- */
        .sidebar {
            width: 260px; /* Slightly wider sidebar */
            background: linear-gradient(135deg, var(--gradient-start), var(--gradient-end)); /* Gradient background */
            box-shadow: 4px 0 15px var(--shadow-medium);
            padding: 30px 0; /* More vertical padding */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: sticky;
            top: 0;
            height: 100vh;
            color: white; /* White text for contrast on gradient */
        }

        .logo-section {
            padding: 0 25px 40px; /* Increased padding */
            border-bottom: 1px solid rgba(255, 255, 255, 0.2); /* Lighter border */
            text-align: center;
        }

        .logo-section h1 {
            font-size: 28px; /* Larger logo text */
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
        }

        .logo-section h1 i {
            font-size: 32px;
            color: rgba(255, 255, 255, 0.9);
        }

        .nav-links {
            flex-grow: 1;
            list-style: none;
            padding: 25px 0;
        }

        .nav-links li a {
            display: flex;
            align-items: center;
            padding: 18px 25px; /* More padding for links */
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            transition: all 0.3s ease;
            border-left: 5px solid transparent;
        }

        .nav-links li a i {
            margin-right: 15px; /* More space for icons */
            font-size: 20px;
        }

        .nav-links li a:hover,
        .nav-links li a.active {
            background-color: rgba(255, 255, 255, 0.15); /* Semi-transparent white on hover */
            color: white;
            border-left-color: white;
            transform: translateX(5px); /* Slight animation on hover */
            box-shadow: inset 3px 0 8px rgba(0,0,0,0.1);
        }
        
        /* ---------------------- MAIN CONTENT AREA ---------------------- */
      .main-container {
    position: relative;
    z-index: 1; /* Ensures the content sits above the image */
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    background-color: transparent; /* Transparent background to let the image show */
}
        /* ---------------------- TOP BAR ---------------------- */
        .top-header {
            background: var(--background-card);
            padding: 18px 40px; /* Increased padding */
            border-bottom: 1px solid var(--border-light);
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px var(--shadow-light);
            z-index: 10;
        }

        .welcome-message h2 {
            font-size: 24px; /* Larger welcome message */
            font-weight: 600;
            color: var(--text-dark);
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .logout-btn {
            background: var(--red-logout);
            color: white;
            padding: 10px 20px; /* Larger button */
            border: none;
            border-radius: 8px; /* Softer corners */
            cursor: pointer;
            font-weight: 600;
            font-size: 15px;
            transition: background 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 8px rgba(231, 76, 60, 0.2);
        }

        .logout-btn:hover {
            background: var(--red-logout-hover);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(192, 57, 43, 0.3);
        }

        /* ---------------------- DASHBOARD CONTENT ---------------------- */
        .dashboard-content {
            padding: 40px; /* More padding around content */
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center; /* Center content horizontally */
            justify-content: center; /* Center content vertically */
            flex: 1; /* Allow content to grow */
        }

        /* ---------------------- MAIN SECTION ---------------------- */
        .main-section {
            background: var(--background-card);
            border-radius: 12px; /* More rounded corners */
            box-shadow: 0 8px 25px var(--shadow-medium); /* Deeper shadow */
            padding: 60px 40px; /* Increased padding */
            max-width: 700px; /* Max width for better readability */
            width: 100%;
            text-align: center;
            transition: all 0.3s ease; /* Smooth transitions */
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
        }
        
        .scrollable {
            overflow-y: auto;
            max-height: 70vh;
            padding-right: 10px;
        }

        
        /* Subtle background pattern/texture */
        .main-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml;utf8,<svg width="100" height="100" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><circle cx="10" cy="10" r="2" fill="%23f0f2f5"/><circle cx="50" cy="50" r="2" fill="%23f0f2f5"/><circle cx="90" cy="90" r="2" fill="%23f0f2f5"/><circle cx="10" cy="90" r="2" fill="%23f0f2f5"/><circle cx="90" cy="10" r="2" fill="%23f0f2f5"/></svg>') repeat;
            opacity: 0.3;
            pointer-events: none;
            z-index: 0;
        }

        .main-section h3 {
            font-size: 36px; /* Larger heading */
            font-weight: 700;
            color: var(--primary-dark-blue);
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }
        
        .main-section p {
            font-size: 18px;
            color: var(--text-light);
            margin-bottom: 30px;
            max-width: 500px;
            line-height: 1.8;
            position: relative;
            z-index: 1;
        }
        .product-card {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 15px;
    margin: 15px; /* Optional: margin for spacing */
    background-color: #fafafa;
    transition: 0.3s;
    max-width: 350px; /* Control the max width */
    width: 100%;
    box-sizing: border-box;
}
      .product-card:hover {
    background-color: #eaf6ff;
}
        .product-info {
            flex: 2;
            padding-left: 15px;
        }

        .product-info h3 {
            margin: 5px 0;
            color: #222;
        }

        .product-info p {
            margin: 3px 0;
            color: #555;
            font-size: 14px;
        }

        .product-img {
            flex: 1;
            text-align: center;
        }

        .product-img img {
            width: 120px;
            height: 120px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #ccc;
        }

        .scrollable {
    display: flex;
    flex-wrap: wrap;
    justify-content: center; /* Center the product cards horizontally */
    align-items: center; /* Center the product cards vertically */
    overflow-y: auto;
    max-height: 70vh;
    padding-right: 10px;
}

        .back-btn {
            display: block;
            margin: 20px auto 0;
            text-align: center;
            width: 150px;
            background-color: #2193b0;
            color: white;
            text-decoration: none;
            padding: 10px;
            border-radius: 10px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background-color: #6dd5ed;
            color: #000;
        }

        .main-section .large-icon {
            font-size: 100px; /* Much larger icon */
            color: #d1d8e0; /* Softer, muted gray */
            margin-top: 30px;
            transition: transform 0.4s ease-in-out;
            position: relative;
            z-index: 1;
            animation: bounce 2s infinite alternate; /* Subtle animation */
        }

        /* Keyframe for bounce effect */
        @keyframes bounce {
            from {
                transform: translateY(0);
            }
            to {
                transform: translateY(-8px);
            }
        }

        /* ---------------------- FOOTER ---------------------- */
        .footer {
            text-align: center;
            padding: 20px;
            font-size: 14px;
            border-top: 1px solid var(--border-light);
            color: var(--text-light);
            background-color: var(--background-card);
            margin-top: auto;
            box-shadow: 0 -2px 8px var(--shadow-light);
        }
        .footer span {
            color: var(--primary-blue);
            font-weight: 500;
        }
        .footer i {
            color: var(--red-logout);
            margin: 0 5px;
        }
   .image-container {
    width: 100%;
    height: 100vh; /* Full height of the viewport */
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1; /* Keeps the image in the background */
    background-image: url('4aa8f45f74b347302309da315df7ce2d.jpg'); /* Your image */
    background-size: cover; /* Ensure the image covers the entire area */
    background-position: center center; /* Centers the image */
    background-repeat: no-repeat;
}
.image-container img {
    display: none; /* Hides the img tag if you are using background-image */
}
    </style>
</head>

<body>
    <%
        // Session Check logic remains the same
        session = request.getSession(false);
        if (session == null || session.getAttribute("Email") == null) {
            response.sendRedirect("Sellerlog.jsp"); 
            return;
        }
        String sellerEmail = (String)session.getAttribute("Email");
        String sellerName = sellerEmail.replaceAll("@gmail.com","");
    %>

    <div class="sidebar">
        <div>
            <div class="logo-section">
                <h1><i class="fas fa-cubes"></i>Seller</h1> </div>
            
            <ul class="nav-links">
                <li><a href="Seller_Interface.jsp" class="active"><i class="fas fa-home"></i> Dashboard</a></li> <li><a href="Seller_Add_Interface.jsp"><i class="fas fa-box-open"></i> Add New Product</a></li>
                <li><a href="View_Products.jsp"><i class="fas fa-th-list"></i> View All Products</a></li> <li><a href="Seller_Interface.jsp"><i class="fas fa-warehouse"></i> Inventory</a></li>
                <li><a href="View_List_U.jsp"><i class="fas fa-pencil-alt"></i> Update Product</a></li> <li><a href="Delete_List.jsp"><i class="fas fa-trash-alt"></i> Delete Product</a></li>
            </ul>
        </div>

        <div class="footer" style="background: none; border-top: 1px solid rgba(255, 255, 255, 0.2); color: rgba(255, 255, 255, 0.8);">
            <p>&copy; 2025 SellerPro</p>
        </div>
    </div>

    <div class="main-container">

        <div class="top-header">
            <div class="welcome-message">
                <h2>Hello,<%= sellerName %>!</h2>
            </div>
            <div class="user-controls">
                <button class="logout-btn" onclick="destroySessionAndRedirect()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>

        <div class="dashboard-content">
         <div class="image-container">
    <img src="4aa8f45f74b347302309da315df7ce2d.jpg" alt="Inventory Image">
</div>
            </div>
            </div>
         
    <script>
        function destroySessionAndRedirect() {
            window.location.href = 'Seller_Interface.jsp?action=logout';
        }
    </script>
</body>
</html>