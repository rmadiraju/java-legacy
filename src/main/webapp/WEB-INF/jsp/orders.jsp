<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - E-Commerce Store</title>
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
                        <li><a href="${pageContext.request.contextPath}/orders" class="active">Orders</a></li>
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
            <div class="orders-header">
                <h1>My Orders</h1>
                <p>Track and manage your orders</p>
            </div>

            <c:if test="${empty orders}">
                <div class="no-orders">
                    <i class="fas fa-shopping-bag"></i>
                    <h3>No orders found</h3>
                    <p>You haven't placed any orders yet.</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Start Shopping</a>
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="orders-list">
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div class="order-info">
                                    <h3>Order #${order.orderNumber}</h3>
                                    <p class="order-date">
                                        <fmt:formatDate value="${order.createdAt}" pattern="MMM dd, yyyy HH:mm"/>
                                    </p>
                                </div>
                                <div class="order-status">
                                    <span class="status-badge status-${order.status.toLowerCase()}">${order.status}</span>
                                    <span class="payment-status status-${order.paymentStatus.toLowerCase()}">${order.paymentStatus}</span>
                                </div>
                            </div>
                            
                            <div class="order-items">
                                <h4>Items:</h4>
                                <div class="items-summary">
                                    <c:forEach var="item" items="${order.orderItems}" varStatus="status">
                                        <c:if test="${status.index < 3}">
                                            <span class="item-summary">
                                                ${item.product.name} (${item.quantity})
                                            </span>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${order.orderItems.size() > 3}">
                                        <span class="more-items">+${order.orderItems.size() - 3} more items</span>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="order-total">
                                <div class="total-amount">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/>
                                </div>
                            </div>
                            
                            <div class="order-actions">
                                <button class="btn btn-secondary btn-sm" onclick="toggleOrderDetails('${order.orderId}')">
                                    <i class="fas fa-eye"></i> View Details
                                </button>
                            </div>
                            
                            <!-- Order Details (Hidden by default) -->
                            <div class="order-details" id="details-${order.orderId}" style="display: none;">
                                <div class="details-section">
                                    <h4>Shipping Address:</h4>
                                    <p>${order.shippingAddress}</p>
                                </div>
                                
                                <div class="details-section">
                                    <h4>Payment Method:</h4>
                                    <p>${order.paymentMethod}</p>
                                </div>
                                
                                <div class="details-section">
                                    <h4>Order Items:</h4>
                                    <div class="detailed-items">
                                        <c:forEach var="item" items="${order.orderItems}">
                                            <div class="detailed-item">
                                                <div class="item-info">
                                                    <h5>${item.product.name}</h5>
                                                    <p>${item.product.category}</p>
                                                </div>
                                                <div class="item-quantity">Qty: ${item.quantity}</div>
                                                <div class="item-price">
                                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                                <div class="details-section">
                                    <h4>Order Summary:</h4>
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
                        </div>
                    </c:forEach>
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
        function toggleOrderDetails(orderId) {
            const details = document.getElementById('details-' + orderId);
            if (details.style.display === 'none') {
                details.style.display = 'block';
            } else {
                details.style.display = 'none';
            }
        }
    </script>
</body>
</html>
