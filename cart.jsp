<%@ page import="java.util.*, Product.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart</title>
<style>
body {
    font-family: Poppins, sans-serif;
    background: linear-gradient(135deg, #e0f7fa, #fff);
    padding: 20px;
}
h2 {
    text-align: center;
}
.card {
    background: #fff;
    border-radius: 12px;
    padding: 15px;
    margin: 15px auto;
    width: 300px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    text-align: center;
}
.card img {
    width: 120px;
    height: 120px;
    object-fit: contain;
}
button {
    background: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    cursor: pointer;
}
button:hover {
    background: #0056b3;
}
</style>
</head>

<body>
<h2>🛒 Your Cart</h2>

<%
    ArrayList orderList = (ArrayList) session.getAttribute("orderList");
    boolean hasItems = false;

    if (orderList != null) {
        for (int i = 0; i < orderList.size(); i++) {
            Product p = (Product) orderList.get(i);
            if (p.getSelect() && p.getQuantitySelected() > 0) {
                hasItems = true;
%>
                <div class="card">
                    <img src="<%= p.getImagePath() + "/" + p.getImageName() %>" alt="<%= p.getName() %>">
                    <h3><%= p.getName() %></h3>
                    <p>Category: <%= p.getCategory() %></p>
                    <p>Quantity: <%= p.getQuantitySelected() %></p>
                    <p>Price per item: ₹<%= p.getPrice() %></p>
                    <p><b>Total: ₹<%= p.getPrice() * p.getQuantitySelected() %></b></p>
                    <p>Expiry: <%= p.getExpiry() %></p>
                </div>
<%
            }
        }
    }

    if (!hasItems) {
%>
        <h3 align="center">🛍️ Your cart is empty!</h3>
<%
    }
%>

<div style="text-align:center; margin-top:20px;">
    <button onclick="window.location.href='Customer_interface.jsp'">← Continue Shopping</button>
</div>

</body>
</html>
