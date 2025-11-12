<%-- 
    Document   : invalid
    Created on : 7 Nov, 2025, 11:55:36 AM
    Author     : NARMADANCHAL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invalid User name and password</title>
    <script>
        alert("invalid user name and password");
    <%response.sendRedirect("BuyerLog.jsp");%> 
    </script>   
    </head>
    <body>
        <center>
        </center>
        </body>
</html>
