<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - E-Commerce Store</title>
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
            <div class="confirmation-header">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1>Order Confirmed!</h1>
                <p>Thank you for your purchase. Your order has been successfully placed.</p>
            </div>

            <c:if test="${order != null}">
                <div class="order-details">
                    <div class="order-info">
                        <h3>Order Information</h3>
                        <div class="info-row">
                            <span class="label">Order Number:</span>
                            <span class="value">${order.orderNumber}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Order Date:</span>
                            <span class="value">
                                <fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy HH:mm"/>
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="label">Status:</span>
                            <span class="value status-${order.status.toLowerCase()}">${order.status}</span>
                        </div>
                        <div class="info-row">
                            <span class="label">Payment Status:</span>
                            <span class="value status-${order.paymentStatus.toLowerCase()}">${order.paymentStatus}</span>
                        </div>
                    </div>

                    <div class="shipping-info">
                        <h3>Shipping Information</h3>
                        <div class="address">
                            ${order.shippingAddress}
                        </div>
                    </div>

                    <div class="order-items">
                        <h3>Order Items</h3>
                        <div class="items-list">
                            <c:forEach var="item" items="${order.orderItems}">
                                <div class="order-item">
                                    <div class="item-info">
                                        <h4>${item.product.name}</h4>
                                        <p>${item.product.category}</p>
                                    </div>
                                    <div class="item-quantity">
                                        Qty: ${item.quantity}
                                    </div>
                                    <div class="item-price">
                                        <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="order-total">
                        <h3>Order Total</h3>
                        <div class="total-breakdown">
                            <div class="total-row">
                                <span>Subtotal:</span>
                                <span><fmt:formatNumber value="${order.subtotal}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <div class="total-row">
                                <span>Tax:</span>
                                <span><fmt:formatNumber value="${order.taxAmount}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <div class="total-row">
                                <span>Shipping:</span>
                                <span><fmt:formatNumber value="${order.shippingAmount}" type="currency" currencySymbol="$"/></span>
                            </div>
                            <div class="total-row total">
                                <span>Total:</span>
                                <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="confirmation-actions">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                    Continue Shopping
                </a>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">
                    View All Orders
                </a>
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
