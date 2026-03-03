<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Настройки профиля - Marketplace</title>
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
        
        .section {
            background: white;
            padding: 30px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .section h2 {
            color: #2C5F8D;
            margin-bottom: 20px;
            font-size: 24px;
        }
        
        .section h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
        }
        
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            position: relative;
        }
        
        .card.default {
            border-color: #2C5F8D;
            background: #f0f5f9;
        }
        
        .default-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #2C5F8D;
            color: white;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .card h4 {
            color: #333;
            margin-bottom: 10px;
            font-size: 16px;
        }
        
        .card p {
            color: #666;
            margin: 5px 0;
            font-size: 14px;
        }
        
        .card-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
            font-size: 14px;
        }
        
        input[type="text"],
        input[type="email"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        input:focus {
            outline: none;
            border-color: #2C5F8D;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
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
        
        .btn-small {
            padding: 6px 12px;
            font-size: 13px;
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .btn-delete {
            background: #dc3545;
        }
        
        .btn-delete:hover {
            background: #c82333;
        }
        
        .no-items {
            text-align: center;
            padding: 30px;
            color: #999;
            font-style: italic;
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
        <div class="section">
            <h2>⚙️ Настройки профиля</h2>
            <p style="color: #666;">Управление адресами доставки и способами оплаты</p>
        </div>
        
        <!-- Адреса доставки -->
        <div class="section">
            <h2>📍 Адреса доставки</h2>
            
            <c:choose>
                <c:when test="${not empty addresses}">
                    <div class="cards-grid">
                        <c:forEach var="address" items="${addresses}">
                            <div class="card ${address['default'] ? 'default' : ''}">
                                <c:if test="${address['default']}">
                                    <div class="default-badge">По умолчанию</div>
                                </c:if>
                                <h4>${address.addressName}</h4>
                                <p><strong>Адрес:</strong> ${address.fullAddress}</p>
                                <p><strong>Город:</strong> ${address.city}</p>
                                <p><strong>Индекс:</strong> ${address.postalCode}</p>
                                <div class="card-actions">
                                    <c:if test="${!address['default']}">
                                        <a href="${pageContext.request.contextPath}/profile/address/setDefault?id=${address.id}" 
                                           class="btn btn-small btn-secondary">Сделать основным</a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/profile/address/delete?id=${address.id}" 
                                       class="btn btn-small btn-delete"
                                       onclick="return confirm('Удалить этот адрес?')">Удалить</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-items">Адреса не добавлены</div>
                </c:otherwise>
            </c:choose>
            
            <h3>Добавить новый адрес</h3>
            <form:form action="${pageContext.request.contextPath}/profile/address/add" 
                       method="POST" 
                       modelAttribute="newAddress">
                <div class="form-group">
                    <label>Название адреса:</label>
                    <form:input path="addressName" placeholder="Например: Дом, Работа" required="required" />
                </div>
                <div class="form-group">
                    <label>Полный адрес:</label>
                    <form:input path="fullAddress" placeholder="Улица, дом, квартира" required="required" />
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Город:</label>
                        <form:input path="city" required="required" />
                    </div>
                    <div class="form-group">
                        <label>Почтовый индекс:</label>
                        <form:input path="postalCode" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <form:checkbox path="default" />
                        <span>Сделать основным адресом</span>
                    </label>
                </div>
                <button type="submit" class="btn">Добавить адрес</button>
            </form:form>
        </div>
        
        <!-- Способы оплаты -->
        <div class="section">
            <h2>💳 Способы оплаты</h2>
            
            <c:choose>
                <c:when test="${not empty paymentMethods}">
                    <div class="cards-grid">
                        <c:forEach var="payment" items="${paymentMethods}">
                            <div class="card ${payment['default'] ? 'default' : ''}">
                                <c:if test="${payment['default']}">
                                    <div class="default-badge">По умолчанию</div>
                                </c:if>
                                <h4>${payment.methodName}</h4>
                                <p><strong>Карта:</strong> ${payment.maskedCardNumber}</p>
                                <p><strong>Владелец:</strong> ${payment.cardholderName}</p>
                                <div class="card-actions">
                                    <c:if test="${!payment['default']}">
                                        <a href="${pageContext.request.contextPath}/profile/payment/setDefault?id=${payment.id}" 
                                           class="btn btn-small btn-secondary">Сделать основным</a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/profile/payment/delete?id=${payment.id}" 
                                       class="btn btn-small btn-delete"
                                       onclick="return confirm('Удалить этот способ оплаты?')">Удалить</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-items">Способы оплаты не добавлены</div>
                </c:otherwise>
            </c:choose>
            
            <h3>Добавить способ оплаты</h3>
            <form:form action="${pageContext.request.contextPath}/profile/payment/add" 
                       method="POST" 
                       modelAttribute="newPaymentMethod">
                <div class="form-group">
                    <label>Название:</label>
                    <form:input path="methodName" placeholder="Например: Основная карта, Рабочая карта" required="required" />
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Номер карты:</label>
                        <form:input path="cardNumber" placeholder="1234 5678 9012 3456" required="required" maxlength="16" />
                    </div>
                    <div class="form-group">
                        <label>Имя владельца:</label>
                        <form:input path="cardholderName" placeholder="IVAN IVANOV" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <form:checkbox path="default" />
                        <span>Сделать основным способом оплаты</span>
                    </label>
                </div>
                <button type="submit" class="btn">Добавить способ оплаты</button>
            </form:form>
        </div>
        
        <div style="text-align: center; margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Вернуться в профиль</a>
        </div>
    </div>
</body>
</html>
