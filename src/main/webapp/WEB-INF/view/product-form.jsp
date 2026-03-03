<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Добавить товар - Marketplace</title>
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
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
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus {
            outline: none;
            border-color: #2C5F8D;
        }
        
        textarea {
            resize: vertical;
            min-height: 100px;
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
        
        .btn-secondary {
            background: #6c757d;
            margin-top: 10px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        
        .back-link a {
            color: #2C5F8D;
            text-decoration: none;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
            text-align: center;
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
        <div class="form-container">
            <h2>Добавить новый товар</h2>
            
            <form action="${pageContext.request.contextPath}/products/add" 
                  method="POST">
                
                <div class="form-group">
                    <label for="name">Название товара:</label>
                    <input type="text" name="name" id="name" placeholder="Например: iPhone 15 Pro" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; font-family: inherit;" />
                </div>
                
                <div class="form-group">
                    <label for="description">Описание:</label>
                    <textarea name="description" id="description" 
                              placeholder="Подробное описание товара..." 
                              required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; font-family: inherit; resize: vertical; min-height: 100px;"></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">Цена (₽):</label>
                        <input type="number" name="price" step="0.01" min="0" 
                               id="price" placeholder="0.00" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;" />
                    </div>
                    
                    <div class="form-group">
                        <label for="quantity">Количество:</label>
                        <input type="number" name="quantity" min="0" 
                               id="quantity" placeholder="0" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;" />
                    </div>
                </div>
                
                <button type="submit" class="btn">Добавить товар</button>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/">← Вернуться в профиль</a>
            </div>
        </div>
    </div>
</body>
</html>
