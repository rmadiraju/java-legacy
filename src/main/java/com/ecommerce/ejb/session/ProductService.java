package com.ecommerce.ejb.session;

import com.ecommerce.ejb.entity.Product;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class ProductService {
    
    @PersistenceContext(unitName = "ecommercePU")
    private EntityManager entityManager;
    
    public Product createProduct(String name, String description, BigDecimal price, String category) {
        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategory(category);
        
        entityManager.persist(product);
        return product;
    }
    
    public Product findProductById(Long productId) {
        return entityManager.find(Product.class, productId);
    }
    
    public List<Product> getAllProducts() {
        TypedQuery<Product> query = entityManager.createQuery(
            "SELECT p FROM Product p WHERE p.isActive = true ORDER BY p.createdAt DESC", Product.class);
        return query.getResultList();
    }
    
    public List<Product> getProductsByCategory(String category) {
        TypedQuery<Product> query = entityManager.createQuery(
            "SELECT p FROM Product p WHERE p.category = :category AND p.isActive = true ORDER BY p.name", Product.class);
        query.setParameter("category", category);
        return query.getResultList();
    }
    
    public List<Product> searchProducts(String searchTerm) {
        TypedQuery<Product> query = entityManager.createQuery(
            "SELECT p FROM Product p WHERE (LOWER(p.name) LIKE LOWER(:searchTerm) OR " +
            "LOWER(p.description) LIKE LOWER(:searchTerm) OR LOWER(p.brand) LIKE LOWER(:searchTerm)) " +
            "AND p.isActive = true ORDER BY p.name", Product.class);
        query.setParameter("searchTerm", "%" + searchTerm + "%");
        return query.getResultList();
    }
    
    public List<Product> getFeaturedProducts() {
        TypedQuery<Product> query = entityManager.createQuery(
            "SELECT p FROM Product p WHERE p.isFeatured = true AND p.isActive = true ORDER BY p.createdAt DESC", Product.class);
        return query.getResultList();
    }
    
    public List<String> getAllCategories() {
        TypedQuery<String> query = entityManager.createQuery(
            "SELECT DISTINCT p.category FROM Product p WHERE p.isActive = true ORDER BY p.category", String.class);
        return query.getResultList();
    }
    
    public Product updateProduct(Product product) {
        return entityManager.merge(product);
    }
    
    public void deleteProduct(Long productId) {
        Product product = findProductById(productId);
        if (product != null) {
            product.setIsActive(false);
            entityManager.merge(product);
        }
    }
    
    public boolean updateStock(Long productId, Integer quantity) {
        Product product = findProductById(productId);
        if (product != null && product.getStockQuantity() >= quantity) {
            product.setStockQuantity(product.getStockQuantity() - quantity);
            entityManager.merge(product);
            return true;
        }
        return false;
    }
    
    public boolean isProductInStock(Long productId, Integer quantity) {
        Product product = findProductById(productId);
        return product != null && product.getStockQuantity() >= quantity;
    }
}
