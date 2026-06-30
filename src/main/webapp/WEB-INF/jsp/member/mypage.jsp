<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .my-grid { display: grid; grid-template-columns: 260px 1fr; gap: 24px; }
        .profile-card { background: var(--card); border-radius: var(--radius); padding: 28px; box-shadow: var(--shadow); border: 1px solid var(--border); height: fit-content; }
        .avatar { width: 72px; height: 72px; border-radius: 50%; background: var(--accent); color: #fff; display: flex; align-items: center; justify-content: center; font-size: 28px; font-weight: 800; margin: 0 auto 16px; }
        .profile-name { text-align: center; font-size: 18px; font-weight: 700; margin-bottom: 4px; }
        .profile-id { text-align: center; font-size: 12px; color: var(--text-muted); margin-bottom: 20px; }
        .profile-divider { height: 1px; background: var(--border); margin: 16px 0; }
        .profile-item { display: flex; justify-content: space-between; font-size: 13px; padding: 6px 0; }
        .profile-item .label { color: var(--text-muted); }
        .profile-item .value { font-weight: 600; }
        .wish-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 14px; }
        .w-card { background: var(--card); border-radius: var(--radius); padding: 18px; box-shadow: var(--shadow); border: 1px solid var(--border); transition: transform 0.2s; cursor: pointer; text-decoration: none; display: block; color: inherit; }
        .w-card:hover { transform: translateY(-3px); box-shadow: var(--shadow-hover); }
        .w-card .brand { color: var(--accent); font-size: 11px; font-weight: 700; margin-bottom: 6px; }
        .w-card .name { font-size: 13px; font-weight: 600; line-height: 1.5; margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; min-height: 40px; }
        .w-card .price { font-size: 15px; font-weight: 800; color: var(--accent); }
        .w-card .rating { font-size: 12px; color: var(--text-muted); margin-top: 8px; }
        .empty-wish { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        .empty-wish .icon { font-size: 48px; margin-bottom: 12px; }
        @media (max-width: 768px) { .my-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="container">
    <div class="page-title">마이 <span>페이지</span></div>

    <div class="my-grid">
        <!-- 프로필 카드 -->
        <div class="profile-card">
            <div class="avatar">${loginMember.memberName.substring(0,1)}</div>
            <div class="profile-name">${loginMember.memberName}</div>
            <div class="profile-id">@${loginMember.memberId}</div>

            <div class="profile-divider"></div>

            <div class="profile-item">
                <span class="label">아이디</span>
                <span class="value">${loginMember.memberId}</span>
            </div>
            <c:if test="${not empty loginMember.memberEmail}">
                <div class="profile-item">
                    <span class="label">이메일</span>
                    <span class="value" style="font-size:12px;">${loginMember.memberEmail}</span>
                </div>
            </c:if>
            <div class="profile-item">
                <span class="label">찜한 상품</span>
                <span class="value" style="color:var(--accent);">${wishList.size()}개</span>
            </div>

            <div class="profile-divider"></div>

            <a href="${pageContext.request.contextPath}/member/logout"
               style="display:block;text-align:center;padding:10px;border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:13px;color:var(--text-sub);text-decoration:none;transition:all 0.2s;"
               onmouseover="this.style.borderColor='var(--accent)';this.style.color='var(--accent)'"
               onmouseout="this.style.borderColor='var(--border)';this.style.color='var(--text-sub)'">
                로그아웃
            </a>
        </div>

        <!-- 찜 목록 -->
        <div>
            <div class="table-header" style="margin-bottom:16px;">
                <h3>❤️ 찜한 상품</h3>
                <span class="count">${wishList.size()}개</span>
            </div>

            <c:choose>
                <c:when test="${empty wishList}">
                    <div class="detail-card empty-wish">
                        <div class="icon">🤍</div>
                        <div>아직 찜한 상품이 없습니다</div>
                        <a href="${pageContext.request.contextPath}/product/topRated"
                           style="display:inline-block;margin-top:14px;padding:9px 20px;background:var(--accent);color:#fff;border-radius:var(--radius-sm);text-decoration:none;font-size:13px;font-weight:600;">
                            인기 상품 보러가기
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="wish-grid">
                        <c:forEach var="p" items="${wishList}">
                            <a href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}" class="w-card">
                                <div class="brand">${p.brandName}</div>
                                <div class="name">${p.productName}</div>
                                <div class="price"><fmt:formatNumber value="${p.price}" pattern="#,###"/>원</div>
                                <div class="rating">★ ${p.avgRating > 0 ? p.avgRating : '-'} · 리뷰 ${p.reviewCount}건</div>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
