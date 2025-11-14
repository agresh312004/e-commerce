import java.io.*;
import java.nio.file.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;


@MultipartConfig
public class Seller_Add_Database extends HttpServlet
{
      // Base folder jaha saare seller folders banenge
    private static final String BASE_UPLOAD_DIR = "C:\\Users\\DAKSH\\OneDrive\\Documents\\NetBeansProjects\\Minor_Project\\web\\Photos";
    private static final String Database_url ="Photos";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        
        
        String message = "",message2="";
        
        // Making object of already define session object
        HttpSession session = request.getSession(false); // Get the existing session (if any) 
        if (session == null || session.getAttribute("Email") == null) 
        {
               response.sendRedirect("Sellerlog.jsp");
               return;
            }

        
      String seller = (String)session.getAttribute("Email");//( return type = object )
      
      //removing @gmail.com
       seller = seller.replaceAll("@gmail.com","").toUpperCase().trim();
       

       // sanitize seller name to avoid illegal characters in folder/file name
      String sellerSafe = seller.replaceAll("[^a-zA-Z0-9]", "_");
       
      String name=request.getParameter("name").replaceAll(" ","").toUpperCase();
      String category=request.getParameter("category");
      int quantity=Integer.parseInt(request.getParameter("quantity"));
      int price=Integer.parseInt(request.getParameter("price"));
      String expiry=request.getParameter("expiry");
  
      try
      {
           Part filePart = request.getPart("image");
            if (filePart == null || filePart.getSize() == 0)
            {
                throw new ServletException("No file uploaded");
            }

            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileName = sellerSafe + "_" + originalFileName;// BHANU_MILK.jpg
            

            // Create seller-specific folder if not exists
            File  sellerFolder = new File(BASE_UPLOAD_DIR, sellerSafe);
            if (!sellerFolder.exists()) {
                sellerFolder.mkdirs(); // folder create ho jaayega agar nahi hai
            }

            // Save file inside seller's folder
            File file = new File(sellerFolder, fileName);
            
             try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            message = "File uploaded successfully to folder: " + sellerFolder.getAbsolutePath();
            
        
            
             //data base Connnection
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Seller?autoReconnect=true&useSSL=false","root","root");
       
              Statement st=con.createStatement();
              String sql = "INSERT INTO seller_" + seller + " (Name,Category,Quantity,Image_Name,Image_Path,Price,Expiry) VALUES(?,?,?,?,?,?,?)";
              PreparedStatement ps = con.prepareStatement(sql);
              ps.setString(1, name);
              ps.setString(2,category);
              ps.setInt(3,quantity);
              ps.setString(4,fileName);
              ps.setString(5, Database_url+"/"+seller);
              ps.setInt(6,price);
              ps.setString(7,expiry);
              int x = ps.executeUpdate();
              message2 = "Data Inserted into database";
             response.sendRedirect("Seller_Interface.jsp");

      
      }
      catch(Exception e)
      {
        message = "ERROR: " + e.getMessage();
            e.printStackTrace();
      }
      
           
    }
      
}
