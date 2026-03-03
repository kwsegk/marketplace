<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Регистрация - Marketplace</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #2C5F8D;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }
        
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            width: 100%;
            padding: 12px;
            background: #2C5F8D;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .error {
            background-color: #fee;
            color: #c33;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #c33;
        }
        
        .link-container {
            text-align: center;
            margin-top: 20px;
        }
        
        .link-container a {
            color: #2C5F8D;
            text-decoration: none;
        }
        
        .link-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Регистрация</h2>
        
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>
        
        <form:form action="${pageContext.request.contextPath}/register" 
                   method="POST" 
                   modelAttribute="user">
            
            <div class="form-group">
                <label for="username">Имя пользователя:</label>
                <form:input path="username" id="username" required="required" />
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <form:input path="email" type="email" id="email" required="required" />
            </div>
            
            <div class="form-group">
                <label for="password">Пароль:</label>
                <form:password path="password" id="password" required="required" />
            </div>
            
            <div class="form-group">
                <label for="role">Тип аккаунта:</label>
                <form:select path="role" id="role" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;">
                    <form:option value="USER">Покупатель</form:option>
                    <form:option value="SELLER">Продавец</form:option>
                    <form:option value="ADMIN">Администратор</form:option>
                </form:select>
            </div>
            
            <button type="submit" class="btn">Зарегистрироваться</button>
        </form:form>
        
        <div class="link-container">
            <p>Уже есть аккаунт? <a href="${pageContext.request.contextPath}/login">Войти</a></p>
        </div>
    </div>
</body>
</html>
