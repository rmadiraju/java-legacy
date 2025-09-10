<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - E-Commerce Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1><a href="${pageContext.request.contextPath}/products">E-Commerce Store</a></h1>
                </div>
                
                <nav class="nav">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                        <c:if test="${sessionScope.user != null}">
                            <li><a href="${pageContext.request.contextPath}/cart">
                                <i class="fas fa-shopping-cart"></i> Cart
                                <c:if test="${sessionScope.cartCount != null && sessionScope.cartCount > 0}">
                                    <span class="cart-count">${sessionScope.cartCount}</span>
                                </c:if>
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/orders">Orders</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle">
                                    <i class="fas fa-user"></i> ${sessionScope.user.username}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user == null}">
                            <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main class="main">
        <div class="container">
            <c:if test="${error != null}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <c:out value="${error}" />
                </div>
            </c:if>
            
            <c:if test="${success != null}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <c:out value="${success}" />
                </div>
            </c:if>

            <div class="products-header">
                <h1>Our Products</h1>
                
                <!-- Search and Filter -->
                <div class="products-controls">
                    <form class="search-form" action="${pageContext.request.contextPath}/products" method="get">
                        <input type="text" name="search" placeholder="Search products..." value="${searchTerm}">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </form>
                    
                    <div class="category-filter">
                        <select onchange="filterByCategory(this.value)">
                            <option value="">All Categories</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category}" ${selectedCategory == category ? 'selected' : ''}>${category}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            <c:if test="${product.imageUrl != null}">
                                <img src="${product.imageUrl}" alt="${product.name}">
                            </c:if>
                            <c:if test="${product.imageUrl == null}">
                                <div class="placeholder-image">
                                    <i class="fas fa-image"></i>
                                </div>
                            </c:if>
                        </div>
                        
                        <div class="product-info">
                            <h3 class="product-name">${product.name}</h3>
                            <p class="product-description">${product.description}</p>
                            <div class="product-details">
                                <span class="product-category">${product.category}</span>
                                <c:if test="${product.brand != null}">
                                    <span class="product-brand">${product.brand}</span>
                                </c:if>
                            </div>
                            <div class="product-price">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="$"/>
                            </div>
                            <div class="product-stock">
                                <c:if test="${product.stockQuantity > 0}">
                                    <span class="in-stock">In Stock (${product.stockQuantity})</span>
                                </c:if>
                                <c:if test="${product.stockQuantity <= 0}">
                                    <span class="out-of-stock">Out of Stock</span>
                                </c:if>
                            </div>
                            
                            <c:if test="${sessionScope.user != null && product.stockQuantity > 0}">
                                <form class="add-to-cart-form" action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <div class="quantity-input">
                                        <label for="quantity-${product.productId}">Qty:</label>
                                        <input type="number" id="quantity-${product.productId}" name="quantity" value="1" min="1" max="${product.stockQuantity}">
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </button>
                                </form>
                            </c:if>
                            
                            <c:if test="${sessionScope.user == null}">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                                    Login to Purchase
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty products}">
                <div class="no-products">
                    <i class="fas fa-search"></i>
                    <h3>No products found</h3>
                    <p>Try adjusting your search criteria or browse all products.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
                </div>
            </c:if>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 E-Commerce Store. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function filterByCategory(category) {
            if (category) {
                window.location.href = '${pageContext.request.contextPath}/products?category=' + encodeURIComponent(category);
            } else {
                window.location.href = '${pageContext.request.contextPath}/products';
            }
        }
    </script>
</body>
</html>
