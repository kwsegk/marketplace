<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Оформление заказа - Marketplace</title>
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
        
        .checkout-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .checkout-header h2 {
            color: #2C5F8D;
            font-size: 28px;
        }
        
        .checkout-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
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
        
        .selection-cards {
            display: grid;
            gap: 15px;
        }
        
        .selection-card {
            border: 2px solid #e0e0e0;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }
        
        .selection-card:hover {
            border-color: #2C5F8D;
            background: #f8f9fa;
        }
        
        .selection-card input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        
        .selection-card input[type="radio"]:checked + .card-content {
            border-left: 4px solid #2C5F8D;
            padding-left: 16px;
        }
        
        .card-content {
            padding-left: 20px;
            transition: all 0.3s;
        }
        
        .card-content h4 {
            color: #333;
            margin-bottom: 8px;
        }
        
        .card-content p {
            color: #666;
            font-size: 14px;
            margin: 4px 0;
        }
        
        .default-badge {
            display: inline-block;
            background: #2C5F8D;
            color: white;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 11px;
            margin-left: 8px;
        }
        
        .order-summary {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }
        
        .order-summary h3 {
            color: #2C5F8D;
            margin-bottom: 20px;
        }
        
        .summary-item {
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .summary-item:last-child {
            border-bottom: none;
        }
        
        .summary-item-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        
        .item-name {
            font-weight: 500;
            color: #333;
        }
        
        .item-details {
            color: #666;
            font-size: 13px;
        }
        
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 20px;
            font-weight: bold;
            color: #2C5F8D;
            padding-top: 15px;
            border-top: 2px solid #e0e0e0;
            margin-top: 15px;
        }
        
        .btn {
            padding: 12px 20px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 4px;
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
        
        .btn-submit {
            width: 100%;
            padding: 15px;
            background: #28a745;
            margin-top: 20px;
            font-size: 16px;
        }
        
        .btn-submit:hover {
            background: #218838;
        }
        
        .btn-submit:disabled {
            background: #6c757d;
            cursor: not-allowed;
        }
        
        .warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            border-radius: 4px;
            color: #856404;
            margin-bottom: 20px;
        }
        
        .warning a {
            color: #2C5F8D;
            font-weight: 500;
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
        <div class="checkout-header">
            <h2>Оформление заказа</h2>
        </div>
        
        <div class="checkout-content">
            <form action="${pageContext.request.contextPath}/orders/create" method="POST" id="checkoutForm">
                <div class="section">
                    <h3>1️⃣ Адрес доставки</h3>
                    
                    <c:choose>
                        <c:when test="${not empty addresses}">
                            <div class="selection-cards">
                                <c:forEach var="address" items="${addresses}">
                                    <label class="selection-card">
                                        <input type="radio" name="addressId" value="${address.id}" 
                                               ${address['default'] ? 'checked' : ''} required>
                                        <div class="card-content">
                                            <h4>
                                                ${address.addressName}
                                                <c:if test="${address['default']}">
                                                    <span class="default-badge">По умолчанию</span>
                                                </c:if>
                                            </h4>
                                            <p><strong>Адрес:</strong> ${address.fullAddress}</p>
                                            <p><strong>Город:</strong> ${address.city}, ${address.postalCode}</p>
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="warning">
                                <strong>⚠️ Адреса не найдены!</strong> 
                                <a href="${pageContext.request.contextPath}/profile/settings">Добавьте адрес доставки</a> перед оформлением заказа.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="section">
                    <h3>2️⃣ Способ оплаты</h3>
                    
                    <c:choose>
                        <c:when test="${not empty paymentMethods}">
                            <div class="selection-cards">
                                <c:forEach var="payment" items="${paymentMethods}">
                                    <label class="selection-card">
                                        <input type="radio" name="paymentMethodId" value="${payment.id}" 
                                               ${payment['default'] ? 'checked' : ''} required>
                                        <div class="card-content">
                                            <h4>
                                                ${payment.methodName}
                                                <c:if test="${payment['default']}">
                                                    <span class="default-badge">По умолчанию</span>
                                                </c:if>
                                            </h4>
                                            <p><strong>Карта:</strong> ${payment.maskedCardNumber}</p>
                                            <p><strong>Владелец:</strong> ${payment.cardholderName}</p>
                                        </div>
                                    </label>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="warning">
                                <strong>⚠️ Способы оплаты не найдены!</strong> 
                                <a href="${pageContext.request.contextPath}/profile/settings">Добавьте способ оплаты</a> перед оформлением заказа.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </form>
            
            <div class="order-summary">
                <h3>Ваш заказ</h3>
                <c:forEach var="item" items="${cart.items}">
                    <div class="summary-item">
                        <div class="summary-item-header">
                            <span class="item-name">${item.product.name}</span>
                            <span class="item-name">${item.subtotal} ₽</span>
                        </div>
                        <div class="item-details">
                            ${item.product.price} ₽ × ${item.quantity} шт.
                        </div>
                    </div>
                </c:forEach>
                
                <div class="summary-total">
                    <span>Итого:</span>
                    <span>${cart.totalPrice} ₽</span>
                </div>
                
                <c:choose>
                    <c:when test="${not empty addresses && not empty paymentMethods}">
                        <button type="submit" form="checkoutForm" class="btn btn-submit">
                            Подтвердить заказ
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="btn btn-submit" disabled>
                            Заполните все данные
                        </button>
                    </c:otherwise>
                </c:choose>
                
                <a href="${pageContext.request.contextPath}/cart" class="btn" style="width: 100%; margin-top: 10px; text-align: center; background: #6c757d;">
                    Вернуться в корзину
                </a>
            </div>
        </div>
    </div>
</body>
</html>
