package com.ecommerce.ejb.session;

import com.ecommerce.ejb.entity.CartItem;
import com.ecommerce.ejb.entity.Order;
import com.ecommerce.ejb.entity.OrderItem;
import com.ecommerce.ejb.entity.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class OrderService {
    
    @PersistenceContext(unitName = "ecommercePU")
    private EntityManager entityManager;
    
    public Order createOrder(Long userId, String shippingAddress, String billingAddress, String paymentMethod) {
        User user = entityManager.find(User.class, userId);
        if (user == null) {
            return null;
        }
        
        Order order = new Order(user);
        order.setShippingAddress(shippingAddress);
        order.setBillingAddress(billingAddress);
        order.setPaymentMethod(paymentMethod);
        
        entityManager.persist(order);
        return order;
    }
    
    public Order findOrderById(Long orderId) {
        return entityManager.find(Order.class, orderId);
    }
    
    public Order findOrderByOrderNumber(String orderNumber) {
        TypedQuery<Order> query = entityManager.createQuery(
            "SELECT o FROM Order o WHERE o.orderNumber = :orderNumber", Order.class);
        query.setParameter("orderNumber", orderNumber);
        
        List<Order> orders = query.getResultList();
        return orders.isEmpty() ? null : orders.get(0);
    }
    
    public List<Order> getOrdersByUser(Long userId) {
        TypedQuery<Order> query = entityManager.createQuery(
            "SELECT o FROM Order o WHERE o.user.userId = :userId ORDER BY o.createdAt DESC", Order.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
    
    public List<Order> getAllOrders() {
        TypedQuery<Order> query = entityManager.createQuery(
            "SELECT o FROM Order o ORDER BY o.createdAt DESC", Order.class);
        return query.getResultList();
    }
    
    public Order processOrderFromCart(Long userId, String shippingAddress, String billingAddress, String paymentMethod) {
        User user = entityManager.find(User.class, userId);
        if (user == null) {
            return null;
        }
        
        // Create order
        Order order = createOrder(userId, shippingAddress, billingAddress, paymentMethod);
        
        // Get cart items
        TypedQuery<CartItem> cartQuery = entityManager.createQuery(
            "SELECT c FROM CartItem c WHERE c.user.userId = :userId", CartItem.class);
        cartQuery.setParameter("userId", userId);
        List<CartItem> cartItems = cartQuery.getResultList();
        
        if (cartItems.isEmpty()) {
            entityManager.remove(order);
            return null;
        }
        
        BigDecimal subtotal = BigDecimal.ZERO;
        
        // Convert cart items to order items
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem(order, cartItem.getProduct(), cartItem.getQuantity());
            order.addOrderItem(orderItem);
            entityManager.persist(orderItem);
            
            subtotal = subtotal.add(orderItem.getTotalPrice());
            
            // Remove from cart
            entityManager.remove(cartItem);
        }
        
        // Calculate totals
        order.setSubtotal(subtotal);
        order.setTaxAmount(subtotal.multiply(new BigDecimal("0.08"))); // 8% tax
        order.setShippingAmount(new BigDecimal("10.00")); // Fixed shipping
        order.setTotalAmount(subtotal.add(order.getTaxAmount()).add(order.getShippingAmount()));
        
        order.setStatus("CONFIRMED");
        order.setPaymentStatus("PAID");
        
        return entityManager.merge(order);
    }
    
    public Order updateOrderStatus(Long orderId, String status) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setStatus(status);
            return entityManager.merge(order);
        }
        return null;
    }
    
    public Order updatePaymentStatus(Long orderId, String paymentStatus) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setPaymentStatus(paymentStatus);
            return entityManager.merge(order);
        }
        return null;
    }
    
    public Order updateOrder(Order order) {
        return entityManager.merge(order);
    }
    
    public void cancelOrder(Long orderId) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setStatus("CANCELLED");
            entityManager.merge(order);
        }
    }
    
    public BigDecimal getOrderTotal(Long orderId) {
        Order order = findOrderById(orderId);
        return order != null ? order.getTotalAmount() : BigDecimal.ZERO;
    }
}
