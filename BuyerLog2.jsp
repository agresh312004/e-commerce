<%-- 
    Document   : BuyerLog2
    Created on : 12 Sep, 2025, 7:36:10 PM
    Author     : DAKSH
--%>
<%@ page import="java.sql.*"  %>
<%
                String s1=request.getParameter("Email");
		String s2=request.getParameter("Password");
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
			
                       Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("Select * from bregister where Email_id='"+s1+"' AND Password='"+s2+"'");
			if(rs.next())
			{
                           out.println("Data Finded");
                           response.sendRedirect("Customer_interface.jsp");
			}
			else
			{  
				out.println("INVLAID NAME AND PASSWORD");
			}
			con.close();
		}
		catch(Exception e)
		{
			out.println(e);
		}
        out.println("Data inserted");

%>
