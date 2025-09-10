package com.ecommerce.ejb.session;

import com.ecommerce.ejb.entity.CartItem;
import com.ecommerce.ejb.entity.Product;
import com.ecommerce.ejb.entity.User;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class CartService {
    
    @PersistenceContext(unitName = "ecommercePU")
    private EntityManager entityManager;
    
    public CartItem addToCart(Long userId, Long productId, Integer quantity) {
        User user = entityManager.find(User.class, userId);
        Product product = entityManager.find(Product.class, productId);
        
        if (user == null || product == null || !product.getIsActive()) {
            return null;
        }
        
        // Check if item already exists in cart
        CartItem existingItem = findCartItemByUserAndProduct(userId, productId);
        
        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            existingItem.setTotalPrice(existingItem.getUnitPrice().multiply(BigDecimal.valueOf(existingItem.getQuantity())));
            return entityManager.merge(existingItem);
        } else {
            CartItem cartItem = new CartItem(user, product, quantity);
            entityManager.persist(cartItem);
            return cartItem;
        }
    }
    
    public List<CartItem> getCartItems(Long userId) {
        TypedQuery<CartItem> query = entityManager.createQuery(
            "SELECT c FROM CartItem c WHERE c.user.userId = :userId ORDER BY c.createdAt DESC", CartItem.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
    
    public CartItem findCartItemByUserAndProduct(Long userId, Long productId) {
        TypedQuery<CartItem> query = entityManager.createQuery(
            "SELECT c FROM CartItem c WHERE c.user.userId = :userId AND c.product.productId = :productId", CartItem.class);
        query.setParameter("userId", userId);
        query.setParameter("productId", productId);
        
        List<CartItem> items = query.getResultList();
        return items.isEmpty() ? null : items.get(0);
    }
    
    public CartItem updateCartItemQuantity(Long cartItemId, Integer quantity) {
        CartItem cartItem = entityManager.find(CartItem.class, cartItemId);
        if (cartItem != null) {
            cartItem.setQuantity(quantity);
            cartItem.setTotalPrice(cartItem.getUnitPrice().multiply(BigDecimal.valueOf(quantity)));
            return entityManager.merge(cartItem);
        }
        return null;
    }
    
    public void removeFromCart(Long cartItemId) {
        CartItem cartItem = entityManager.find(CartItem.class, cartItemId);
        if (cartItem != null) {
            entityManager.remove(cartItem);
        }
    }
    
    public void clearCart(Long userId) {
        TypedQuery<CartItem> query = entityManager.createQuery(
            "SELECT c FROM CartItem c WHERE c.user.userId = :userId", CartItem.class);
        query.setParameter("userId", userId);
        
        List<CartItem> cartItems = query.getResultList();
        for (CartItem item : cartItems) {
            entityManager.remove(item);
        }
    }
    
    public BigDecimal getCartTotal(Long userId) {
        TypedQuery<BigDecimal> query = entityManager.createQuery(
            "SELECT SUM(c.totalPrice) FROM CartItem c WHERE c.user.userId = :userId", BigDecimal.class);
        query.setParameter("userId", userId);
        
        BigDecimal total = query.getSingleResult();
        return total != null ? total : BigDecimal.ZERO;
    }
    
    public int getCartItemCount(Long userId) {
        TypedQuery<Long> query = entityManager.createQuery(
            "SELECT COUNT(c) FROM CartItem c WHERE c.user.userId = :userId", Long.class);
        query.setParameter("userId", userId);
        
        Long count = query.getSingleResult();
        return count != null ? count.intValue() : 0;
    }
    
    public boolean isCartEmpty(Long userId) {
        return getCartItemCount(userId) == 0;
    }
}
