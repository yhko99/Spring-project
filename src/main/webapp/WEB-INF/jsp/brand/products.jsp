<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${brandName} 상품 목록</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>

<div class="container">
    <h2>${brandName} 상품 목록</h2>
    <div class="product-grid">
        <c:forEach var="product" items="${productList}">
            <div class="product-card">
                <p class="brand">${product.brandName}</p>
                <h4>${product.productName}</h4>
                <p class="price">${product.price}원</p>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
