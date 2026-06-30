package kr.ac.kopo.beauty.vo;

public class ProductVO {

    private int productId;
    private String productName;
    private String brandName;
    private int price;
    private int originalPrice;
    private int discountRate;
    private String productUrl;

    // 통계용 부가 필드 (집계 쿼리 결과 매핑)
    private double avgRating;
    private int reviewCount;

    public ProductVO() {}

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(int originalPrice) { this.originalPrice = originalPrice; }

    public int getDiscountRate() { return discountRate; }
    public void setDiscountRate(int discountRate) { this.discountRate = discountRate; }

    public String getProductUrl() { return productUrl; }
    public void setProductUrl(String productUrl) { this.productUrl = productUrl; }

    public double getAvgRating() { return avgRating; }
    public void setAvgRating(double avgRating) { this.avgRating = avgRating; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }

    @Override
    public String toString() {
        return "ProductVO [productId=" + productId + ", productName=" + productName
                + ", brandName=" + brandName + ", price=" + price + "]";
    }
}
