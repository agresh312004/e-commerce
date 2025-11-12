<%@ page import="java.sql.*" %>
<%@ page contentType="text/plain;charset=UTF-8" %>
<%
    // Get customer email from session
    session = request.getSession(false);
    if (session == null || session.getAttribute("Customer_name") == null) {
        out.print("Error"); // session expired or not logged in
        return;
    }

    String email = (String) session.getAttribute("Customer_name");
    String status = "Pending"; // default

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false",
            "root", "root"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT status FROM admin_confirmations WHERE customer_email=? ORDER BY id DESC LIMIT 1"
        );
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            status = rs.getString("status"); // get latest status
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        status = "Error: " + e.getMessage();
    }

    out.print(status); // send status back to customer page
%>
