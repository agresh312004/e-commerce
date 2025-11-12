<%@ page import="java.sql.*" %>
<%
    // Get customer email from session
    session = request.getSession(false);
    if (session == null || session.getAttribute("Customer_name") == null) {
        response.sendRedirect("BuyerLog.jsp");
        return;
    }
    String email = (String) session.getAttribute("Customer_name"); // customer email
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Payment</title>
<style>
body { font-family: Poppins,sans-serif; background:#f9fafc; text-align:center; padding:40px; }
#loading {
    display:none;
    position:fixed; top:0; left:0;
    width:100%; height:100%;
    background: rgba(255,255,255,0.9);
    text-align:center; padding-top:200px;
    font-size:24px; color:#007bff;
}
button { background:#007bff; color:white; border:none; padding:10px 20px; border-radius:6px; cursor:pointer; }
button:hover { background:#0056b3; }
input { width:200px; padding:10px; font-size:16px; border-radius:6px; border:1px solid #ccc; text-align:right; }
</style>
<script>
// Store JSP session email into JS variable
var customerEmail = "<%= email %>";

// Called when user clicks Send Payment Request
function startPayment() {
    const amount = document.getElementById('amount').value.trim();

    // Validate number
    if(amount === "" || isNaN(amount) || Number(amount) <= 0) {
        alert("Please enter a valid number");
        return;
    }

    document.getElementById('loading').style.display = 'block';

    // Send data to backend without reloading page
    fetch('SendRequest.jsp', {
        method: 'POST',
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body: "email=" + encodeURIComponent(customerEmail) + "&message=" + encodeURIComponent(amount)
    })
    .then(res => res.text())
    .then(() => checkStatus()) // start checking approval
    .catch(err => {
        document.getElementById('loading').innerHTML = "Error sending request!";
        console.error(err);
    });
}

// Check database every 3 seconds for status
function checkStatus() {
    fetch('CheckStatus.jsp')
    .then(res => res.text())
    .then(status => {
        if(status.trim() === 'Approved') {
            document.getElementById('loading').innerHTML = "? Transaction Completed!";
        } else if(status.trim() === 'Error') {
            document.getElementById('loading').innerHTML = "? Error: Session expired!";
        } else {
            setTimeout(checkStatus, 3000); // check again after 3s
        }
    })
    .catch(err => {
        document.getElementById('loading').innerHTML = "Error checking status!";
        console.error(err);
    });
}
</script>
</head>
<body>

<h2>? Seller Payment Portal</h2>

<input type="number" id="amount" placeholder="Enter Amount"  required>
<br><br>
<button onclick="startPayment()">Send Payment Request</button>

<div id="loading">? Waiting for Admin Confirmation...</div>

</body>
</html>
