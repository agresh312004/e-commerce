<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    // Check session
    session = request.getSession(false);
    if(session == null || session.getAttribute("Email") == null){
        out.print("<h3 style='color:red'>Session expired. Please login again!</h3>");
        response.sendRedirect("Sellerlog.jsp");
        return;
    }

    String seller = ((String) session.getAttribute("Email")).replaceAll("@gmail.com","").toUpperCase().trim();
    String sellerSafe = seller.replaceAll("[^a-zA-Z0-9]", "_");

    // Get form parameters
    String idStr = request.getParameter("id");
    String name = request.getParameter("name");
    String category = request.getParameter("category");
    String quantityStr = request.getParameter("quantity");
    String priceStr = request.getParameter("price");
    String expiry = request.getParameter("expiry");

    // Validate parameters
    if(idStr == null || name == null || category == null || quantityStr == null || priceStr == null || expiry == null ||
       idStr.isEmpty() || name.isEmpty() || category.isEmpty() || quantityStr.isEmpty() || priceStr.isEmpty() || expiry.isEmpty()){
        out.print("<h3 style='color:red'>All fields are required!</h3>");
        return;
    }

    int id = Integer.parseInt(idStr);
    int quantity = Integer.parseInt(quantityStr);
    int price = Integer.parseInt(priceStr);

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/Seller?useSSL=false",
            "root","root"
        );

        // Update product based on id
        String query = "UPDATE seller_" + sellerSafe + " SET Name=?, Category=?, Quantity=?, Price=?, Expiry=? WHERE id=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, category);
        ps.setInt(3, quantity);
        ps.setInt(4, price);
        ps.setString(5, expiry);
        ps.setInt(6, id);

        int result = ps.executeUpdate();

        if(result > 0){
            out.print("<script>alert('Product updated successfully!'); window.location='View_Products.jsp';</script>");
        } else {
            out.print("<script>alert('Update failed!'); window.location='Update_Product.jsp';</script>");
        }

        ps.close();
        con.close();
    } catch(Exception e){
        out.print("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    }
%>
