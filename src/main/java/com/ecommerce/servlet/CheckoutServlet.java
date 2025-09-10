package com.ecommerce.servlet;

import com.ecommerce.ejb.entity.Order;
import com.ecommerce.ejb.session.OrderService;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    @EJB
    private OrderService orderService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        
        if (userId == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Long userId = (Long) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String shippingAddress = request.getParameter("shippingAddress");
        String billingAddress = request.getParameter("billingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (shippingAddress == null || billingAddress == null || paymentMethod == null ||
            shippingAddress.trim().isEmpty() || billingAddress.trim().isEmpty() || paymentMethod.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
            return;
        }
        
        try {
            Order order = orderService.processOrderFromCart(userId, shippingAddress, billingAddress, paymentMethod);
            
            if (order != null) {
                request.setAttribute("order", order);
                request.setAttribute("success", "Order placed successfully!");
                request.getRequestDispatcher("/WEB-INF/jsp/order-confirmation.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to process order. Cart may be empty.");
                request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while processing your order.");
            request.getRequestDispatcher("/WEB-INF/jsp/checkout.jsp").forward(request, response);
        }
    }
}
