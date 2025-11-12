<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.*" %>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("Email") == null) {
        response.sendRedirect("Sellerlog.jsp");
        return;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item</title>
    <style>
        /* ---------------------- RESET ---------------------- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }

        /* ---------------------- BACKGROUND ---------------------- */
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('4aa8f45f74b347302309da315df7ce2d.jpg') no-repeat center center/cover, 
                        linear-gradient(135deg, #6dd5ed, #2193b0); /* Layering background image with gradient */
            background-size: cover;
            animation: gradientShift 10s ease infinite;
            overflow: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* ---------------------- FORM CONTAINER ---------------------- */
        .form-container {
            position: relative;
            width: 450px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.12);
            border-radius: 25px;
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.35);
            color: #fff;
            animation: floatUp 1.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        @keyframes floatUp {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* ---------------------- HEADING ---------------------- */
        .form-container h2 {
            text-align: center;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 30px;
            letter-spacing: 1px;
            text-shadow: 0 3px 10px rgba(0, 0, 0, 0.4);
        }

        /* ---------------------- FORM ELEMENTS ---------------------- */
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 6px;
            color: #e3e3e3;
            font-size: 15px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: none;
            font-size: 15px;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
            outline: none;
            transition: 0.3s;
            box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);
        }

        .form-group input:focus,
        .form-group select:focus {
            box-shadow: 0 0 10px rgba(0, 255, 255, 0.7);
            transform: scale(1.02);
        }

        .form-group input[type="file"] {
            padding: 8px;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-group select {
            background-color: rgba(255, 255, 255, 0.9);
        }

        /* ---------------------- SUBMIT BUTTON ---------------------- */
        .submit-btn {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            font-size: 17px;
            font-weight: 500;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            color: #fff;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            box-shadow: 0 0 12px rgba(0, 153, 255, 0.4);
            transition: all 0.35s ease;
        }

        .submit-btn:hover {
            background: linear-gradient(135deg, #43e97b, #38f9d7);
            box-shadow: 0 0 18px rgba(0, 255, 255, 0.8);
            transform: translateY(-3px);
        }

        /* ---------------------- GLOW ORBS ---------------------- */
        .glow {
            position: absolute;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            filter: blur(90px);
            opacity: 0.7;
            animation: pulse 8s infinite ease-in-out alternate;
            z-index: -1;
        }

        .glow.one {
            top: -50px;
            left: -50px;
            background: #00c6ff;
        }

        .glow.two {
            bottom: -50px;
            right: -50px;
            background: #ff6a00;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 0.8; }
            100% { transform: scale(1.3); opacity: 0.4; }
        }

        /* ---------------------- FOOTER ---------------------- */
        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: rgba(255, 255, 255, 0.85);
        }

        .footer span {
            color: #ffeb3b;
        }
    </style>
</head>

<body>
    <div class="form-container">
        <div class="glow one"></div>
        <div class="glow two"></div>

        <h2>Add New Item</h2>

        <form action="Seller_Add_Database" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">Item Name</label>
                <input type="text" name="name" id="name" placeholder="Enter item name" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <select name="category" id="category" required>
                    <option value="">-- Select Category --</option>
                    <option value="Grocery">Grocery</option>
                    <option value="Daily Products">Daily Products</option>
                    <option value="Dairy Products">Dairy Products</option>
                    <option value="Cosmetics Products">Cosmetics Products</option>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" name="quantity" id="quantity" placeholder="Enter quantity" required>
            </div>

            <div class="form-group">
                <label for="image">Item Image</label>
                <input type="file" name="image" id="image" accept="image/*" required>
            </div>

            <div class="form-group">
                <label for="price">Price (?)</label>
                <input type="number" name="price" id="price" placeholder="Enter price" required>
            </div>

            <div class="form-group">
                <label for="expiry">Expiry Date</label>
                <input type="date" name="expiry" id="expiry" required>
            </div>

            <button type="submit" class="submit-btn">Add Item</button>
        </form>

        <div class="footer">
            © 2025 <span>Agresh</span> | Designed with
        </div>
    </div>
</body>
</html>
