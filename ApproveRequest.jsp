<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    // Get the ID of the request from form
    String idParam = request.getParameter("id");
    if(idParam == null) {
        out.print("Error: Missing ID");
        return;
    }
    
    int id = Integer.parseInt(idParam);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/seller?autoReconnect=true&useSSL=false",
            "root", "root"
        );

        PreparedStatement ps = con.prepareStatement(
            "UPDATE admin_confirmations SET status='Approved' WHERE id=?"
        );
        ps.setInt(1, id);
        ps.executeUpdate();

        ps.close();
        con.close();

        // Redirect back to admin page
        response.sendRedirect("AdminConfirm.jsp");

    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
