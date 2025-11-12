<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel - Payment Approvals</title>
<style>
body { font-family:Poppins,sans-serif; background:#f3f4f6; text-align:center; padding:40px; }
table { border-collapse:collapse; width:80%; margin:auto; background:white; }
th, td { border:1px solid #ccc; padding:10px; text-align:center; }
th { background:#007bff; color:white; }
button { padding:6px 12px; border:none; border-radius:6px; cursor:pointer; }
.approve { background:#28a745; color:white; }
.approve:hover { background:#1e7e34; }
</style>
</head>
<body>

<h2>💼 Admin - Customer Payment Requests</h2>

<table>
<tr>
    <th>ID</th>
    <th>Customer Email</th>
    <th>Message</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false",
        "root", "root"
    );
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM admin_confirmations ORDER BY id DESC");

    while(rs.next()) {
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("customer_email") %></td>
    <td><%= rs.getString("message") %></td>
    <td><%= rs.getString("status") %></td>
    <td>
        <% if("Pending".equals(rs.getString("status"))) { %>
            <form action="ApproveRequest.jsp" method="post">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <button class="approve">Approve ✅</button>
            </form>
        <% } else { %>
            Approved
        <% } %>
    </td>
</tr>
<%
    }
    rs.close();
    st.close();
    con.close();
} catch(Exception e) {
    out.println("<tr><td colspan='5'>Error: "+e.getMessage()+"</td></tr>");
}
%>
</table>
</body>
</html>
