<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>

    <style>
        /* ---------------------- BACKGROUND ---------------------- */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('4aa8f45f74b347302309da315df7ce2d.jpg') no-repeat center center/cover,
                        linear-gradient(135deg, #2193b0, #6dd5ed); /* Image + gradient */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* ---------------------- FORM CONTAINER ---------------------- */
        .form-container {
            background: rgba(255, 255, 255, 0.25); /* Transparent white */
            backdrop-filter: blur(10px); /* Frosted glass effect */
            -webkit-backdrop-filter: blur(10px);
            padding: 30px 40px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            width: 400px;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* ---------------------- HEADING ---------------------- */
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #fff;
            text-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }

        /* ---------------------- LABELS ---------------------- */
        label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #f1f1f1;
            display: block;
        }

        /* ---------------------- INPUTS ---------------------- */
        input[type="text"],
        input[type="number"],
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            font-size: 14px;
            box-sizing: border-box;
            background: rgba(255, 255, 255, 0.6);
            color: #333;
        }

        input:focus {
            outline: none;
            border-color: #2193b0;
            background: rgba(255, 255, 255, 0.9);
        }

        /* ---------------------- BUTTON ---------------------- */
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #2193b0, #6dd5ed);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
            font-weight: bold;
        }

        button:hover {
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            color: #000;
        }

        /* ---------------------- ERROR ---------------------- */
        .error {
            color: #ff6b6b;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        /* ---------------------- RESPONSIVE ---------------------- */
        @media (max-width: 450px) {
            .form-container {
                width: 90%;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<div class="form-container">
<%
session = request.getSession(false);
if(session == null || session.getAttribute("Email") == null){
    out.print("<div class='error'>Session expired. Please login again!</div>");
    response.sendRedirect("Sellerlog.jsp");
    return;
}

String seller = ((String) session.getAttribute("Email")).replaceAll("@gmail.com", "").toUpperCase().trim();
String sellerSafe = seller.replaceAll("[^a-zA-Z0-9]", "_");

String idStr = request.getParameter("id");
if (idStr == null || idStr.isEmpty()) {
    out.print("<div class='error'>No product selected!</div>");
    return;
}

int id = Integer.parseInt(idStr);

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/Seller?useSSL=false",
        "root", "root"
    );

    String query = "SELECT * FROM seller_" + sellerSafe + " WHERE id=?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
%>

    <h2>Update Product 🛍️</h2>
    <form action="Update_Product_database.jsp" method="post">
        <input type="hidden" name="id" value="<%= id %>">

        <label for="name">Name</label>
        <input type="text" id="name" name="name" value="<%= rs.getString("Name") %>" required>

        <label for="category">Category</label>
        <input type="text" id="category" name="category" value="<%= rs.getString("Category") %>" required>

        <label for="quantity">Quantity</label>
        <input type="number" id="quantity" name="quantity" value="<%= rs.getInt("Quantity") %>" required>

        <label for="price">Price</label>
        <input type="number" id="price" name="price" value="<%= rs.getInt("Price") %>" required>

        <label for="expiry">Expiry</label>
        <input type="date" id="expiry" name="expiry" value="<%= rs.getString("Expiry") %>" required>

        <button type="submit">Update Product</button>
    </form>

<%
    } else {
        out.print("<div class='error'>Product not found!</div>");
    }
    rs.close();
    ps.close();
    con.close();
} catch(Exception e) {
    out.print("<div class='error'>Error: " + e.getMessage() + "</div>");
}
%>
</div>

</body>
</html>
