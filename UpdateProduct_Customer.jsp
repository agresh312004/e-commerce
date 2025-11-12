<%@ page import="java.util.*, Product.*" %>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>

<%
String productName = request.getParameter("productName");
String tableName = request.getParameter("tableName");
int quantity = Integer.parseInt(request.getParameter("quantity"));
boolean select = Boolean.parseBoolean(request.getParameter("select"));

ArrayList orderList = (ArrayList) session.getAttribute("orderList");
if (orderList != null) {
    for (int i = 0; i < orderList.size(); i++) {
        Product p = (Product) orderList.get(i);
        if (p.getName().equals(productName) && p.getTableName().equals(tableName)) {
            p.setQuantitySelected(quantity);
            p.setSelect(select);

            // ✅ If quantity = 0, deselect it
            if (quantity == 0 || select==false ) {
                p.setSelect(false);
                p.setQuantitySelected(0);
            }

            orderList.set(i, p); // update session list
            break;
        }
    }
    session.setAttribute("orderList", orderList); // ✅ save back to session
}

out.print("Updated");
%>
