<%@ page import= "java.sql.*" %>
<%
    String Email=request.getParameter("N1").replaceAll("@gmail.com","").trim() ;
    String Pass=request.getParameter("N2") ; 
    try
    {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
      
      Statement st = con.createStatement();
     ResultSet rs =  st.executeQuery(" Select * from SRegister where Email_id='"+Email+"' and Password='"+Pass+"' ");
     if(rs.next())
     {
       out.print("Data Finded");
          // Create a new session (if one doesn't exist)
    session = request.getSession(true); // true = create new if none exists

    // Optionally, you can force creation of a new session even if one exists
    session.invalidate(); // destroy current session
    session = request.getSession(true); // create a fresh session

    // Set some attributes
    session.setAttribute("Email",Email);
    response.sendRedirect("Seller_Interface.jsp");

     }
     else
     {
       out.print("Data not Finded");
     }
    }
    catch(Exception e)
    {
        out.print(e);
    }


%>