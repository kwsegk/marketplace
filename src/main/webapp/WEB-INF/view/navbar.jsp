<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="navbar">
    <h1><a href="${pageContext.request.contextPath}/products" class="logo">Marketplace</a></h1>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/products">Товары</a>
        <a href="${pageContext.request.contextPath}/">Профиль</a>
    </div>
</div>

<style>
.navbar {
    background: #2C5F8D;
    padding: 15px 30px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar h1 {
    font-size: 24px;
    margin: 0;
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
    gap: 15px;
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
</style>
