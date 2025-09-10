<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - E-Commerce Store</title>
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
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <main class="main">
        <div class="container">
            <div class="checkout-header">
                <h1>Checkout</h1>
                <p>Complete your order</p>
            </div>

            <c:if test="${error != null}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <c:out value="${error}" />
                </div>
            </c:if>

            <div class="checkout-content">
                <div class="checkout-form">
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="form-section">
                            <h3><i class="fas fa-shipping-fast"></i> Shipping Information</h3>
                            <div class="form-group">
                                <label for="shippingAddress">Shipping Address:</label>
                                <textarea id="shippingAddress" name="shippingAddress" rows="4" required 
                                          placeholder="Enter your complete shipping address"></textarea>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-credit-card"></i> Billing Information</h3>
                            <div class="form-group">
                                <label for="billingAddress">Billing Address:</label>
                                <textarea id="billingAddress" name="billingAddress" rows="4" required 
                                          placeholder="Enter your billing address"></textarea>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3><i class="fas fa-payment"></i> Payment Method</h3>
                            <div class="form-group">
                                <label for="paymentMethod">Payment Method:</label>
                                <select id="paymentMethod" name="paymentMethod" required>
                                    <option value="">Select Payment Method</option>
                                    <option value="credit_card">Credit Card</option>
                                    <option value="debit_card">Debit Card</option>
                                    <option value="paypal">PayPal</option>
                                    <option value="bank_transfer">Bank Transfer</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">
                                Back to Cart
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check"></i> Place Order
                            </button>
                        </div>
                    </form>
                </div>

                <div class="order-summary">
                    <div class="summary-card">
                        <h3>Order Summary</h3>
                        <div class="summary-items">
                            <!-- This would typically be populated with cart items -->
                            <p>Items will be calculated from your cart</p>
                        </div>
                        <div class="summary-total">
                            <p><strong>Total will be calculated at checkout</strong></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 E-Commerce Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
