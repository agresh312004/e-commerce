<%@ page import="java.io.*, java.sql.*" %>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("Email") == null) {
        response.sendRedirect("Sellerlog.jsp");
        return;
    }

    String seller = ((String) session.getAttribute("Email")).replaceAll("@gmail.com", "").toUpperCase().trim();
    String sellerSafe = seller.replaceAll("[^a-zA-Z0-9]", "_");

    String idStr = request.getParameter("id");
    String imagePath = request.getParameter("imagePath");

    if (idStr == null || idStr.isEmpty()) {
        out.print("Invalid Product!");
        return;
    }

    int id = Integer.parseInt(idStr);

    // ? FIX: Use absolute base path to the web folder
    if (imagePath != null && !imagePath.isEmpty()) {
        String basePath = "C:\\Users\\DAKSH\\OneDrive\\Documents\\NetBeansProjects\\Minor_Project\\web\\";
        String realPath = basePath + imagePath.replace("/", File.separator);
        File file = new File(realPath);
        if (file.exists()) {
            boolean deleted = file.delete();
            out.println("Image deleted: " + deleted);
        } else {
            out.println("File not found: " + realPath);
        }
    }

    // Delete from DB
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?useSSL=false", "root", "root");
        String query = "DELETE FROM seller_" + sellerSafe + " WHERE id=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, id);
        int result = ps.executeUpdate();

        if (result > 0) {
            out.print("<script>alert('Product deleted successfully!'); window.location='View_Products.jsp';</script>");
        } else {
            out.print("<script>alert('Delete failed!'); window.location='View_Products.jsp';</script>");
        }

        ps.close();
        con.close();
    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
