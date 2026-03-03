<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>История заказов - Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
        }
        
        .navbar {
            background: #2C5F8D;
            padding: 15px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .navbar h1 {
            font-size: 24px;
        }
        
        .navbar .logo {
            color: white;
            text-decoration: none;
        }
        
        .navbar-right {
            display: flex;
            gap: 20px;
        }
        
        .navbar-right a {
            color: white;
            text-decoration: none;
            padding: 8px 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 4px;
            font-size: 15px;
        }
        
        .navbar-right a:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .page-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .page-header h2 {
            color: #2C5F8D;
            font-size: 28px;
        }
        
        .order-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .order-id {
            font-size: 20px;
            font-weight: bold;
            color: #2C5F8D;
        }
        
        .order-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
            background: #28a745;
            color: white;
        }
        
        .order-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .info-item p {
            color: #666;
            font-size: 13px;
            margin-bottom: 5px;
        }
        
        .info-item strong {
            color: #333;
            font-size: 16px;
        }
        
        .order-items {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        
        .order-items h4 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .item {
            padding: 8px 0;
            color: #666;
            font-size: 14px;
        }
        
        .btn {
            padding: 10px 20px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn:hover {
            background: #1e4466;
        }
        
        .empty-orders {
            background: white;
            padding: 60px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .empty-orders h3 {
            color: #999;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1><a href="${pageContext.request.contextPath}/products" class="logo">Marketplace</a></h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/products">Товары</a>
            <a href="${pageContext.request.contextPath}/">Профиль</a>
        </div>
    </div>
    
    <div class="container">
        <div class="page-header">
            <h2>📋 История заказов</h2>
        </div>
        
        <c:choose>
            <c:when test="${not empty orders}">
                <c:forEach var="order" items="${orders}">
                    <div class="order-card">
                        <div class="order-header">
                            <span class="order-id">Заказ #${order.id}</span>
                            <span class="order-status">${order.status}</span>
                        </div>
                        
                        <div class="order-info">
                            <div class="info-item">
                                <p>Дата заказа:</p>
                                <strong>${order.orderDate}</strong>
                            </div>
                            <div class="info-item">
                                <p>Сумма заказа:</p>
                                <strong>${order.totalPrice} ₽</strong>
                            </div>
                            <div class="info-item">
                                <p>Адрес доставки:</p>
                                <strong>${order.address.city}</strong>
                            </div>
                        </div>
                        
                        <div class="order-items">
                            <h4>Товары:</h4>
                            <c:forEach var="item" items="${order.orderItems}">
                                <div class="item">
                                    ${item.product.name} - ${item.quantity} шт. × ${item.price} ₽ = ${item.subtotal} ₽
                                </div>
                            </c:forEach>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/orders/detail?id=${order.id}" class="btn">
                            Подробнее
                        </a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-orders">
                    <h3>У вас пока нет заказов</h3>
                    <p style="color: #999; margin-bottom: 20px;">Начните делать покупки прямо сейчас!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn">Перейти к товарам</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
