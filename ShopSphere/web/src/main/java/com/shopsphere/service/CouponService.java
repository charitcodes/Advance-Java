package com.shopsphere.service;

import com.shopsphere.dao.CouponDAO;
import com.shopsphere.model.Coupon;

import java.util.List;

public class CouponService {

    private CouponDAO couponDAO;

    public CouponService() {
        couponDAO = new CouponDAO();
    }


    // =========================
    // CUSTOMER COUPON VALIDATION
    // =========================

    public Coupon getCouponByCode(String code) {
        return couponDAO.getCouponByCode(code);
    }


    // =========================
    // ADMIN - GET ALL COUPONS
    // =========================

    public List<Coupon> getAllCoupons() {
        return couponDAO.getAllCoupons();
    }


    // =========================
    // ADMIN - GET BY ID
    // =========================

    public Coupon getCouponById(int couponId) {
        return couponDAO.getCouponById(couponId);
    }


    // =========================
    // ADMIN - ADD
    // =========================

    public boolean addCoupon(Coupon coupon) {
        return couponDAO.addCoupon(coupon);
    }


    // =========================
    // ADMIN - UPDATE
    // =========================

    public boolean updateCoupon(Coupon coupon) {
        return couponDAO.updateCoupon(coupon);
    }


    // =========================
    // ADMIN - DELETE
    // =========================

    public boolean deleteCoupon(int couponId) {
        return couponDAO.deleteCoupon(couponId);
    }


    // =========================
    // ADMIN - STATUS
    // =========================

    public boolean updateCouponStatus(
            int couponId,
            boolean status) {

        return couponDAO.updateCouponStatus(
                couponId,
                status
        );
    }
}