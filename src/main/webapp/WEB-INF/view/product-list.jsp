<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Все товары - Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
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
            transition: opacity 0.3s;
        }
        
        .navbar .logo:hover {
            opacity: 0.8;
        }
        
        .navbar-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        .navbar-right a {
            color: white;
            text-decoration: none;
            padding: 8px 20px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            transition: background 0.3s;
            font-size: 15px;
            font-weight: 500;
        }
        
        .navbar-right a:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .header h2 {
            color: #333;
            margin-bottom: 20px;
        }
        
        .search-filter-form {
            display: flex;
            gap: 15px;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        
        .search-filter-form input[type="text"],
        .search-filter-form select {
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            min-width: 200px;
        }
        
        .search-filter-form input[type="text"]:focus,
        .search-filter-form select:focus {
            outline: none;
            border-color: #2C5F8D;
        }
        
        .search-filter-form button {
            padding: 10px 25px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .search-filter-form button:hover {
            background: #1e4060;
        }
        
        .reset-link {
            color: #2C5F8D;
            text-decoration: none;
            font-size: 14px;
            padding: 10px 15px;
        }
        
        .reset-link:hover {
            text-decoration: underline;
        }
        
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }
        
        .product-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }
        
        .product-card h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }
        
        .product-description {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
            line-height: 1.5;
            min-height: 60px;
        }
        
        .product-price {
            font-size: 24px;
            font-weight: bold;
            color: #2C5F8D;
            margin: 15px 0;
        }
        
        .product-info {
            color: #888;
            font-size: 13px;
            margin: 5px 0;
        }
        
        .product-seller {
            display: inline-block;
            background: #f0f0f0;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            color: #666;
            margin-top: 10px;
        }
        
        .no-products {
            text-align: center;
            background: white;
            padding: 60px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .no-products h3 {
            color: #999;
            margin-bottom: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-cart {
            width: 100%;
            margin-top: 15px;
            background: #28a745;
        }
        
        .btn-cart:hover {
            background: #218838;
        }
        
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.3s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .modal-content {
            background-color: white;
            margin: 2vh auto;
            padding: 30px;
            border-radius: 10px;
            width: 90%;
            max-width: 700px;
            max-height: 95vh;
            overflow-y: auto;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.3s;
        }
        
        .modal-content::-webkit-scrollbar {
            width: 8px;
        }
        
        .modal-content::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        .modal-content::-webkit-scrollbar-thumb {
            background: #2C5F8D;
            border-radius: 10px;
        }
        
        .modal-content::-webkit-scrollbar-thumb:hover {
            background: #1e4a6b;
        }
        
        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            line-height: 20px;
        }
        
        .close:hover {
            color: #000;
        }
        
        .modal-header h2 {
            color: #2C5F8D;
            margin: 0 0 20px 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #2C5F8D;
        }
        
        .modal-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }
        
        .modal-actions button {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit {
            background: #28a745;
            color: white;
        }
        
        .btn-submit:hover {
            background: #218838;
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
        }
        
        .btn-cancel:hover {
            background: #545b62;
        }
        
        .cart-icon {
            position: relative;
        }
        
        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1><a href="${pageContext.request.contextPath}/products" class="logo">Marketplace</a></h1>
        <div class="navbar-right">
            <c:if test="${sessionScope.role != 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/products">Товары</a>
                <a href="${pageContext.request.contextPath}/">Профиль</a>
                <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
                    🛒 Корзина
                    <c:if test="${sessionScope.cart != null && !sessionScope.cart.isEmpty()}">
                        <span class="cart-badge">${sessionScope.cart.totalItems}</span>
                    </c:if>
                </a>
            </c:if>
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin">Админ-панель</a>
                <a href="${pageContext.request.contextPath}/logout">Выйти</a>
            </c:if>
        </div>
    </div>
    
    <div class="container">
        <div class="header">
            <h2>Каталог товаров</h2>
            <form action="${pageContext.request.contextPath}/products" method="get" class="search-filter-form">
                <input type="text" name="search" placeholder="Поиск по названию..." value="${search != null ? search : ''}">
                <select name="sortBy">
                    <option value="">Сортировка</option>
                    <option value="date_desc" ${sortBy == 'date_desc' ? 'selected' : ''}>Сначала новые</option>
                    <option value="date_asc" ${sortBy == 'date_asc' ? 'selected' : ''}>Сначала старые</option>
                    <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Цена: по возрастанию</option>
                    <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Цена: по убыванию</option>
                    <option value="rating_desc" ${sortBy == 'rating_desc' ? 'selected' : ''}>Рейтинг: высокий</option>
                    <option value="rating_asc" ${sortBy == 'rating_asc' ? 'selected' : ''}>Рейтинг: низкий</option>
                </select>
                <button type="submit">Найти</button>
                <a href="${pageContext.request.contextPath}/products" class="reset-link">Сбросить</a>
            </form>
        </div>
        
        <c:choose>
            <c:when test="${not empty products}">
                <div class="products-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card" 
                             data-product-id="${product.id}"
                             data-product-name="${product.name}"
                             data-product-description="${product.description}"
                             data-product-price="${product.price}"
                             data-product-quantity="${product.quantity}"
                             data-product-image="${product.imageUrl != null ? product.imageUrl : ''}"
                             data-product-seller="${product.user != null ? product.user.username : 'Продавец удален'}"
                             style="cursor: pointer;">
                            <c:if test="${product.imageUrl != null && !product.imageUrl.isEmpty()}">
                                <img src="${product.imageUrl}" alt="${product.name}" style="width: 100%; height: 200px; object-fit: contain; border-radius: 8px; margin-bottom: 15px; background: #f8f9fa;" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                <div style="display: none; width: 100%; height: 200px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; margin-bottom: 15px; align-items: center; justify-content: center; color: white; flex-direction: column;">
                                    <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity: 0.9;">
                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                        <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                        <polyline points="21 15 16 10 5 21"></polyline>
                                    </svg>
                                    <span style="font-size: 14px; margin-top: 10px; opacity: 0.8;">Изображение товара</span>
                                </div>
                            </c:if>
                            <c:if test="${product.imageUrl == null || product.imageUrl.isEmpty()}">
                                <div style="width: 100%; height: 200px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; margin-bottom: 15px; display: flex; align-items: center; justify-content: center; color: white; flex-direction: column;">
                                    <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity: 0.9;">
                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                        <circle cx="8.5" cy="8.5" r="1.5"></circle>
                                        <polyline points="21 15 16 10 5 21"></polyline>
                                    </svg>
                                    <span style="font-size: 14px; margin-top: 10px; opacity: 0.8;">Изображение товара</span>
                                </div>
                            </c:if>
                            <h3>${product.name}</h3>
                            <div class="product-description">${product.description}</div>
                            <div class="product-price">${product.price} ₽</div>
                            <div class="product-info">В наличии: ${product.quantity} шт.</div>
                            <c:if test="${averageRatingsMap[product.id] > 0}">
                                <div style="margin-top: 10px; padding: 5px 10px; background: #2C5F8D; color: white; border-radius: 5px; display: inline-block; font-weight: bold;">
                                    Оценка: ${averageRatingsMap[product.id]} / 5
                                </div>
                            </c:if>
                            <c:choose>
                                <c:when test="${product.user != null}">
                                    <span class="product-seller">Продавец: ${product.user.username}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="product-seller" style="background: #6c757d;">Продавец удален</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-products">
                    <h3>Товары пока не добавлены</h3>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Modal для детального просмотра товара -->
    <div id="productDetailModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeDetailModal()">&times;</span>
            <div class="modal-header">
                <h2 id="detailProductName"></h2>
            </div>
            
            <div id="detailImageContainer" style="display: none; margin-bottom: 20px;">
                <img id="detailProductImage" style="width: 100%; max-height: 300px; object-fit: contain; border-radius: 8px; background: #f8f9fa;" onerror="document.getElementById('detailImageContainer').style.display='none'; document.getElementById('detailPlaceholder').style.display='flex';">
            </div>
            
            <div id="detailPlaceholder" style="display: none; width: 100%; height: 250px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; margin-bottom: 20px; align-items: center; justify-content: center; flex-direction: column; color: white;">
                <svg width="100" height="100" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="opacity: 0.9;">
                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                    <circle cx="8.5" cy="8.5" r="1.5"></circle>
                    <polyline points="21 15 16 10 5 21"></polyline>
                </svg>
                <span style="font-size: 16px; margin-top: 15px; opacity: 0.8;">Изображение товара</span>
            </div>
            
            <div style="margin-bottom: 20px;">
                <p style="color: #666; line-height: 1.6; font-size: 15px;" id="detailDescription"></p>
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; padding: 20px; background: #f8f9fa; border-radius: 8px; margin-bottom: 20px;">
                <div>
                    <p style="color: #666; font-size: 14px; margin-bottom: 5px;">Цена:</p>
                    <p style="font-size: 28px; font-weight: bold; color: #2C5F8D;" id="detailPrice"></p>
                </div>
                <div style="text-align: right;">
                    <p style="color: #666; font-size: 14px; margin-bottom: 5px;">В наличии:</p>
                    <p style="font-size: 20px; font-weight: 500;" id="detailQuantity"></p>
                </div>
            </div>
            
            <div style="margin-bottom: 20px;">
                <p style="color: #666; font-size: 14px;">Продавец: <strong id="detailSeller"></strong></p>
            </div>
            
            <!-- Отзывы -->
            <div id="reviewsSection" style="margin-bottom: 20px; border-top: 1px solid #e0e0e0; padding-top: 20px;">
                <h3 style="color: #2C5F8D; margin-bottom: 15px;">Отзывы</h3>
                <div id="reviewsList"></div>
                
                <!-- Форма добавления отзыва (показывается только если товар куплен) -->
                <div id="reviewFormContainer" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
                    <h4 style="margin-bottom: 15px; color: #333;">Оставить отзыв</h4>
                    <form id="reviewForm" action="${pageContext.request.contextPath}/reviews/add" method="POST">
                        <input type="hidden" id="reviewProductId" name="productId">
                        
                        <div class="form-group">
                            <label style="display: block; margin-bottom: 10px; color: #555;">Оценка (от 1 до 5):</label>
                            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; padding: 8px 15px; border: 2px solid #ddd; border-radius: 5px; transition: all 0.3s;">
                                    <input type="radio" name="rating" value="5" required style="margin: 0;">
                                    <span style="font-size: 18px; font-weight: bold;">5</span>
                                </label>
                                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; padding: 8px 15px; border: 2px solid #ddd; border-radius: 5px; transition: all 0.3s;">
                                    <input type="radio" name="rating" value="4" style="margin: 0;">
                                    <span style="font-size: 18px; font-weight: bold;">4</span>
                                </label>
                                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; padding: 8px 15px; border: 2px solid #ddd; border-radius: 5px; transition: all 0.3s;">
                                    <input type="radio" name="rating" value="3" style="margin: 0;">
                                    <span style="font-size: 18px; font-weight: bold;">3</span>
                                </label>
                                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; padding: 8px 15px; border: 2px solid #ddd; border-radius: 5px; transition: all 0.3s;">
                                    <input type="radio" name="rating" value="2" style="margin: 0;">
                                    <span style="font-size: 18px; font-weight: bold;">2</span>
                                </label>
                                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px; padding: 8px 15px; border: 2px solid #ddd; border-radius: 5px; transition: all 0.3s;">
                                    <input type="radio" name="rating" value="1" style="margin: 0;">
                                    <span style="font-size: 18px; font-weight: bold;">1</span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="reviewComment">Комментарий:</label>
                            <textarea id="reviewComment" name="comment" rows="3" required style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-family: inherit;"></textarea>
                        </div>
                        
                        <button type="submit" class="btn-submit" style="width: auto; padding: 10px 20px;">Отправить отзыв</button>
                    </form>
                </div>
            </div>
            
            <form id="addToCartDetailForm" action="${pageContext.request.contextPath}/cart/add" method="POST" style="display: none;">
                <input type="hidden" id="detailProductId" name="productId">
                
                <div class="form-group">
                    <label for="detailQuantityInput">Количество:</label>
                    <input type="number" id="detailQuantityInput" name="quantity" min="1" value="1" required>
                </div>
                
                <div class="modal-actions">
                    <button type="submit" class="btn-submit">🛒 Добавить в корзину</button>
                    <button type="button" class="btn-cancel" onclick="closeDetailModal()">Закрыть</button>
                </div>
            </form>
            
            <div id="ownProductMessage" style="display: none; text-align: center; padding: 20px; background: #f8f9fa; border-radius: 8px; margin-top: 20px;">
                <p style="color: #666; margin-bottom: 20px; font-size: 16px;">Это ваш товар. Вы не можете купить его у себя.</p>
                <button type="button" class="btn-cancel" onclick="closeDetailModal()" style="padding: 12px 30px; font-size: 15px;">Закрыть</button>
            </div>
        </div>
    </div>
    
    <script>
        function openDetailModal(productId, productName, description, price, maxQuantity, imageUrl, seller) {
            document.getElementById('detailProductId').value = productId;
            document.getElementById('reviewProductId').value = productId;
            document.getElementById('detailProductName').textContent = productName;
            document.getElementById('detailDescription').textContent = description;
            document.getElementById('detailPrice').textContent = price + ' ₽';
            document.getElementById('detailQuantity').textContent = maxQuantity + ' шт.';
            document.getElementById('detailSeller').textContent = seller;
            document.getElementById('detailQuantityInput').max = maxQuantity;
            document.getElementById('detailQuantityInput').value = 1;
            
            // Проверяем, является ли это товаром текущего пользователя
            const userOwnIds = [<c:forEach var="id" items="${userOwnProductIds}" varStatus="status">${id}<c:if test="${!status.last}">,</c:if></c:forEach>];
            const addToCartForm = document.getElementById('addToCartDetailForm');
            const ownProductMessage = document.getElementById('ownProductMessage');
            
            if (userOwnIds.includes(productId)) {
                addToCartForm.style.display = 'none';
                ownProductMessage.style.display = 'block';
            } else {
                addToCartForm.style.display = 'block';
                ownProductMessage.style.display = 'none';
            }
            
            // Показываем изображение или placeholder
            if (imageUrl && imageUrl.trim() !== '') {
                document.getElementById('detailImageContainer').style.display = 'block';
                document.getElementById('detailProductImage').src = imageUrl;
                document.getElementById('detailPlaceholder').style.display = 'none';
            } else {
                document.getElementById('detailImageContainer').style.display = 'none';
                document.getElementById('detailPlaceholder').style.display = 'flex';
            }
            
            // Загружаем отзывы
            loadReviews(productId);
            
            // Проверяем, купил ли пользователь этот товар
            checkIfPurchased(productId);
            
            document.getElementById('productDetailModal').style.display = 'block';
        }
        
        function checkIfPurchased(productId) {
            const reviewFormContainer = document.getElementById('reviewFormContainer');
            const purchasedIds = [<c:forEach var="id" items="${purchasedProductIds}" varStatus="status">${id}<c:if test="${!status.last}">,</c:if></c:forEach>];
            const reviewedIds = [<c:forEach var="id" items="${reviewedProductIds}" varStatus="status">${id}<c:if test="${!status.last}">,</c:if></c:forEach>];
            
            // Показываем форму только если товар куплен И на него еще не оставлен отзыв
            if (purchasedIds.includes(productId) && !reviewedIds.includes(productId)) {
                reviewFormContainer.style.display = 'block';
            } else {
                reviewFormContainer.style.display = 'none';
                if (reviewedIds.includes(productId)) {
                    reviewFormContainer.innerHTML = '<p style="text-align: center; color: #666; padding: 20px;">Вы уже оставили отзыв на этот товар</p>';
                    reviewFormContainer.style.display = 'block';
                }
            }
        }
        
        function loadReviews(productId) {
            const reviewsList = document.getElementById('reviewsList');
            reviewsList.innerHTML = '<p style="color: #666;">Загрузка отзывов...</p>';
            
            // Получаем отзывы из серверной модели
            <c:forEach var="product" items="${products}">
                if (${product.id} == productId) {
                    let reviewsHTML = '';
                    <c:set var="reviews" value="${reviewsMap[product.id]}" />
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            <c:forEach var="review" items="${reviews}">
                                reviewsHTML += '<div style="padding: 15px; background: white; border: 1px solid #e0e0e0; border-radius: 8px; margin-bottom: 10px;">';
                                reviewsHTML += '<div style="display: flex; justify-content: space-between; margin-bottom: 10px;">';
                                reviewsHTML += '<strong style="color: #333;">${review.user.username}</strong>';
                                reviewsHTML += '<span style="background: #2C5F8D; color: white; padding: 3px 10px; border-radius: 5px; font-weight: bold;">${review.rating} / 5</span>';
                                reviewsHTML += '</div>';
                                reviewsHTML += '<p style="color: #666; margin: 0;">${review.comment}</p>';
                                reviewsHTML += '<p style="color: #999; font-size: 12px; margin-top: 10px;">${review.reviewDate}</p>';
                                reviewsHTML += '</div>';
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            reviewsHTML = '<p style="color: #999; text-align: center; padding: 20px;">Отзывов пока нет. Будьте первым!</p>';
                        </c:otherwise>
                    </c:choose>
                    reviewsList.innerHTML = reviewsHTML;
                }
            </c:forEach>
        }
        
        function closeDetailModal() {
            document.getElementById('productDetailModal').style.display = 'none';
            const reviewForm = document.getElementById('reviewForm');
            if (reviewForm) {
                reviewForm.reset();
            }
        }
        
        window.onclick = function(event) {
            const modal = document.getElementById('productDetailModal');
            if (event.target == modal) {
                closeDetailModal();
            }
        }
        
        // Добавляем обработчик клика на карточки товаров
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.product-card').forEach(function(card) {
                card.addEventListener('click', function() {
                    const productId = parseInt(this.dataset.productId);
                    const productName = this.dataset.productName;
                    const description = this.dataset.productDescription;
                    const price = parseFloat(this.dataset.productPrice);
                    const maxQuantity = parseInt(this.dataset.productQuantity);
                    const imageUrl = this.dataset.productImage || '';
                    const seller = this.dataset.productSeller;
                    
                    console.log('Product Image URL:', imageUrl);
                    console.log('Image URL length:', imageUrl.length);
                    
                    openDetailModal(productId, productName, description, price, maxQuantity, imageUrl, seller);
                });
            });
        });
    </script>
</body>
</html>
