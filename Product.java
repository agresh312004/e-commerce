package Product;

public class Product {
    private int productId;         // ✅ New field for unique ID
    private String tableName;
    private String name;
    private String category;
    private int quantity;
    private String imageName;
    private String imagePath;
    private int price;
    private String expiry;
    private boolean select;
    private int quantitySelected;

    // ✅ Updated Constructor (added productId)
    public Product(int productId, String tableName, String name, String category, int quantity,
                   String imageName, String imagePath, int price, String expiry) {
        this.productId = productId;
        this.tableName = tableName;
        this.name = name;
        this.category = category;
        this.quantity = quantity;
        this.imageName = imageName;
        this.imagePath = imagePath;
        this.price = price;
        this.expiry = expiry;
        this.select = false;
        this.quantitySelected = 0;
    }

    // --- Getters ---
    public int getProductId() { return productId; }
    public String getTableName() { return tableName; }
    public String getName() { return name; }
    public String getCategory() { return category; }
    public int getQuantity() { return quantity; }
    public String getImageName() { return imageName; }
    public String getImagePath() { return imagePath; }
    public int getPrice() { return price; }
    public String getExpiry() { return expiry; }

    // --- Setters ---
    public void setSelect(boolean select) { this.select = select; }
    public boolean getSelect() { return select; }

    public void setQuantitySelected(int quantitySelected) {
        this.quantitySelected = quantitySelected;
    }
    public int getQuantitySelected() {
        return quantitySelected;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
