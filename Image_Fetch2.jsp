<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Find Image in Folder</title>
</head>
<body align="center">
    <h2>Find Image from Photos Folder</h2>

```
<form method="get" action="">
    <input type="text" name="Product_Name" placeholder="Enter image name (e.g. agresh_samosa.jpg)" required>
    <input type="text" name="Seller_Name" placeholder="Enter Seller Name (e.g. agresh)" required>
    <input type="submit" value="Find Image">
</form>
<br>
```
<%! 
    // Base folder inside web directory
    String BASE_UPLOAD_DIR = "Photos";
%>

<%
String s1 = request.getParameter("Product_Name");
String s2 = request.getParameter("Seller_Name");

if (s1 != null && s2 != null) {
    // for Security purpose and handling case sensetivity  
    s1= s1.replaceAll(" ","").toUpperCase();
    s2=s2.replaceAll(" ","").toUpperCase();
    
    // Database Connectivity
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false",
            "root", "root"
        );

        Statement st = con.createStatement();
        // searching Data
        String query = "SELECT * FROM images WHERE product_name='"+ s1 +"' AND path='"+BASE_UPLOAD_DIR+"/"+s2+"'  ";
        ResultSet rs = st.executeQuery(query);
        // if data is Finded
        
        if (rs.next()) {
            String imagePath = rs.getString("path")+"/" + rs.getString("name");
            out.print(imagePath);
         %>
         <br>
<%   
            out.print("Photos/ATHRAV/ATHRAV_uncle chips.jpg");
%>

            <h3>Image Found!</h3>
            <img src="Photos/ATHRAV/ATHRAV_uncle chips.jpg" width="300" height="300" alt="Image Preview">
            <img src="<%= imagePath %>" width="300" height="300" alt="Image Preview">
            <br><br>
            <a href="Image_Fetch2.jsp">Go to Practice Page</a>
<%
        } 
        else
        {
            out.print("<h3 style='color:red;'>Data Not Found</h3>"+BASE_UPLOAD_DIR+"/"+s2);
            out.print(" "+s1);
        }
        con.close();
    } catch (Exception e) {
        out.print("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    }
}
%>

</body>
</html>
