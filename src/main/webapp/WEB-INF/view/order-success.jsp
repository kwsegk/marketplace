<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Заказ оформлен - Marketplace</title>
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
            max-width: 800px;
            margin: 60px auto;
            padding: 0 20px;
        }
        
        .success-card {
            background: white;
            padding: 60px 40px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .success-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        
        .success-card h1 {
            color: #28a745;
            font-size: 32px;
            margin-bottom: 15px;
        }
        
        .success-card p {
            color: #666;
            font-size: 16px;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .order-info {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            margin: 30px 0;
            text-align: left;
        }
        
        .order-info h3 {
            color: #2C5F8D;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            color: #666;
            font-weight: 500;
        }
        
        .info-value {
            color: #333;
            font-weight: 600;
        }
        
        .btn {
            padding: 12px 30px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
            transition: all 0.3s;
        }
        
        .btn:hover {
            background: #1e4466;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: #28a745;
        }
        
        .btn-success:hover {
            background: #218838;
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
        <div class="success-card">
            <div class="success-icon">✅</div>
            <h1>Заказ успешно оформлен!</h1>
            <p>Спасибо за покупку! Ваш заказ принят в обработку.<br>
               Мы отправим уведомление, как только заказ будет отправлен.</p>
            
            <div class="order-info">
                <h3>Информация о заказе</h3>
                <div class="info-row">
                    <span class="info-label">Номер заказа:</span>
                    <span class="info-value">#${order.id}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Статус:</span>
                    <span class="info-value">${order.status}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Сумма заказа:</span>
                    <span class="info-value">${order.totalPrice} ₽</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Адрес доставки:</span>
                    <span class="info-value">${order.address.fullAddress}, ${order.address.city}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Способ оплаты:</span>
                    <span class="info-value">${order.paymentMethod.methodName}</span>
                </div>
            </div>
            
            <div style="margin-top: 40px;">
                <a href="${pageContext.request.contextPath}/orders/detail?id=${order.id}" class="btn btn-success">
                    Посмотреть детали заказа
                </a>
                <a href="${pageContext.request.contextPath}/products" class="btn">
                    Продолжить покупки
                </a>
            </div>
        </div>
    </div>
</body>
</html>
