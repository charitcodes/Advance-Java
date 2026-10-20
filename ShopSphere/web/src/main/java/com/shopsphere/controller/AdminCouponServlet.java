package com.shopsphere.controller;

import com.shopsphere.model.Coupon;
import com.shopsphere.service.CouponService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/coupons")
public class AdminCouponServlet extends HttpServlet {

    private CouponService couponService;

    @Override
    public void init() {
        couponService = new CouponService();
    }


    // =========================
    // GET
    // =========================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null || session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );

            return;
        }


        String action = request.getParameter("action");


        // =========================
        // ADD COUPON PAGE
        // =========================

        if ("add".equalsIgnoreCase(action)) {

            request.getRequestDispatcher(
                    "/admin/coupon-form.jsp"
            ).forward(request, response);

            return;
        }


        // =========================
        // EDIT COUPON PAGE
        // =========================

        if ("edit".equalsIgnoreCase(action)) {

            try {

                int couponId = Integer.parseInt(
                        request.getParameter("id")
                );

                Coupon coupon =
                        couponService.getCouponById(couponId);

                if (coupon == null) {

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/coupons"
                    );

                    return;
                }

                request.setAttribute(
                        "coupon",
                        coupon
                );

                request.getRequestDispatcher(
                        "/admin/coupon-form.jsp"
                ).forward(request, response);

                return;

            } catch (NumberFormatException e) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/coupons"
                );

                return;
            }
        }


        // =========================
        // COUPON LIST
        // =========================

        List<Coupon> coupons =
                couponService.getAllCoupons();

        request.setAttribute(
                "coupons",
                coupons
        );

        request.getRequestDispatcher(
                "/admin/coupons.jsp"
        ).forward(request, response);
    }


    // =========================
    // POST
    // =========================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null || session.getAttribute("admin") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/login"
            );

            return;
        }


        String action = request.getParameter("action");


        try {

            // =========================
            // ADD
            // =========================

            if ("add".equalsIgnoreCase(action)) {

                Coupon coupon = new Coupon();

                coupon.setCode(
                        request.getParameter("code")
                );

                coupon.setDiscountType(
                        request.getParameter("discountType")
                );

                coupon.setDiscountValue(
                        Double.parseDouble(
                                request.getParameter(
                                        "discountValue"
                                )
                        )
                );

                coupon.setMinimumOrder(
                        Double.parseDouble(
                                request.getParameter(
                                        "minimumOrder"
                                )
                        )
                );

                String maximumDiscount =
                        request.getParameter(
                                "maximumDiscount"
                        );

                if (maximumDiscount == null ||
                    maximumDiscount.trim().isEmpty()) {

                    coupon.setMaximumDiscount(0);

                } else {

                    coupon.setMaximumDiscount(
                            Double.parseDouble(
                                    maximumDiscount
                            )
                    );
                }

                coupon.setExpiryDate(
                        request.getParameter(
                                "expiryDate"
                        )
                );

                coupon.setStatus(true);

                couponService.addCoupon(coupon);
            }


            // =========================
            // UPDATE
            // =========================

            else if ("update".equalsIgnoreCase(action)) {

                Coupon coupon = new Coupon();

                coupon.setCouponId(
                        Integer.parseInt(
                                request.getParameter(
                                        "couponId"
                                )
                        )
                );

                coupon.setCode(
                        request.getParameter("code")
                );

                coupon.setDiscountType(
                        request.getParameter(
                                "discountType"
                        )
                );

                coupon.setDiscountValue(
                        Double.parseDouble(
                                request.getParameter(
                                        "discountValue"
                                )
                        )
                );

                coupon.setMinimumOrder(
                        Double.parseDouble(
                                request.getParameter(
                                        "minimumOrder"
                                )
                        )
                );

                String maximumDiscount =
                        request.getParameter(
                                "maximumDiscount"
                        );

                if (maximumDiscount == null ||
                    maximumDiscount.trim().isEmpty()) {

                    coupon.setMaximumDiscount(0);

                } else {

                    coupon.setMaximumDiscount(
                            Double.parseDouble(
                                    maximumDiscount
                            )
                    );
                }

                coupon.setExpiryDate(
                        request.getParameter(
                                "expiryDate"
                        )
                );

                coupon.setStatus(
                        "true".equalsIgnoreCase(
                                request.getParameter(
                                        "status"
                                )
                        )
                );

                couponService.updateCoupon(coupon);
            }


            // =========================
            // DELETE
            // =========================

            else if ("delete".equalsIgnoreCase(action)) {

                int couponId =
                        Integer.parseInt(
                                request.getParameter(
                                        "couponId"
                                )
                        );

                couponService.deleteCoupon(
                        couponId
                );
            }


            // =========================
            // STATUS
            // =========================

            else if ("status".equalsIgnoreCase(action)) {

                int couponId =
                        Integer.parseInt(
                                request.getParameter(
                                        "couponId"
                                )
                        );

                boolean status =
                        "true".equalsIgnoreCase(
                                request.getParameter(
                                        "status"
                                )
                        );

                couponService.updateCouponStatus(
                        couponId,
                        status
                );
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        response.sendRedirect(
                request.getContextPath()
                        + "/admin/coupons"
        );
    }
}