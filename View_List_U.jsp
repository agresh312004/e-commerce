<%@ page import="java.io.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Inventory</title>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #2193b0, #6dd5ed);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1000px;
            background: #fff;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            overflow-y: auto;
            max-height: 85vh;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        .product-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #fafafa;
            transition: 0.3s;
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

    </style>
</head>
<body>

<div class="container">
    <h2>Select the Product 🛒</h2>

   <div class="scrollable">
    <%
        session = request.getSession(false);
        if (session == null || session.getAttribute("Email") == null) {
            out.print("<h3 style='color:red;text-align:center;'>Session expired! Please log in again.</h3>");
            response.sendRedirect("Sellerlog.jsp");
            return;
        } 
        else
        {
            String seller = ((String) session.getAttribute("Email")).replaceAll("@gmail.com", "").toUpperCase().trim();
            String sellerSafe = seller.replaceAll("[^a-zA-Z0-9]", "_");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false",
                    "root", "root"
                );

                String query = "SELECT id, Name, Category, Quantity, Image_Name, Image_Path, Price, Expiry FROM seller_" + sellerSafe;
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery();

                boolean found = false;
                while (rs.next()) {
                    found = true;
                    int id = rs.getInt("id");
                    String name = rs.getString("Name");
                    String category = rs.getString("Category");
                    int quantity = rs.getInt("Quantity");
                    String imageName = rs.getString("Image_Name");
                    String imagePath = rs.getString("Image_Path");
                    int price = rs.getInt("Price");
                    String expiry = rs.getString("Expiry");

                    String fullPath = imagePath + "/" + imageName;
    %>

    <form action="Update_Product.jsp" method="get">
        <div class="product-card">
            <div class="product-img">
                <img src="<%= fullPath %>" alt="<%= name %>">
            </div>
            <div class="product-info">
                <h3 name="name"><%= name %></h3>
               <p>
            <strong><%= name %></strong> - <%= category %> - Qty: <%= quantity %> - ₹<%= price %> - Exp: <%= expiry %>
            <input type="hidden" name="id" value="<%= id %>"><br>
            <button type="submit" style="padding:8px 15px; border:none; background-color:#2193b0; color:white; border-radius:8px; cursor:pointer;" >✏️ Update</button>
              </p>
               
            </div>
        </div>
    </form>

    <%
                }
                if (!found) {
                    out.print("<h3 style='text-align:center;color:gray;'>No products found in your inventory.</h3>");
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                out.print("<h3 style='color:red;text-align:center;'>Error: " + e.getMessage() + "</h3>");
            }
        }
    %>
</div>

</body>
</html>
