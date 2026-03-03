<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Корзина - Marketplace</title>
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
        
        .cart-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .cart-header h2 {
            color: #2C5F8D;
            font-size: 28px;
        }
        
        .cart-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }
        
        .cart-items {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .item-info h4 {
            color: #333;
            margin-bottom: 8px;
        }
        
        .item-price {
            color: #2C5F8D;
            font-weight: bold;
            font-size: 18px;
        }
        
        .item-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-control input {
            width: 60px;
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
            border-radius: 4px;
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
        
        .btn-delete {
            background: #dc3545;
            padding: 8px 15px;
            font-size: 13px;
        }
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .cart-summary {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }
        
        .cart-summary h3 {
            color: #2C5F8D;
            margin-bottom: 20px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            color: #666;
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
        
        .checkout-btn {
            width: 100%;
            padding: 15px;
            background: #28a745;
            margin-top: 20px;
            font-size: 16px;
        }
        
        .checkout-btn:hover {
            background: #218838;
        }
        
        .empty-cart {
            background: white;
            padding: 60px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .empty-cart h3 {
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
        <div class="cart-header">
            <h2>Ваша корзина</h2>
        </div>
        
        <c:choose>
            <c:when test="${cart != null && !cart.isEmpty()}">
                <div class="cart-content">
                    <div class="cart-items">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="cart-item">
                                <div class="item-info">
                                    <h4>${item.product.name}</h4>
                                    <p class="item-price">${item.product.price} ₽ × ${item.quantity} = ${item.subtotal} ₽</p>
                                </div>
                                <div class="item-actions">
                                    <form action="${pageContext.request.contextPath}/cart/update" method="POST" class="quantity-control">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" 
                                               onchange="this.form.submit()">
                                    </form>
                                    <a href="${pageContext.request.contextPath}/cart/remove?productId=${item.product.id}" 
                                       class="btn btn-delete"
                                       onclick="return confirm('Удалить товар из корзины?')">Удалить</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="cart-summary">
                        <h3>Итого</h3>
                        <div class="summary-row">
                            <span>Товаров:</span>
                            <span>${cart.totalItems} шт.</span>
                        </div>
                        <div class="summary-total">
                            <span>Сумма:</span>
                            <span>${cart.totalPrice} ₽</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/cart/checkout" class="btn checkout-btn">
                            Оформить заказ
                        </a>
                        <a href="${pageContext.request.contextPath}/cart/clear" 
                           class="btn btn-delete" 
                           style="width: 100%; margin-top: 10px; text-align: center;"
                           onclick="return confirm('Очистить корзину?')">
                           Очистить корзину
                        </a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-cart">
                    <h3>Корзина пуста</h3>
                    <p style="color: #999; margin-bottom: 20px;">Добавьте товары в корзину, чтобы оформить заказ</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn">Перейти к товарам</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
