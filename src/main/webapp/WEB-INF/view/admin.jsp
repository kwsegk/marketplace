<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Админ-панель - Marketplace</title>
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
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .admin-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .admin-header h2 {
            color: #2C5F8D;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .admin-header p {
            color: #666;
            font-size: 16px;
        }
        
        .seller-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .seller-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #2C5F8D;
        }
        
        .seller-info h3 {
            color: #2C5F8D;
            font-size: 22px;
            margin-bottom: 5px;
        }
        
        .seller-info p {
            color: #666;
            font-size: 14px;
        }
        
        .seller-badge {
            padding: 6px 12px;
            background: #2C5F8D;
            color: white;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 500;
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .product-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: transform 0.2s;
        }
        
        .product-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .product-card h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }
        
        .product-card p {
            color: #666;
            margin: 8px 0;
            font-size: 14px;
            line-height: 1.5;
        }
        
        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #2C5F8D;
            margin: 12px 0;
        }
        
        .product-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        
        .btn-delete {
            padding: 10px 20px;
            background: #dc3545;
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
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .no-products {
            text-align: center;
            padding: 30px;
            color: #999;
            font-style: italic;
        }
        
        .no-sellers {
            background: white;
            padding: 60px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .no-sellers h3 {
            color: #666;
            font-size: 20px;
        }
        
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .stat-card h4 {
            color: #2C5F8D;
            font-size: 32px;
            margin-bottom: 8px;
        }
        
        .stat-card p {
            color: #666;
            font-size: 14px;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1><a href="${pageContext.request.contextPath}/admin" class="logo">Marketplace</a></h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/admin">Админ-панель</a>
            <a href="${pageContext.request.contextPath}/logout">Выйти</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${param.error == 'cannot_delete'}">
            <div class="error-message">
                <strong>Ошибка!</strong> Невозможно удалить товар, так как он присутствует в истории заказов покупателей.
            </div>
        </c:if>
        
        <div class="admin-header">
            <h2>🛡️ Панель администратора</h2>
            <p>Управление пользователями, продавцами и модерация товаров</p>
        </div>
        
        <c:set var="totalSellers" value="${sellers.size()}" />
        <c:set var="totalBuyers" value="${buyers.size()}" />
        <c:set var="totalProducts" value="0" />
        <c:set var="totalOrders" value="0" />
        <c:forEach var="seller" items="${sellers}">
            <c:set var="totalProducts" value="${totalProducts + seller.products.size()}" />
        </c:forEach>
        <c:forEach var="buyer" items="${buyers}">
            <c:set var="totalOrders" value="${totalOrders + buyer.orders.size()}" />
        </c:forEach>
        
        <div class="stats">
            <div class="stat-card">
                <h4>${totalSellers}</h4>
                <p>Продавцов</p>
            </div>
            <div class="stat-card">
                <h4>${totalProducts}</h4>
                <p>Товаров</p>
            </div>
            <div class="stat-card">
                <h4>${totalBuyers}</h4>
                <p>Покупателей</p>
            </div>
            <div class="stat-card">
                <h4>${totalOrders}</h4>
                <p>Заказов</p>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty sellers}">
                <c:forEach var="seller" items="${sellers}">
                    <div class="seller-section">
                        <div class="seller-header">
                            <div class="seller-info">
                                <h3>${seller.username}</h3>
                                <p>Email: ${seller.email} | ID: ${seller.id}</p>
                            </div>
                            <div style="display: flex; gap: 10px; align-items: center;">
                                <div class="seller-badge">
                                    <c:choose>
                                        <c:when test="${seller.role == 'ADMIN'}">Администратор</c:when>
                                        <c:when test="${seller.role == 'SELLER'}">Продавец</c:when>
                                        <c:otherwise>${seller.role}</c:otherwise>
                                    </c:choose>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/user/delete?id=${seller.id}" 
                                   class="btn-delete"
                                   onclick="return confirm('Вы действительно хотите удалить пользователя \'${seller.username}\' и все его товары? Это действие необратимо!')">
                                   Удалить профиль
                                </a>
                            </div>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty seller.products}">
                                <div class="products-grid">
                                    <c:forEach var="product" items="${seller.products}">
                                        <div class="product-card">
                                            <h4>${product.name}</h4>
                                            <p>${product.description}</p>
                                            <div class="product-price">${product.price} ₽</div>
                                            <p><strong>В наличии:</strong> ${product.quantity} шт.</p>
                                            <p><strong>ID товара:</strong> ${product.id}</p>
                                            
                                            <div class="product-actions">
                                                <a href="${pageContext.request.contextPath}/admin/product/delete?id=${product.id}" 
                                                   class="btn-delete"
                                                   onclick="return confirm('Вы действительно хотите удалить товар \'${product.name}\'? Это действие необратимо!')">
                                                   Удалить товар
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="no-products">
                                    Товары отсутствуют
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-sellers">
                    <h3>Продавцов пока нет</h3>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Раздел покупателей -->
        <div style="margin-top: 50px;">
            <div class="admin-header">
                <h2>👥 Покупатели</h2>
                <p>Управление покупателями и просмотр истории заказов</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty buyers}">
                    <c:forEach var="buyer" items="${buyers}">
                        <div class="seller-section">
                            <div class="seller-header">
                                <div class="seller-info">
                                    <h3>${buyer.username}</h3>
                                    <p>Email: ${buyer.email} | ID: ${buyer.id}</p>
                                </div>
                                <div style="display: flex; gap: 10px; align-items: center;">
                                    <div class="seller-badge" style="background: #28a745;">Покупатель</div>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete?id=${buyer.id}" 
                                       class="btn-delete"
                                       onclick="return confirm('Вы действительно хотите удалить пользователя \'${buyer.username}\' и всю его историю заказов? Это действие необратимо!')">
                                       Удалить профиль
                                    </a>
                                </div>
                            </div>
                            
                            <c:choose>
                                <c:when test="${not empty buyer.orders}">
                                    <div style="margin-top: 20px;">
                                        <h4 style="color: #2C5F8D; margin-bottom: 15px;">История заказов (${buyer.orders.size()})</h4>
                                        <div style="display: grid; gap: 15px;">
                                            <c:forEach var="order" items="${buyer.orders}">
                                                <div style="background: white; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;">
                                                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                                        <div>
                                                            <strong>Заказ #${order.id}</strong>
                                                            <p style="color: #666; font-size: 14px; margin-top: 5px;">
                                                                Дата: ${order.orderDate}
                                                            </p>
                                                        </div>
                                                        <div style="text-align: right;">
                                                            <p style="font-size: 20px; font-weight: bold; color: #2C5F8D;">
                                                                ${order.totalPrice} ₽
                                                            </p>
                                                            <p style="color: #666; font-size: 14px;">
                                                                Статус: ${order.status}
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <c:if test="${order.address != null}">
                                                        <p style="color: #666; font-size: 14px; margin: 5px 0;">
                                                            📍 Адрес: ${order.address.fullAddress}, ${order.address.city}
                                                        </p>
                                                    </c:if>
                                                    <c:if test="${order.paymentMethod != null}">
                                                        <p style="color: #666; font-size: 14px; margin: 5px 0;">
                                                            💳 Оплата: ${order.paymentMethod.methodName}
                                                        </p>
                                                    </c:if>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-products">
                                        Заказов пока нет
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-sellers">
                        <h3>Покупателей пока нет</h3>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
