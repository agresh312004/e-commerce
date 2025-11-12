<%@ page import="java.util.*, Product.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>🛒 Cart Summary</title>
<style>
    body {
        font-family: Poppins, sans-serif;
        background: linear-gradient(135deg, #f0f8ff, #ffffff);
        margin: 0;
        padding: 0;
    }
    h2 {
        text-align: center;
        margin: 20px 0;
        color: #007bff;
    }
    table {
        width: 85%;
        margin: 0 auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border-radius: 12px;
        overflow: hidden;
    }
    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }
    th {
        background: #007bff;
        color: white;
        font-size: 16px;
    }
    img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
    }
    .total-row {
        font-weight: bold;
        font-size: 1.2em;
        background-color: #f8f9fa;
    }
    .back-btn {
        display: block;
        margin: 25px auto;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
    }
    .back-btn:hover {
        background-color: #0056b3;
    }
    .empty {
        text-align: center;
        font-size: 18px;
        color: gray;
        margin-top: 40px;
    }
</style>
</head>

<body>

<h2>Your Selected Products</h2>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("Customer_name") == null) {
        response.sendRedirect("BuyerLog.jsp");
        return;
    }

    ArrayList orderList = (ArrayList) session.getAttribute("orderList");
    double grandTotal = 0.0;

    if (orderList == null || orderList.isEmpty()) {
%>
        <p class="empty">🛍️ Your cart is empty. <a href="Customer_interface.jsp">Continue Shopping</a></p>
<%
    } else {
        boolean hasSelected = false;
%>
<table>
    <tr>
        <th>Image</th>
        <th>Product Name</th>
        <th>Category</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
    </tr>

<%
        for (Object obj : orderList) {
            Product p = (Product) obj;
            if (p.getSelect()) {
                hasSelected = true;
                int qty = p.getQuantitySelected();
                double price = p.getPrice();
                double total = price * qty;
                grandTotal += total;
                String imgPath = p.getImagePath() + "/" + p.getImageName();
%>
    <tr>
        <td><img src="<%= imgPath %>" alt="<%= p.getName() %>"></td>
        <td><%= p.getName() %></td>
        <td><%= p.getCategory() %></td>
        <td>₹<%= String.format("%.2f", price) %></td>
        <td><%= qty %></td>
        <td>₹<%= String.format("%.2f", total) %></td>
    </tr>
<%
            }
        }

        if (hasSelected) {
%>
    <tr class="total-row">
        <td colspan="5" style="text-align:right;">Grand Total:</td>
        <td>₹<%= String.format("%.2f", grandTotal) %></td>
    </tr>
</table>

<%
        } else {
%>
    <p class="empty">🛍️ You haven’t selected any products yet. <a href="Customer_interface.jsp">Continue Shopping</a></p>
<%
        }
    }
%>

<button class="back-btn" onclick="window.location.href='Customer_interface.jsp'">← Continue Shopping</button>
<button class="back-btn" onclick="window.location.href='Payment_Page.jsp'"> Procced to Payment </button>
</body>
</html>
