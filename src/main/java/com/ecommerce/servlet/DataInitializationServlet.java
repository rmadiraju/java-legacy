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
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/init-data")
public class DataInitializationServlet extends HttpServlet {
    
    @EJB
    private ProductService productService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if products already exist
        List<Product> existingProducts = productService.getAllProducts();
        if (!existingProducts.isEmpty()) {
            response.getWriter().println("Data already initialized. Found " + existingProducts.size() + " products.");
            return;
        }
        
        // Create sample products
        createSampleProducts();
        
        response.getWriter().println("Sample data initialized successfully!");
    }
    
    private void createSampleProducts() {
        // Electronics
        Product laptop = new Product();
        laptop.setName("MacBook Pro 16-inch");
        laptop.setDescription("Powerful laptop with M2 chip, perfect for professionals and creatives.");
        laptop.setPrice(new BigDecimal("2499.99"));
        laptop.setCategory("Electronics");
        laptop.setBrand("Apple");
        laptop.setSku("MBP16-M2-001");
        laptop.setStockQuantity(15);
        laptop.setImageUrl("https://via.placeholder.com/300x200?text=MacBook+Pro");
        laptop.setWeight(2.1);
        laptop.setDimensions("35.57 x 24.81 x 1.68 cm");
        laptop.setIsFeatured(true);
        productService.createProduct(laptop.getName(), laptop.getDescription(), laptop.getPrice(), laptop.getCategory());
        
        Product smartphone = new Product();
        smartphone.setName("iPhone 15 Pro");
        smartphone.setDescription("Latest iPhone with titanium design and advanced camera system.");
        smartphone.setPrice(new BigDecimal("999.99"));
        smartphone.setCategory("Electronics");
        smartphone.setBrand("Apple");
        smartphone.setSku("IPH15-PRO-001");
        smartphone.setStockQuantity(25);
        smartphone.setImageUrl("https://via.placeholder.com/300x200?text=iPhone+15+Pro");
        smartphone.setWeight(0.187);
        smartphone.setDimensions("14.67 x 7.15 x 0.83 cm");
        smartphone.setIsFeatured(true);
        productService.createProduct(smartphone.getName(), smartphone.getDescription(), smartphone.getPrice(), smartphone.getCategory());
        
        Product headphones = new Product();
        headphones.setName("Sony WH-1000XM5");
        headphones.setDescription("Industry-leading noise canceling wireless headphones.");
        headphones.setPrice(new BigDecimal("399.99"));
        headphones.setCategory("Electronics");
        headphones.setBrand("Sony");
        headphones.setSku("SONY-WH1000XM5");
        headphones.setStockQuantity(30);
        headphones.setImageUrl("https://via.placeholder.com/300x200?text=Sony+Headphones");
        headphones.setWeight(0.25);
        headphones.setDimensions("27.0 x 20.0 x 7.0 cm");
        productService.createProduct(headphones.getName(), headphones.getDescription(), headphones.getPrice(), headphones.getCategory());
        
        // Clothing
        Product tshirt = new Product();
        tshirt.setName("Classic Cotton T-Shirt");
        tshirt.setDescription("Comfortable 100% cotton t-shirt in various colors.");
        tshirt.setPrice(new BigDecimal("19.99"));
        tshirt.setCategory("Clothing");
        tshirt.setBrand("BasicWear");
        tshirt.setSku("TSHIRT-COTTON-001");
        tshirt.setStockQuantity(100);
        tshirt.setImageUrl("https://via.placeholder.com/300x200?text=Cotton+T-Shirt");
        tshirt.setWeight(0.2);
        tshirt.setDimensions("Sizes: S, M, L, XL");
        productService.createProduct(tshirt.getName(), tshirt.getDescription(), tshirt.getPrice(), tshirt.getCategory());
        
        Product jeans = new Product();
        jeans.setName("Slim Fit Jeans");
        jeans.setDescription("Premium denim jeans with modern slim fit design.");
        jeans.setPrice(new BigDecimal("79.99"));
        jeans.setCategory("Clothing");
        jeans.setBrand("DenimCo");
        jeans.setSku("JEANS-SLIM-001");
        jeans.setStockQuantity(50);
        jeans.setImageUrl("https://via.placeholder.com/300x200?text=Slim+Jeans");
        jeans.setWeight(0.6);
        jeans.setDimensions("Sizes: 28-40 waist");
        productService.createProduct(jeans.getName(), jeans.getDescription(), jeans.getPrice(), jeans.getCategory());
        
        // Home & Garden
        Product coffeeMaker = new Product();
        coffeeMaker.setName("Programmable Coffee Maker");
        coffeeMaker.setDescription("12-cup programmable coffee maker with auto shut-off.");
        coffeeMaker.setPrice(new BigDecimal("89.99"));
        coffeeMaker.setCategory("Home & Garden");
        coffeeMaker.setBrand("BrewMaster");
        coffeeMaker.setSku("COFFEE-PROG-001");
        coffeeMaker.setStockQuantity(20);
        coffeeMaker.setImageUrl("https://via.placeholder.com/300x200?text=Coffee+Maker");
        coffeeMaker.setWeight(2.5);
        coffeeMaker.setDimensions("30.5 x 20.3 x 35.6 cm");
        productService.createProduct(coffeeMaker.getName(), coffeeMaker.getDescription(), coffeeMaker.getPrice(), coffeeMaker.getCategory());
        
        Product plantPot = new Product();
        plantPot.setName("Ceramic Plant Pot");
        plantPot.setDescription("Beautiful ceramic plant pot perfect for indoor plants.");
        plantPot.setPrice(new BigDecimal("24.99"));
        plantPot.setCategory("Home & Garden");
        plantPot.setBrand("GreenThumb");
        plantPot.setSku("POT-CERAMIC-001");
        plantPot.setStockQuantity(40);
        plantPot.setImageUrl("https://via.placeholder.com/300x200?text=Plant+Pot");
        plantPot.setWeight(1.2);
        plantPot.setDimensions("15 x 15 x 12 cm");
        productService.createProduct(plantPot.getName(), plantPot.getDescription(), plantPot.getPrice(), plantPot.getCategory());
        
        // Sports & Outdoors
        Product runningShoes = new Product();
        runningShoes.setName("Running Shoes");
        runningShoes.setDescription("Lightweight running shoes with excellent cushioning.");
        runningShoes.setPrice(new BigDecimal("129.99"));
        runningShoes.setCategory("Sports & Outdoors");
        runningShoes.setBrand("RunFast");
        runningShoes.setSku("SHOES-RUNNING-001");
        runningShoes.setStockQuantity(35);
        runningShoes.setImageUrl("https://via.placeholder.com/300x200?text=Running+Shoes");
        runningShoes.setWeight(0.3);
        runningShoes.setDimensions("Sizes: 7-12 US");
        productService.createProduct(runningShoes.getName(), runningShoes.getDescription(), runningShoes.getPrice(), runningShoes.getCategory());
        
        Product yogaMat = new Product();
        yogaMat.setName("Premium Yoga Mat");
        yogaMat.setDescription("Non-slip yoga mat with excellent grip and cushioning.");
        yogaMat.setPrice(new BigDecimal("49.99"));
        yogaMat.setCategory("Sports & Outdoors");
        yogaMat.setBrand("ZenFit");
        yogaMat.setSku("MAT-YOGA-001");
        yogaMat.setStockQuantity(25);
        yogaMat.setImageUrl("https://via.placeholder.com/300x200?text=Yoga+Mat");
        yogaMat.setWeight(1.5);
        yogaMat.setDimensions("183 x 61 x 0.6 cm");
        productService.createProduct(yogaMat.getName(), yogaMat.getDescription(), yogaMat.getPrice(), yogaMat.getCategory());
        
        // Books
        Product book = new Product();
        book.setName("Programming Fundamentals");
        book.setDescription("Comprehensive guide to programming concepts and best practices.");
        book.setPrice(new BigDecimal("39.99"));
        book.setCategory("Books");
        book.setBrand("TechBooks");
        book.setSku("BOOK-PROG-001");
        book.setStockQuantity(60);
        book.setImageUrl("https://via.placeholder.com/300x200?text=Programming+Book");
        book.setWeight(0.8);
        book.setDimensions("23.5 x 15.5 x 3.0 cm");
        productService.createProduct(book.getName(), book.getDescription(), book.getPrice(), book.getCategory());
        
        Product novel = new Product();
        novel.setName("Bestselling Novel");
        novel.setDescription("Award-winning novel that has captivated readers worldwide.");
        novel.setPrice(new BigDecimal("16.99"));
        novel.setCategory("Books");
        novel.setBrand("LiteraryPress");
        novel.setSku("BOOK-NOVEL-001");
        novel.setStockQuantity(80);
        novel.setImageUrl("https://via.placeholder.com/300x200?text=Bestselling+Novel");
        novel.setWeight(0.4);
        novel.setDimensions("20.3 x 13.3 x 2.5 cm");
        productService.createProduct(novel.getName(), novel.getDescription(), novel.getPrice(), novel.getCategory());
    }
}
