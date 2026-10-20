package com.shopsphere.dao;

import com.shopsphere.model.Coupon;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO {

    // =========================
    // GET COUPON BY CODE
    // =========================

    public Coupon getCouponByCode(String code) {

        Coupon coupon = null;

        String sql =
                "SELECT * FROM coupons " +
                "WHERE UPPER(code) = UPPER(?) " +
                "AND status = TRUE " +
                "AND (expiry_date IS NULL OR expiry_date >= CURDATE())";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, code);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    coupon = mapCoupon(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return coupon;
    }


    // =========================
    // GET ALL COUPONS
    // =========================

    public List<Coupon> getAllCoupons() {

        List<Coupon> coupons = new ArrayList<>();

        String sql =
                "SELECT * FROM coupons " +
                "ORDER BY coupon_id DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                coupons.add(mapCoupon(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return coupons;
    }


    // =========================
    // GET COUPON BY ID
    // =========================

    public Coupon getCouponById(int couponId) {

        Coupon coupon = null;

        String sql =
                "SELECT * FROM coupons " +
                "WHERE coupon_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, couponId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    coupon = mapCoupon(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return coupon;
    }


    // =========================
    // ADD COUPON
    // =========================

    public boolean addCoupon(Coupon coupon) {

        String sql =
                "INSERT INTO coupons " +
                "(code, discount_type, discount_value, minimum_order, " +
                "maximum_discount, expiry_date, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, coupon.getCode());
            ps.setString(2, coupon.getDiscountType());
            ps.setDouble(3, coupon.getDiscountValue());
            ps.setDouble(4, coupon.getMinimumOrder());
            ps.setDouble(5, coupon.getMaximumDiscount());

            if (coupon.getExpiryDate() == null ||
                coupon.getExpiryDate().trim().isEmpty()) {

                ps.setNull(6, java.sql.Types.DATE);

            } else {

                ps.setString(6, coupon.getExpiryDate());
            }

            ps.setBoolean(7, coupon.isStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // UPDATE COUPON
    // =========================

    public boolean updateCoupon(Coupon coupon) {

        String sql =
                "UPDATE coupons SET " +
                "code = ?, " +
                "discount_type = ?, " +
                "discount_value = ?, " +
                "minimum_order = ?, " +
                "maximum_discount = ?, " +
                "expiry_date = ?, " +
                "status = ? " +
                "WHERE coupon_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, coupon.getCode());
            ps.setString(2, coupon.getDiscountType());
            ps.setDouble(3, coupon.getDiscountValue());
            ps.setDouble(4, coupon.getMinimumOrder());
            ps.setDouble(5, coupon.getMaximumDiscount());

            if (coupon.getExpiryDate() == null ||
                coupon.getExpiryDate().trim().isEmpty()) {

                ps.setNull(6, java.sql.Types.DATE);

            } else {

                ps.setString(6, coupon.getExpiryDate());
            }

            ps.setBoolean(7, coupon.isStatus());
            ps.setInt(8, coupon.getCouponId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // DELETE COUPON
    // =========================

    public boolean deleteCoupon(int couponId) {

        String sql =
                "DELETE FROM coupons " +
                "WHERE coupon_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setInt(1, couponId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // ACTIVATE / DEACTIVATE
    // =========================

    public boolean updateCouponStatus(
            int couponId,
            boolean status) {

        String sql =
                "UPDATE coupons SET status = ? " +
                "WHERE coupon_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setBoolean(1, status);
            ps.setInt(2, couponId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================
    // MAP RESULT SET
    // =========================

    private Coupon mapCoupon(ResultSet rs)
            throws Exception {

        Coupon coupon = new Coupon();

        coupon.setCouponId(
                rs.getInt("coupon_id")
        );

        coupon.setCode(
                rs.getString("code")
        );

        coupon.setDiscountType(
                rs.getString("discount_type")
        );

        coupon.setDiscountValue(
                rs.getDouble("discount_value")
        );

        coupon.setMinimumOrder(
                rs.getDouble("minimum_order")
        );

        double maximumDiscount =
                rs.getDouble("maximum_discount");

        if (rs.wasNull()) {
            coupon.setMaximumDiscount(0);
        } else {
            coupon.setMaximumDiscount(maximumDiscount);
        }

        coupon.setExpiryDate(
                rs.getString("expiry_date")
        );

        coupon.setStatus(
                rs.getBoolean("status")
        );

        return coupon;
    }
}