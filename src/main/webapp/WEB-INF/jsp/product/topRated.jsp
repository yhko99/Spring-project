<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>평점 Top 10</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="container">
    <div class="page-title">평점 <span>Top 10</span></div>
    <div class="table-wrap">
        <div class="table-header">
            <h3>⭐ 평점 높은 상품</h3>
            <span class="count">리뷰 5건 이상 기준</span>
        </div>
        <table>
            <thead><tr><th>순위</th><th>브랜드</th><th>상품명</th><th>가격</th><th>평균 평점</th><th>리뷰 수</th></tr></thead>
            <tbody>
            <c:forEach var="product" items="${productList}" varStatus="st">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${st.index == 0}"><span class="rank top1">1</span></c:when>
                            <c:when test="${st.index == 1}"><span class="rank top2">2</span></c:when>
                            <c:when test="${st.index == 2}"><span class="rank top3">3</span></c:when>
                            <c:otherwise><span class="rank rest">${st.index + 1}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td><span style="color:#e8507a;font-weight:600;font-size:12px;">${product.brandName}</span></td>
                    <td><a href="${pageContext.request.contextPath}/product/detail?productId=${product.productId}" style="color:var(--text);text-decoration:none;font-weight:500;" onmouseover="this.style.color='var(--accent)'" onmouseout="this.style.color='var(--text)'">${product.productName}</a></td>
                    <td>${product.price}원</td>
                    <td><span class="star-rating">★</span> <strong>${product.avgRating}</strong></td>
                    <td>${product.reviewCount}건</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
