<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'E-Commerce Store'}" /></title>
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
            
            <jsp:include page="${content}" />
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 E-Commerce Store. All rights reserved.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
