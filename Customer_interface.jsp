<%@ page import="java.sql.*, java.util.*, Product.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer Shopping Interface</title>

<style>
body {
    font-family: Poppins, sans-serif;
    background: linear-gradient(135deg, #f0f8ff, #ffffff);
    margin: 0;
    padding: 0;
}
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #007bff;
    color: white;
    padding: 12px 20px;
}
.top-bar h1 {
    margin: 0;
    font-size: 22px;
}
.profile-btn {
    background-color: white;
    color: #007bff;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
}
.filter-bar {
    text-align: center;
    margin-top: 15px;
}
.filter-bar select {
    padding: 8px 12px;
    border-radius: 6px;
    border: 1px solid #007bff;
    font-size: 15px;
}
.container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
    padding: 20px;
}
.card {
    background: #fff;
    border-radius: 12px;
    padding: 15px;
    text-align: center;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    position: relative;
}
.card img {
    width: 100%;
    height: 150px;
    object-fit: contain;
}
button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 15px;
    border-radius: 6px;
    cursor: pointer;
}
button:hover {
    background-color: #0056b3;
}
.quantity-control {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
}
.quantity-control button {
    background-color: #ddd;
    color: #333;
    border: none;
    width: 30px;
    height: 30px;
    border-radius: 4px;
    font-size: 18px;
}
.status {
    font-size: 14px;
    color: green;
    margin-top: 5px;
}
</style>
</head>

<body>

<div class="top-bar">
    <h1>🛍️ Customer Shopping Interface</h1>
    <button class="profile-btn" onclick="window.location.href='Profile.jsp'">Profile</button>
</div>

<div class="filter-bar">
    <form method="get" action="Customer_interface.jsp">
        <label for="category">Filter by Category: </label>
        <select name="category" id="category" onchange="this.form.submit()">
            <option value="All">All</option>
            <option value="Dairy Products" <%= "Dairy".equals(request.getParameter("category")) ? "selected" : "" %>>Dairy</option>
            <option value="Daily" <%= "Daily".equals(request.getParameter("category")) ? "selected" : "" %>>Daily</option>
            <option value="Cosmetic" <%= "Cosmetic".equals(request.getParameter("category")) ? "selected" : "" %>>Cosmetic</option>
            <option value="Grocery" <%= "Grocery".equals(request.getParameter("category")) ? "selected" : "" %>>Grocery</option>
        </select>
    </form>
</div>

<!-- ✅ Product Display -->
<div class="container">
<%
    ArrayList orderList = (ArrayList) session.getAttribute("orderList");
    if (orderList == null) {
        orderList = new ArrayList();
        session.setAttribute("orderList", orderList);
    }

    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null || "All".equals(selectedCategory)) {
        selectedCategory = "All";
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false",
        "root", "root"
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT Email_id FROM sregister");

    while (rs.next()) {
        String sellerName = rs.getString("Email_id");
        String tableName = "seller_" + sellerName;

        try {
            String query = "SELECT Name, Category, Quantity, Image_Name, Image_Path, Price, Expiry FROM `" + tableName + "`";
            if (!"All".equals(selectedCategory)) {
                query += " WHERE Category = ?";
            }

            PreparedStatement ps = con.prepareStatement(query);
            if (!"All".equals(selectedCategory)) {
                ps.setString(1, selectedCategory);
            }

            ResultSet rs2 = ps.executeQuery();

            while (rs2.next()) {
                String name = rs2.getString("Name");
                String category = rs2.getString("Category");
                int quantity = rs2.getInt("Quantity");
                String imageName = rs2.getString("Image_Name");
                String imagePath = rs2.getString("Image_Path");
                int price = rs2.getInt("Price");
                String expiry = rs2.getString("Expiry");
                String fullPath = imagePath + "/" + imageName;

                Product existing = null;
                for (int i = 0; i < orderList.size(); i++) {
                    Product p = (Product) orderList.get(i);
                    if (p.getName().equals(name) && p.getTableName().equals(tableName)) {
                        existing = p;
                        break;
                    }
                }

                if (existing == null) {
                    Product article = new Product(tableName, name, category, quantity, imageName, imagePath, price, expiry);
                    article.setSelect(false);
                    article.setQuantitySelected(0);
                    orderList.add(article);
                    existing = article;
                }

                boolean selected = existing.getSelect();
                int selectedQty = existing.getQuantitySelected();
                boolean showAddButton = !selected || selectedQty <= 0;
%>
                <div class="card" data-name="<%= name %>" data-table="<%= tableName %>">
                    <img src="<%= fullPath %>" alt="<%= name %>">
                    <h3><%= name %></h3>
                    <p>Category: <%= category %></p>
                    <p>Price: ₹<%= price %></p>
                    <p>Expiry: <%= expiry %></p>
                    <p>Selected: <%= existing.getSelect() %></p>

                    <% if (showAddButton) { %>
                        <button class="addBtn" onclick="addToCart(this)">Add to Cart</button>
                        <div class="quantity-control" style="display:none;">
                            <button onclick="changeQty(this, -1)">−</button>
                            <span>1</span>
                            <button onclick="changeQty(this, 1)">+</button>
                        </div>
                        <div class="status"></div>
                    <% } else { %>
                        <button class="addBtn" onclick="addToCart(this)" style="display:none;">Add to Cart</button>
                        <div class="quantity-control">
                            <button onclick="changeQty(this, -1)">−</button>
                            <span><%= selectedQty %></span>
                            <button onclick="changeQty(this, 1)">+</button>
                        </div>
                        <div class="status">Quantity = <%= selectedQty %></div>
                    <% } %>
                </div>
<%
            }
        } catch (Exception e) {
            out.println("<div>Error loading seller data: " + e.getMessage() + "</div>");
        }
    }
    con.close();
%>
</div>

<div style="text-align:center; margin:20px;">
    <button onclick="window.location.href='cart.jsp'">🛒 See Your Cart</button>
</div>

<script>
function addToCart(btn) {
    const card = btn.closest(".card");
    const name = card.dataset.name;
    const table = card.dataset.table;
    const qtyDiv = card.querySelector(".quantity-control");
    const status = card.querySelector(".status");

    btn.style.display = "none";
    qtyDiv.style.display = "flex";
    status.textContent = "Quantity = 1";
    qtyDiv.querySelector("span").innerText = "1";

    updateServer(name, table, 1, true);
}

function changeQty(btn, delta) {
    const card = btn.closest(".card");
    const span = card.querySelector(".quantity-control span");
    let qty = parseInt(span.innerText) + delta;
    if (qty < 0) qty = 0;
    span.innerText = qty;

    const name = card.dataset.name;
    const table = card.dataset.table;
    const status = card.querySelector(".status");
    const addBtn = card.querySelector(".addBtn");

    if (qty <= 0) {
        card.querySelector(".quantity-control").style.display = "none";
        addBtn.style.display = "inline-block";
        status.textContent = "Removed from cart";
        updateServer(name, table, 0, false);
    } else {
        addBtn.style.display = "none";
        card.querySelector(".quantity-control").style.display = "flex";
        status.textContent = "Quantity = " + qty;
        updateServer(name, table, qty, true);
    }
}

function updateServer(name, table, qty, select) {
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "UpdateProduct_Customer.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(
        "productName=" + encodeURIComponent(name) +
        "&tableName=" + encodeURIComponent(table) +
        "&quantity=" + qty +
        "&select=" + select
    );
}
</script>

</body>
</html>
