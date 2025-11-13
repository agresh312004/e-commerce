<%@page import= "java.sql.SQLIntegrityConstraintViolationException" %>
<%@ page import="java.sql.*" %>
<%
   String s1=request.getParameter("Name");
   String s2=request.getParameter("CNo");
   String s3=request.getParameter("Password");
   String s4=request.getParameter("Email").replaceAll("@gmail.com","").trim();
  
   try
   {
       Class.forName("com.mysql.cj.jdbc.Driver");
       Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
       
       Statement st=con.createStatement();
       st.executeUpdate("insert into SRegister values('"+s1+"','"+s2+"','"+s3+"','"+s4+"')");
       out.print("Data Inserted");
       
       String Create_Database = "CREATE TABLE IF NOT EXISTS `" +"Seller_"+s4 + "` (" +
             "id INT AUTO_INCREMENT PRIMARY KEY, " +
             "Name VARCHAR(30), " +
             "Category VARCHAR(30), " +
             "Quantity INT, " +
             "Image_Name VARCHAR(30), " +
             "Image_Path VARCHAR(100), " +
             "Price INT, " +
             "Expiry DATE)";
       
       st.executeUpdate(Create_Database);

       response.sendRedirect("Sellerlog.jsp");
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
      
        RequestDispatcher rd = request.getRequestDispatcher("SRegister.jsp"); 
        rd.forward(request, response);
   }
   catch(Exception e)
   {
       out.print(e);
   }
%>