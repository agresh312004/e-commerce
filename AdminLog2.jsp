<%@ page import="java.sql.*" %>
<%
    // Retrieve parameters from the login form
    String email = request.getParameter("Email").replaceAll("@gmail.com","").trim();
    String password = request.getParameter("Password");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // 1. Load the JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 2. Establish Connection
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false",
            "root", "root"
        );
        
        // 3. Prepare SQL Statement using placeholders (?) for security
        // We select the 'Name' column to save it in the session.
        String sql = "SELECT Email_id,Password FROM admin WHERE Email_id = ? AND Password = ?";
        ps = con.prepareStatement(sql);
        
        // Set the parameters
        ps.setString(1, email);
        ps.setString(2, password);
        
        // 4. Execute Query
        rs = ps.executeQuery();
        
        if (rs.next()) 
        {
            // Login Successful
            
            
            // Set the customer's name in the session
            session.setAttribute("Admin_name", email);
            
            out.println("Login successful. Data Found.");
            
            // Redirect to the customer interface
            response.sendRedirect("Admin_interface.jsp");
        } 
        else {
            // Login Failed
            out.println("INVALID EMAIL OR PASSWORD");
        }
        
    }
    catch(Exception e)
    {
        out.println("An error occurred: " + e.getMessage());
    } finally {
        // 5. Close resources to prevent leaks
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
        try { if (con != null) con.close(); } catch (SQLException ignored) {}
    }
%>
