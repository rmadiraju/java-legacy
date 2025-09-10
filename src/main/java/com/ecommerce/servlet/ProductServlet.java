package com.ecommerce.servlet;

import com.ecommerce.ejb.entity.Product;
import com.ecommerce.ejb.session.ProductService;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    
    @EJB
    private ProductService productService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        
        List<Product> products;
        
        if (search != null && !search.trim().isEmpty()) {
            products = productService.searchProducts(search);
            request.setAttribute("searchTerm", search);
        } else if (category != null && !category.trim().isEmpty()) {
            products = productService.getProductsByCategory(category);
            request.setAttribute("selectedCategory", category);
        } else if ("featured".equals(action)) {
            products = productService.getFeaturedProducts();
        } else {
            products = productService.getAllProducts();
        }
        
        List<String> categories = productService.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/WEB-INF/jsp/products.jsp").forward(request, response);
    }
}
