<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 검색</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>

<div class="container">
    <div class="page-title">리뷰 <span>검색</span></div>

    <div class="search-wrap">
        <form class="search-box" action="${pageContext.request.contextPath}/review/search" method="get">
            <input type="text" name="keyword" value="${keyword}" placeholder="🔍  리뷰 내용 검색">
            <select name="sentiment">
                <option value="">감성 전체</option>
                <option value="긍정" ${sentiment == '긍정' ? 'selected' : ''}>긍정</option>
                <option value="중립" ${sentiment == '중립' ? 'selected' : ''}>중립</option>
                <option value="부정" ${sentiment == '부정' ? 'selected' : ''}>부정</option>
            </select>
            <select name="skinType">
                <option value="">피부타입 전체</option>
                <option value="건성" ${skinType == '건성' ? 'selected' : ''}>건성</option>
                <option value="지성" ${skinType == '지성' ? 'selected' : ''}>지성</option>
                <option value="복합성" ${skinType == '복합성' ? 'selected' : ''}>복합성</option>
                <option value="민감성" ${skinType == '민감성' ? 'selected' : ''}>민감성</option>
            </select>
            <button type="submit">검색</button>
        </form>
    </div>

    <div class="table-wrap">
        <div class="table-header">
            <h3>검색 결과</h3>
            <span class="count">총 ${totalCount}건</span>
        </div>
        <table>
            <thead>
                <tr><th>상품</th><th>닉네임</th><th>평점</th><th>피부타입</th><th>감성</th><th>리뷰 내용</th></tr>
            </thead>
            <tbody>
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td><strong style="color:#e8507a;font-size:11px;">${review.brandName}</strong><br><span style="font-size:12px;">${review.productName}</span></td>
                    <td>${review.nickname}</td>
                    <td><span class="star-rating">★</span> ${review.rating}</td>
                    <td style="font-size:12px;color:#6b7280;max-width:120px;">${review.skinType}</td>
                    <td>
                        <c:choose>
                            <c:when test="${review.sentiment == '긍정'}"><span class="badge positive">긍정</span></c:when>
                            <c:when test="${review.sentiment == '부정'}"><span class="badge negative">부정</span></c:when>
                            <c:otherwise><span class="badge neutral">${review.sentiment}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td style="max-width:300px;font-size:13px;line-height:1.5;">${review.reviewText}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <c:if test="${page > 1}">
            <a href="${pageContext.request.contextPath}/review/search?keyword=${keyword}&sentiment=${sentiment}&skinType=${skinType}&page=${page-1}">‹</a>
        </c:if>
        <c:forEach begin="1" end="${totalPage}" var="p">
            <a class="${p == page ? 'active' : ''}"
               href="${pageContext.request.contextPath}/review/search?keyword=${keyword}&sentiment=${sentiment}&skinType=${skinType}&page=${p}">${p}</a>
        </c:forEach>
        <c:if test="${page < totalPage}">
            <a href="${pageContext.request.contextPath}/review/search?keyword=${keyword}&sentiment=${sentiment}&skinType=${skinType}&page=${page+1}">›</a>
        </c:if>
    </div>
</div>
</body>
</html>
