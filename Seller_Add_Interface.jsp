<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #6dd5ed, #2193b0);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 400px;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .form-group input[type="file"] {
            padding: 3px;
        }
        
        .form-group select {
               width: 100%;
               padding: 10px;
               border-radius: 8px;
               border: 1px solid #ccc;
               font-size: 14px;
               background-color: white;
                           }


        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: #2193b0;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background-color: #6dd5ed;
            color: #000;
        }
    </style>
</head>
<body>
    <div class="form-container">
         <%
        session = request.getSession(false);
        if (session == null || session.getAttribute("Email") == null) {
            response.sendRedirect("Sellerlog.jsp");
            return;
        }
        %>
        <h2>Add New Item <%= ((String)session.getAttribute("Email")).replaceAll("@gmail.com","") %></h2>
        <form action="Seller_Add_Database" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="name">Item Name</label>
                <input type="text" name="name" id="name" placeholder="Enter item name" required>
            </div>

            <div class="form-group">
           <label for="category">Category</label>
           <select name="category" id="category" required>
           <option value="">-- Select Category --</option>
           <option value="Grocery">Grocery</option>
           <option value="Daily Products">Daily Products</option>
           <option value="Dairy Products">Dairy Products</option>
           <option value="Cosmetics Products">Cosmetics Products</option>
           </select>
           </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" name="quantity" id="quantity" placeholder="Enter quantity" required>
            </div>

            <div class="form-group">
                <label for="image">Item Image</label>
                <input type="file" name="image" id="image" accept="image/*" required>
            </div>
            <div class="form-group">
                <label for="price">Price</label>
                <input type="number" name="price" id="price" placeholder="Enter price" required>
            </div>

            <div class="form-group">
                <label for="expiry">Expiry Date</label>
                <input type="date" name="expiry" id="expiry" required>
            </div>

            <button type="submit" class="submit-btn">Add Item</button>
        </form>
    </div>
</body>
</html>
