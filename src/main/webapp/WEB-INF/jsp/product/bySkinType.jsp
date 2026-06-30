<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>피부타입별 추천</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="container">
    <div class="page-title">피부타입별 <span>추천 상품</span></div>
    <div class="skin-select-wrap">
        <form action="${pageContext.request.contextPath}/product/bySkinType" method="get" style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
            <label>내 피부타입</label>
            <select name="skinType">
                <option value="">선택하세요</option>
                <option value="건성" ${skinType == '건성' ? 'selected' : ''}>건성</option>
                <option value="지성" ${skinType == '지성' ? 'selected' : ''}>지성</option>
                <option value="복합성" ${skinType == '복합성' ? 'selected' : ''}>복합성</option>
                <option value="민감성" ${skinType == '민감성' ? 'selected' : ''}>민감성</option>
            </select>
            <button type="submit">추천 받기</button>
        </form>
    </div>

    <c:if test="${not empty productList}">
        <div class="table-wrap">
            <div class="table-header">
                <h3>✨ ${skinType} 피부 추천 상품</h3>
                <span class="count">평점순</span>
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
                        <td style="font-weight:500;">${product.productName}</td>
                        <td>${product.price}원</td>
                        <td><span class="star-rating">★</span> <strong>${product.avgRating}</strong></td>
                        <td>${product.reviewCount}건</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
</body>
</html>
