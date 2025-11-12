<%@ page import="java.util.*, javax.servlet.http.*" %>
<%@ page import="Minor_Project.*" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String imagePath = request.getParameter("imagePath");
    String priceStr = request.getParameter("price");
    String expiry = request.getParameter("expiry");
    String qtyStr = request.getParameter("quantity");

    int addQty = 1;
    if(qtyStr != null && !qtyStr.trim().isEmpty()) {
        try { addQty = Integer.parseInt(qtyStr); if(addQty < 1) addQty = 1; } catch(Exception ex){ addQty = 1; }
    }

    HttpSession sessionObj = request.getSession(true);
    List<Product> cart = (List<Product>) sessionObj.getAttribute("cart");
    if(cart == null) cart = new ArrayList<Product>();

    String xreq = request.getHeader("X-Requested-With");

    if(name != null && !name.trim().isEmpty() && priceStr != null && !priceStr.trim().isEmpty())
    {
        double price = 0;
        try{ price = Double.parseDouble(priceStr); } catch(Exception ex)
        {}
            
        boolean found = false;
        for(Product p : cart){
            if(p.getName().equalsIgnoreCase(name)){
                p.setQuantity(p.getQuantity() + addQty);
                found = true;
                break;
            }
        }

        if(!found){
            cart.add(new Product(name, imagePath, addQty, price, expiry));
        }

        sessionObj.setAttribute("cart", cart);

        int currentQty = 0;
        for(Product p : cart)
            if(p.getName().equalsIgnoreCase(name))
                currentQty = p.getQuantity();

        if("XMLHttpRequest".equals(xreq)){
            out.print("{\"status\":\"ok\",\"currentQuantity\":"+currentQty+"}");
        } else {
            response.sendRedirect("cart.jsp");
        }
    } else {
        if("XMLHttpRequest".equals(xreq)){
            out.print("{\"status\":\"error\",\"message\":\"Missing parameters: name or price\"}");
        } else {
            response.sendRedirect("Customer_interface.jsp");
        }
    }
%>
