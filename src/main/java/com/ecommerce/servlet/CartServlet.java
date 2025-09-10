package com.ecommerce.servlet;

import com.ecommerce.ejb.entity.CartItem;
import com.ecommerce.ejb.session.CartService;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    @EJB
    private CartService cartService;
    
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
        
        List<CartItem> cartItems = cartService.getCartItems(userId);
        BigDecimal cartTotal = cartService.getCartTotal(userId);
        int itemCount = cartService.getCartItemCount(userId);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("itemCount", itemCount);
        
        request.getRequestDispatcher("/WEB-INF/jsp/cart.jsp").forward(request, response);
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
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            Long productId = Long.parseLong(request.getParameter("productId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            
            CartItem cartItem = cartService.addToCart(userId, productId, quantity);
            if (cartItem != null) {
                request.setAttribute("success", "Product added to cart successfully");
            } else {
                request.setAttribute("error", "Failed to add product to cart");
            }
            
            response.sendRedirect(request.getContextPath() + "/products");
            
        } else if ("update".equals(action)) {
            Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            
            cartService.updateCartItemQuantity(cartItemId, quantity);
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("remove".equals(action)) {
            Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
            cartService.removeFromCart(cartItemId);
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } else if ("clear".equals(action)) {
            cartService.clearCart(userId);
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
