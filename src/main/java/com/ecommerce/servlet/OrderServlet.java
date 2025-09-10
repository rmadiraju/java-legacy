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

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    
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
        
        List<Order> orders = orderService.getOrdersByUser(userId);
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/WEB-INF/jsp/orders.jsp").forward(request, response);
    }
}
