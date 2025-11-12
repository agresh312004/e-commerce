<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain;charset=UTF-8" %>
<%
String email = request.getParameter("email");
String message = request.getParameter("message");

if(email == null || message == null || email.isEmpty() || message.isEmpty()) {
    out.print("Error: Missing parameters");
    return;
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false", "root", "root"
    );

    PreparedStatement ps = con.prepareStatement(
        "INSERT INTO admin_confirmations (customer_email, message, status) VALUES (?, ?, 'Pending')"
    );
    ps.setString(1, email);
    ps.setString(2, message);
    ps.executeUpdate();

    ps.close();
    con.close();

    // Respond back to customer page
    out.print("Inserted");

} catch(Exception e) {
    out.print("Error: " + e.getMessage());
}
%>
