<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Профиль - ${sessionScope.username}</title>
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
        
        .profile-header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .profile-header h2 {
            color: #2C5F8D;
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        .profile-info p {
            color: #333;
            font-size: 16px;
            margin: 8px 0;
        }
        
        .profile-info strong {
            color: #2C5F8D;
        }
        
        .section {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .section h3 {
            color: #2C5F8D;
            margin-bottom: 20px;
            font-size: 22px;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
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
            text-align: center;
            transition: background 0.3s;
        }
        
        .btn:hover {
            background: #1e4466;
        }
        
        .btn-delete {
            background: #dc3545;
        }
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        
        .product-card {
            background: white;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
        }
        
        .product-card h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }
        
        .product-card p {
            color: #666;
            margin: 5px 0;
            font-size: 14px;
        }
        
        .product-price {
            font-size: 20px;
            font-weight: bold;
            color: #2C5F8D;
            margin: 12px 0;
        }
        
        .no-products {
            text-align: center;
            padding: 40px;
            color: #666;
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
        <h1><a href="${pageContext.request.contextPath}/" class="logo">Marketplace</a></h1>
        <div class="navbar-right">
            <a href="${pageContext.request.contextPath}/products">Товары</a>
            <a href="${pageContext.request.contextPath}/">Профиль</a>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${param.error == 'cannot_delete'}">
            <div class="error-message">
                <strong>Ошибка!</strong> Невозможно удалить товар, так как он присутствует в истории заказов покупателей.
            </div>
        </c:if>
        
        <div class="profile-header">
            <h2>Профиль</h2>
            <div class="profile-info">
                <p><strong>Пользователь:</strong> ${sessionScope.username}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Роль:</strong> 
                    <c:choose>
                        <c:when test="${sessionScope.role == 'USER'}">Покупатель</c:when>
                        <c:when test="${sessionScope.role == 'SELLER'}">Продавец</c:when>
                        <c:when test="${sessionScope.role == 'ADMIN'}">Администратор</c:when>
                        <c:otherwise>${sessionScope.role}</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
        
        <div class="section">
            <h3>Действия</h3>
            <div class="actions-grid">
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin" class="btn" style="background: #6c757d;">Админ-панель</a>
                </c:if>
                <c:if test="${sessionScope.role == 'SELLER'}">
                    <a href="${pageContext.request.contextPath}/products/add" class="btn">Добавить товар</a>
                </c:if>
                <c:if test="${sessionScope.role != 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/profile/settings" class="btn">Настройки профиля</a>
                    <a href="${pageContext.request.contextPath}/orders" class="btn">История заказов</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" class="btn">Выйти</a>
                <a href="${pageContext.request.contextPath}/user/delete" 
                   class="btn btn-delete"
                   onclick="return confirm('Вы действительно хотите удалить свой аккаунт? Это действие необратимо!')">
                   Удалить аккаунт
                </a>
            </div>
        </div>
        
        <c:if test="${sessionScope.role == 'SELLER'}">
            <div class="section">
                <h3>Мои товары</h3>
                
                <c:choose>
                    <c:when test="${not empty user.products}">
                        <div class="products-grid">
                            <c:forEach var="product" items="${user.products}">
                                <div class="product-card">
                                    <c:if test="${product.imageUrl != null && !product.imageUrl.isEmpty()}">
                                        <img src="${product.imageUrl}" alt="${product.name}" style="width: 100%; height: 150px; object-fit: contain; border-radius: 8px; margin-bottom: 10px; background: #f8f9fa;" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                        <div style="display: none; width: 100%; height: 150px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; margin-bottom: 10px; align-items: center; justify-content: center; color: white; flex-direction: column;">
                                            <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity: 0.9;">
                                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                                <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                                <polyline points="21 15 16 10 5 21"></polyline>
                                            </svg>
                                            <span style="font-size: 12px; margin-top: 8px; opacity: 0.8;">Изображение</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${product.imageUrl == null || product.imageUrl.isEmpty()}">
                                        <div style="width: 100%; height: 150px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; margin-bottom: 10px; display: flex; align-items: center; justify-content: center; color: white; flex-direction: column;">
                                            <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity: 0.9;">
                                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                                <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                                <polyline points="21 15 16 10 5 21"></polyline>
                                            </svg>
                                            <span style="font-size: 12px; margin-top: 8px; opacity: 0.8;">Изображение</span>
                                        </div>
                                    </c:if>
                                    <h4>${product.name}</h4>
                                    <p>${product.description}</p>
                                    <div class="product-price">${product.price} ₽</div>
                                    <p><strong>В наличии:</strong> ${product.quantity} шт.</p>
                                    <a href="${pageContext.request.contextPath}/products/delete?id=${product.id}" 
                                       class="btn btn-delete"
                                       style="margin-top: 10px; display: block;"
                                       onclick="return confirm('Вы уверены, что хотите удалить товар?')">
                                       Удалить
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-products">
                            <p>У вас пока нет товаров</p>
                            <a href="${pageContext.request.contextPath}/products/add" class="btn" style="margin-top: 15px;">Добавить первый товар</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</body>
</html>
