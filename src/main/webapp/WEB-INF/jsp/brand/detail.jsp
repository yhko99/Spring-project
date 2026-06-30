<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${brandName} 브랜드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .brand-hero { background: var(--primary); color: #fff; border-radius: var(--radius); padding: 32px 36px; margin-bottom: 24px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px; }
        .brand-hero h1 { font-size: 26px; font-weight: 800; letter-spacing: -0.5px; margin-bottom: 4px; }
        .brand-hero p { color: rgba(255,255,255,0.6); font-size: 13px; }
        .brand-stats { display: flex; gap: 24px; flex-wrap: wrap; }
        .bstat { text-align: center; }
        .bstat .num { font-size: 28px; font-weight: 800; color: #e8507a; }
        .bstat .lbl { font-size: 12px; color: rgba(255,255,255,0.6); margin-top: 2px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 16px; }
        .p-card { background: var(--card); border-radius: var(--radius); padding: 20px; box-shadow: var(--shadow); border: 1px solid var(--border); transition: transform 0.2s, box-shadow 0.2s; cursor: pointer; text-decoration: none; display: block; color: inherit; }
        .p-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-hover); }
        .p-card .p-name { font-size: 13px; font-weight: 600; line-height: 1.5; margin-bottom: 12px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 40px; }
        .p-card .p-price { font-size: 16px; font-weight: 800; color: var(--accent); }
        .p-card .p-orig { font-size: 11px; color: var(--text-muted); text-decoration: line-through; margin-left: 6px; }
        .p-card .p-rating { display: flex; align-items: center; gap: 5px; margin-top: 10px; padding-top: 10px; border-top: 1px solid var(--border); font-size: 12px; color: var(--text-sub); }
        .p-card .p-rating .star { color: #fbbf24; }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="container">

    <div class="brand-hero">
        <div>
            <div style="font-size:11px;color:rgba(255,255,255,0.5);margin-bottom:6px;">BRAND</div>
            <h1>${brandName}</h1>
            <p><a href="${pageContext.request.contextPath}/brand" style="color:rgba(255,255,255,0.5);text-decoration:none;">← 브랜드 목록으로</a></p>
        </div>
        <div class="brand-stats">
            <div class="bstat">
                <div class="num"><fmt:formatNumber value="${brandStats.PRODUCTCOUNT}" pattern="#,###"/></div>
                <div class="lbl">상품 수</div>
            </div>
            <div class="bstat">
                <div class="num">★ ${brandStats.AVGRATING}</div>
                <div class="lbl">평균 평점</div>
            </div>
            <div class="bstat">
                <div class="num"><fmt:formatNumber value="${brandStats.TOTALREVIEWS}" pattern="#,###"/></div>
                <div class="lbl">총 리뷰 수</div>
            </div>
        </div>
    </div>

    <div class="table-header" style="margin-bottom:16px;">
        <h3>🛍️ 상품 목록</h3>
        <span class="count">리뷰 많은 순</span>
    </div>

    <div class="product-grid">
        <c:forEach var="p" items="${productList}">
            <a href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}" class="p-card">
                <div class="p-name">${p.productName}</div>
                <div>
                    <span class="p-price"><fmt:formatNumber value="${p.price}" pattern="#,###"/>원</span>
                    <c:if test="${p.originalPrice > p.price}">
                        <span class="p-orig"><fmt:formatNumber value="${p.originalPrice}" pattern="#,###"/>원</span>
                    </c:if>
                </div>
                <div class="p-rating">
                    <span class="star">★</span>
                    <strong>${p.avgRating > 0 ? p.avgRating : '-'}</strong>
                    <span style="margin-left:4px;">리뷰 ${p.reviewCount}건</span>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
