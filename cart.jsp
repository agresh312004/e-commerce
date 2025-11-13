<%@ page import="java.util.*, Product.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session check
    session = request.getSession(false);
    if (session == null || session.getAttribute("Customer_name") == null) {
        response.sendRedirect("BuyerLog.jsp");
        return;
    }

    ArrayList<Product> orderList = (ArrayList<Product>) session.getAttribute("orderList");

    // Handle remove via AJAX
    String removeIdStr = request.getParameter("removeId");
    if(removeIdStr != null) {
        int removeId = Integer.parseInt(removeIdStr);
        if(orderList != null) {
            for(Product p : orderList) {
                if(p.getProductId() == removeId) {
                    // Mark as deselected
                    p.setSelect(false);
                    p.setQuantitySelected(0);
                    break;
                }
            }
            session.setAttribute("orderList", orderList); // update session
        }
        out.print("success");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart</title>
<style>
body { font-family:Poppins,sans-serif; background:#e0f7fa; padding:20px; margin:0;}
h2 { text-align:center; margin-bottom:30px; }
.card { background:#fff; border-radius:12px; padding:15px; margin:15px auto; width:320px; box-shadow:0 4px 12px rgba(0,0,0,0.1); text-align:center; }
.card img { width:150px; height:150px; object-fit:contain; border-radius:8px; }
.remove-btn { background:red; color:white; border:none; border-radius:6px; padding:8px 15px; cursor:pointer; margin-top:10px; display:block; width:80%; margin:auto; }
.remove-btn:hover { background:#b71c1c; }
button { background:#007bff; color:white; border:none; padding:10px 20px; border-radius:6px; cursor:pointer; margin-top:15px; }
button:hover { background:#0056b3; }
.total-amount { font-weight:bold; font-size:18px; margin-top:20px; color:#0d47a1; text-align:center; }
.empty-msg { text-align:center; font-size:18px; color:#555; margin-top:50px; }
#proceed-btn { display:block; margin:20px auto; }
</style>

<script>
function removeProduct(productId) {
    fetch('cart.jsp?removeId=' + productId)
    .then(res => res.text())
    .then(data => {
        if(data.trim() === "success") {
            // Remove card from DOM
            const card = document.querySelector('.card[data-id="' + productId + '"]');
            if(card) card.remove();
            recalcTotal();
        }
    });
}

function recalcTotal() {
    let total = 0;
    let selectedCount = 0;
    const cards = document.querySelectorAll('.card');

    cards.forEach(card => {
        const price = parseInt(card.dataset.price);
        const qty = parseInt(card.dataset.qty);
        if(qty > 0) selectedCount++;
        total += price * qty;
    });

    const totalElem = document.getElementById('total-amount');
    const proceedBtn = document.getElementById('proceed-btn');

    if(totalElem) totalElem.innerText = "Total Cart Amount: ₹" + total;

    if(selectedCount === 0) {
        if(proceedBtn) proceedBtn.style.display = 'none';
        if(totalElem) totalElem.style.display = 'none';
        if(!document.querySelector('.empty-msg')) {
            const emptyDiv = document.createElement('div');
            emptyDiv.className = 'empty-msg';
            emptyDiv.innerText = "🛍️ Your cart is empty!";
            document.body.insertBefore(emptyDiv, document.body.firstChild.nextSibling);
        }
    } else {
        if(proceedBtn) proceedBtn.style.display = 'block';
        if(totalElem) totalElem.style.display = 'block';
    }
}
</script>
</head>
<body>

<h2>🛒 Your Cart</h2>

<%
boolean hasItems = false;
if(orderList != null) {
    for(Product p : orderList) {
        if(p.getSelect() && p.getQuantitySelected() > 0) {
            hasItems = true;
%>
<div class="card" data-id="<%=p.getProductId()%>" data-price="<%=p.getPrice()%>" data-qty="<%=p.getQuantitySelected()%>">
    <img src="<%=p.getImagePath() + "/" + p.getImageName()%>" alt="<%=p.getName()%>">
    <h3><%=p.getName()%></h3>
    <p>Category: <%=p.getCategory()%></p>
    <p>Quantity: <%=p.getQuantitySelected()%></p>
    <p>Price per item: ₹<%=p.getPrice()%></p>
    <p><b>Total: ₹<%=p.getPrice() * p.getQuantitySelected()%></b></p>
    <p>Expiry: <%=p.getExpiry()%></p>

    <!-- Remove button BELOW product -->
    <button class="remove-btn" onclick="removeProduct('<%=p.getProductId()%>')">✖ Remove</button>
</div>
<%
        }
    }
}
%>

<%
if(hasItems) {
%>
<div class="total-amount" id="total-amount">
<%
    int totalAmount = 0;
    for(Product p : orderList) {
        if(p.getSelect() && p.getQuantitySelected() > 0)
            totalAmount += p.getPrice() * p.getQuantitySelected();
    }
%>
Total Cart Amount: ₹<%= totalAmount %>
</div>

<!-- Proceed to Payment button -->
<div>
    <form action="Payment_Page.jsp" method="get">
        <button id="proceed-btn" type="submit">💳 Proceed to Payment</button>
    </form>
</div>
<%
} else {
%>
<div class="empty-msg">🛍️ Your cart is empty!</div>
<%
}
%>

<div style="text-align:center; margin-top:20px;">
    <button onclick="window.location.href='Customer_interface.jsp'">← Continue Shopping</button>
</div>

</body>
</html>
