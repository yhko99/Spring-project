<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>브랜드별 분석</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>

<div class="container">
    <div class="page-title">브랜드 <span>분석</span></div>
    <div class="chart-row">
        <div class="table-wrap">
            <div class="table-header">
                <h3>⭐ 평균 평점 랭킹</h3>
                <span class="count">리뷰 5건 이상</span>
            </div>
            <table>
                <thead><tr><th>순위</th><th>브랜드</th><th>평균 평점</th><th>리뷰 수</th></tr></thead>
                <tbody>
                <c:forEach var="row" items="${ratingRanking}" varStatus="st">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${st.index == 0}"><span class="rank top1">${st.index + 1}</span></c:when>
                                <c:when test="${st.index == 1}"><span class="rank top2">${st.index + 1}</span></c:when>
                                <c:when test="${st.index == 2}"><span class="rank top3">${st.index + 1}</span></c:when>
                                <c:otherwise><span class="rank rest">${st.index + 1}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><a class="rank-link" href="${pageContext.request.contextPath}/brand/detail?brandName=${row.brandName}">${row.brandName}</a></td>
                        <td><span class="star-rating">★</span> ${row.avgRating}</td>
                        <td>${row.reviewCount}건</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="table-wrap">
            <div class="table-header">
                <h3>💬 리뷰 수 랭킹</h3>
                <span class="count">전체 브랜드</span>
            </div>
            <table>
                <thead><tr><th>순위</th><th>브랜드</th><th>리뷰 수</th></tr></thead>
                <tbody>
                <c:forEach var="row" items="${reviewRanking}" varStatus="st">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${st.index == 0}"><span class="rank top1">${st.index + 1}</span></c:when>
                                <c:when test="${st.index == 1}"><span class="rank top2">${st.index + 1}</span></c:when>
                                <c:when test="${st.index == 2}"><span class="rank top3">${st.index + 1}</span></c:when>
                                <c:otherwise><span class="rank rest">${st.index + 1}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><a class="rank-link" href="${pageContext.request.contextPath}/brand/detail?brandName=${row.brandName}">${row.brandName}</a></td>
                        <td>${row.reviewCount}건</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
