package kr.ac.kopo.beauty.vo;

public class ReviewVO {

    private int reviewId;
    private int productId;
    private String productName;
    private String brandName;
    private String nickname;
    private String reviewDate;
    private double rating;
    private String skinTone;
    private String skinType;
    private String skinRaw;
    private String satisfaction;
    private String purchaseOption;
    private String reviewText;
    private int helpful;
    private String sentiment;

    public ReviewVO() {}

    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getReviewDate() { return reviewDate; }
    public void setReviewDate(String reviewDate) { this.reviewDate = reviewDate; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getSkinTone() { return skinTone; }
    public void setSkinTone(String skinTone) { this.skinTone = skinTone; }

    public String getSkinType() { return skinType; }
    public void setSkinType(String skinType) { this.skinType = skinType; }

    public String getSkinRaw() { return skinRaw; }
    public void setSkinRaw(String skinRaw) { this.skinRaw = skinRaw; }

    public String getSatisfaction() { return satisfaction; }
    public void setSatisfaction(String satisfaction) { this.satisfaction = satisfaction; }

    public String getPurchaseOption() { return purchaseOption; }
    public void setPurchaseOption(String purchaseOption) { this.purchaseOption = purchaseOption; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public int getHelpful() { return helpful; }
    public void setHelpful(int helpful) { this.helpful = helpful; }

    public String getSentiment() { return sentiment; }
    public void setSentiment(String sentiment) { this.sentiment = sentiment; }

    @Override
    public String toString() {
        return "ReviewVO [reviewId=" + reviewId + ", productId=" + productId
                + ", nickname=" + nickname + ", rating=" + rating + "]";
    }
}
