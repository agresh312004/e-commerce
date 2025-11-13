<%@page import= "java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page import="java.sql.*" %>
<%
   String s1=request.getParameter("Name");
   String s2=request.getParameter("CNo");
   String s3=request.getParameter("Password");
   String s4=request.getParameter("Email");
  
   try
   {
       Class.forName("com.mysql.cj.jdbc.Driver");
       Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
       
       Statement st=con.createStatement();
       st.executeUpdate("insert into BRegister values('"+s1+"','"+s2+"','"+s3+"','"+s4+"')");
       out.print("Data Inserted");
       response.sendRedirect("BuyerLog.jsp");
       con.close();
      
      
       
   }
   catch(SQLIntegrityConstraintViolationException e1)
   {
      out.print("Duplicate Email");
      request.setAttribute("error", "Duplicate Email!!!");
      request.setAttribute("Name",s1);
      request.setAttribute("CNo",s2); 
      request.setAttribute("Password",s3);
      request.setAttribute("Email",s4);
      
        RequestDispatcher rd = request.getRequestDispatcher("BRegister.jsp"); 
        rd.forward(request, response);
   }
   catch(Exception e)
   {
       out.print(e);
   }
%>