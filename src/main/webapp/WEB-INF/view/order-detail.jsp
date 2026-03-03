<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Детали заказа #${order.id} - Marketplace</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .order-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-header h2 {
            color: #2C5F8D;
            font-size: 28px;
        }
        
        .order-status {
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            background: #28a745;
            color: white;
        }
        
        .section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .section h3 {
            color: #2C5F8D;
            margin-bottom: 20px;
            font-size: 20px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        
        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        
        .info-item p {
            color: #666;
            font-size: 13px;
            margin-bottom: 8px;
        }
        
        .info-item strong {
            color: #333;
            font-size: 16px;
        }
        
        .items-list {
            margin-top: 15px;
        }
        
        .item-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .item-row:last-child {
            border-bottom: none;
        }
        
        .item-details h4 {
            color: #333;
            margin-bottom: 5px;
        }
        
        .item-details p {
            color: #666;
            font-size: 14px;
        }
        
        .item-price {
            text-align: right;
        }
        
        .item-price .price {
            font-size: 18px;
            font-weight: bold;
            color: #2C5F8D;
        }
        
        .item-price .quantity {
            color: #666;
            font-size: 13px;
        }
        
        .total-section {
            display: flex;
            justify-content: space-between;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            margin-top: 20px;
        }
        
        .total-label {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }
        
        .total-price {
            font-size: 24px;
            font-weight: bold;
            color: #2C5F8D;
        }
        
        .btn {
            padding: 12px 24px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn:hover {
            background: #1e4466;
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
        <div class="order-header">
            <h2>Заказ #${order.id}</h2>
            <span class="order-status">${order.status}</span>
        </div>
        
        <div class="section">
            <h3>Информация о заказе</h3>
            <div class="info-grid">
                <div class="info-item">
                    <p>Дата оформления:</p>
                    <strong>${order.orderDate}</strong>
                </div>
                <div class="info-item">
                    <p>Статус заказа:</p>
                    <strong>${order.status}</strong>
                </div>
            </div>
        </div>
        
        <div class="section">
            <h3>Адрес доставки</h3>
            <div class="info-item">
                <p><strong>${order.address.addressName}</strong></p>
                <p>${order.address.fullAddress}</p>
                <p>${order.address.city}, ${order.address.postalCode}</p>
            </div>
        </div>
        
        <div class="section">
            <h3>Способ оплаты</h3>
            <div class="info-item">
                <p><strong>${order.paymentMethod.methodName}</strong></p>
                <p>Карта: ${order.paymentMethod.maskedCardNumber}</p>
                <p>Владелец: ${order.paymentMethod.cardholderName}</p>
            </div>
        </div>
        
        <div class="section">
            <h3>Товары в заказе</h3>
            <div class="items-list">
                <c:forEach var="item" items="${order.orderItems}">
                    <div class="item-row">
                        <div class="item-details">
                            <h4>${item.product.name}</h4>
                            <p>${item.product.description}</p>
                        </div>
                        <div class="item-price">
                            <div class="price">${item.subtotal} ₽</div>
                            <div class="quantity">${item.price} ₽ × ${item.quantity} шт.</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <div class="total-section">
                <span class="total-label">Итого:</span>
                <span class="total-price">${order.totalPrice} ₽</span>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/orders" class="btn">Вернуться к заказам</a>
        </div>
    </div>
</body>
</html>
