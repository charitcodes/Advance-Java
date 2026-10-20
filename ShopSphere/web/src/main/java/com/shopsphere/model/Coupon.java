package com.shopsphere.model;

public class Coupon {

    private int couponId;
    private String code;

    private String discountType;
    private double discountValue;

    private double minimumOrder;
    private double maximumDiscount;

    private String expiryDate;

    private boolean status;


    public Coupon() {
    }


    // =========================
    // COUPON ID
    // =========================

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }


    // =========================
    // CODE
    // =========================

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }


    // =========================
    // DISCOUNT TYPE
    // =========================

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }


    // =========================
    // DISCOUNT VALUE
    // =========================

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }


    // =========================
    // BACKWARD COMPATIBILITY
    // =========================
    // Existing checkout code may use getDiscount().
    // Keep it so existing functionality does not break.

    public double getDiscount() {
        return discountValue;
    }

    public void setDiscount(double discount) {
        this.discountValue = discount;
    }


    // =========================
    // MINIMUM ORDER
    // =========================

    public double getMinimumOrder() {
        return minimumOrder;
    }

    public void setMinimumOrder(double minimumOrder) {
        this.minimumOrder = minimumOrder;
    }


    // =========================
    // MAXIMUM DISCOUNT
    // =========================

    public double getMaximumDiscount() {
        return maximumDiscount;
    }

    public void setMaximumDiscount(double maximumDiscount) {
        this.maximumDiscount = maximumDiscount;
    }


    // =========================
    // EXPIRY DATE
    // =========================

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }


    // =========================
    // STATUS
    // =========================

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }


    // =========================
    // BACKWARD COMPATIBILITY
    // =========================
    // Existing checkout code may use isActive().

    public boolean isActive() {
        return status;
    }

    public void setActive(boolean active) {
        this.status = active;
    }
}