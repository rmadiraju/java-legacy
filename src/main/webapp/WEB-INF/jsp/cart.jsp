<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - E-Commerce Store</title>
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
                        <li><a href="${pageContext.request.contextPath}/cart" class="active">
                            <i class="fas fa-shopping-cart"></i> Cart
                            <c:if test="${itemCount > 0}">
                                <span class="cart-count">${itemCount}</span>
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
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main class="main">
        <div class="container">
            <div class="cart-header">
                <h1>Shopping Cart</h1>
                <c:if test="${itemCount > 0}">
                    <p>${itemCount} item(s) in your cart</p>
                </c:if>
            </div>

            <c:if test="${empty cartItems}">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Your cart is empty</h3>
                    <p>Add some products to get started!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Continue Shopping</a>
                </div>
            </c:if>

            <c:if test="${not empty cartItems}">
                <div class="cart-content">
                    <div class="cart-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item">
                                <div class="item-image">
                                    <c:if test="${item.product.imageUrl != null}">
                                        <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                    </c:if>
                                    <c:if test="${item.product.imageUrl == null}">
                                        <div class="placeholder-image">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="item-details">
                                    <h3 class="item-name">${item.product.name}</h3>
                                    <p class="item-category">${item.product.category}</p>
                                    <div class="item-price">
                                        <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="$"/>
                                    </div>
                                </div>
                                
                                <div class="item-quantity">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="quantity-form">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <label for="quantity-${item.cartItemId}">Quantity:</label>
                                        <input type="number" id="quantity-${item.cartItemId}" name="quantity" 
                                               value="${item.quantity}" min="1" max="${item.product.stockQuantity}"
                                               onchange="this.form.submit()">
                                    </form>
                                </div>
                                
                                <div class="item-total">
                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                </div>
                                
                                <div class="item-actions">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="remove-form">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                        <button type="submit" class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash"></i> Remove
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="cart-summary">
                        <div class="summary-card">
                            <h3>Order Summary</h3>
                            <div class="summary-row">
                                <span>Subtotal:</span>
                                <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <div class="summary-row">
                                <span>Tax (8%):</span>
                                <span><fmt:formatNumber value="${cartTotal * 0.08}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping:</span>
                                <span>$10.00</span>
                            </div>
                            <div class="summary-row total">
                                <span>Total:</span>
                                <span><fmt:formatNumber value="${cartTotal + (cartTotal * 0.08) + 10}" type="currency" currencySymbol="$"/></span>
                            </div>
                            
                            <div class="summary-actions">
                                <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                                    Continue Shopping
                                </a>
                                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary">
                                    Proceed to Checkout
                                </a>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="clear-cart-form">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to clear your cart?')">
                                    Clear Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 E-Commerce Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
