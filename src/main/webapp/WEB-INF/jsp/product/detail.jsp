<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .detail-grid { display: grid; grid-template-columns: 340px 1fr; gap: 24px; margin-bottom: 28px; }
        .detail-card { background: var(--card); border-radius: var(--radius); padding: 28px; box-shadow: var(--shadow); border: 1px solid var(--border); }
        .product-brand { color: var(--accent); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; }
        .product-title { font-size: 18px; font-weight: 700; line-height: 1.5; margin-bottom: 18px; }
        .price-row { display: flex; align-items: baseline; gap: 10px; margin-bottom: 20px; }
        .price-main { font-size: 24px; font-weight: 800; color: var(--accent); }
        .price-orig { font-size: 14px; color: var(--text-muted); text-decoration: line-through; }
        .discount-badge { background: var(--accent); color: #fff; font-size: 12px; font-weight: 700; padding: 3px 8px; border-radius: 20px; }
        .rating-big { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; padding: 16px; background: var(--bg); border-radius: var(--radius-sm); }
        .rating-num { font-size: 36px; font-weight: 800; color: var(--primary); }
        .rating-stars { color: #fbbf24; font-size: 20px; letter-spacing: 2px; }
        .rating-sub { font-size: 12px; color: var(--text-muted); }
        .bar-row { display: flex; align-items: center; gap: 8px; margin-bottom: 6px; font-size: 12px; }
        .bar-label { width: 24px; color: var(--text-sub); font-weight: 600; }
        .bar-track { flex: 1; height: 8px; background: var(--border); border-radius: 4px; overflow: hidden; }
        .bar-fill { height: 100%; background: #fbbf24; border-radius: 4px; transition: width 0.6s ease; }
        .sentiment-row { display: flex; gap: 10px; margin-top: 18px; }
        .sent-box { flex: 1; text-align: center; padding: 12px 8px; border-radius: var(--radius-sm); }
        .sent-box .num { font-size: 20px; font-weight: 800; }
        .sent-box .lbl { font-size: 11px; margin-top: 4px; }
        .sent-pos { background: #ecfdf5; color: #059669; }
        .sent-neu { background: #f3f4f6; color: #6b7280; }
        .sent-neg { background: #fef2f2; color: #dc2626; }
        .wish-btn { width: 100%; padding: 12px; border: 2px solid var(--accent); border-radius: var(--radius-sm); background: transparent; color: var(--accent); font-size: 14px; font-weight: 700; cursor: pointer; transition: all 0.2s; margin-top: 14px; font-family: inherit; }
        .wish-btn.wished { background: var(--accent); color: #fff; }
        .wish-btn:hover { opacity: 0.85; }
        .review-item { padding: 18px 0; border-bottom: 1px solid var(--border); }
        .review-item:last-child { border-bottom: none; }
        .review-header { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; flex-wrap: wrap; }
        .review-nick { font-weight: 700; font-size: 14px; }
        .review-rating { color: #fbbf24; font-size: 13px; }
        .review-date { color: var(--text-muted); font-size: 12px; margin-left: auto; }
        .review-tags { display: flex; gap: 6px; flex-wrap: wrap; margin-bottom: 8px; }
        .tag { font-size: 11px; padding: 3px 9px; border-radius: 20px; background: var(--bg); color: var(--text-sub); border: 1px solid var(--border); }
        .review-text { font-size: 13px; line-height: 1.7; color: var(--text); }
        .helpful { font-size: 11px; color: var(--text-muted); margin-top: 8px; }
        .page-nav { display: flex; justify-content: center; gap: 6px; margin-top: 20px; flex-wrap: wrap; }
        .page-nav a { display: inline-flex; align-items: center; justify-content: center; width: 34px; height: 34px; border: 1.5px solid var(--border); border-radius: var(--radius-sm); text-decoration: none; color: var(--text-sub); font-size: 13px; background: var(--card); transition: all 0.15s; }
        .page-nav a.active, .page-nav a:hover { border-color: var(--accent); color: var(--accent); }
        .page-nav a.active { background: var(--accent); color: #fff; }
        @media (max-width: 768px) { .detail-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="container">

    <div class="page-title" style="margin-bottom:20px;">
        <a href="javascript:history.back()" style="color:var(--text-muted);font-size:13px;text-decoration:none;">← 뒤로</a>
    </div>

    <div class="detail-grid">
        <!-- 왼쪽: 상품 정보 + 평점 통계 -->
        <div>
            <div class="detail-card" style="margin-bottom:16px;">
                <div class="product-brand">${product.brandName}</div>
                <div class="product-title">${product.productName}</div>
                <div class="price-row">
                    <span class="price-main"><fmt:formatNumber value="${product.price}" pattern="#,###"/>원</span>
                    <c:if test="${product.originalPrice > product.price}">
                        <span class="price-orig"><fmt:formatNumber value="${product.originalPrice}" pattern="#,###"/>원</span>
                        <span class="discount-badge">${product.discountRate}%</span>
                    </c:if>
                </div>
                <c:if test="${not empty product.productUrl}">
                    <a href="${product.productUrl}" target="_blank" class="btn-primary" style="display:block;text-align:center;text-decoration:none;padding:11px;">무신사에서 보기 →</a>
                </c:if>
                <button class="wish-btn ${wished ? 'wished' : ''}" id="wishBtn" onclick="toggleWish(${product.productId})">
                    ${wished ? '❤️ 찜 취소' : '🤍 찜하기'}
                </button>
            </div>

            <div class="detail-card">
                <div style="font-size:13px;font-weight:700;margin-bottom:14px;">리뷰 통계</div>
                <div class="rating-big">
                    <div>
                        <div class="rating-num">${stats.AVGRATING}</div>
                        <div class="rating-sub">/ 5.0 · ${total}건</div>
                    </div>
                    <div class="rating-stars">
                        <c:set var="avg" value="${stats.AVGRATING}"/>
                        ★★★★★
                    </div>
                </div>

                <c:set var="total5" value="${stats.R5 + stats.R4 + stats.R3 + stats.R2 + stats.R1}"/>
                <c:set var="t5" value="${total5 > 0 ? total5 : 1}"/>
                <div class="bar-row">
                    <span class="bar-label">5점</span>
                    <div class="bar-track"><div class="bar-fill" style="width:${stats.R5 * 100 / t5}%"></div></div>
                    <span style="width:36px;font-size:11px;color:var(--text-muted);text-align:right;">${stats.R5}</span>
                </div>
                <div class="bar-row">
                    <span class="bar-label">4점</span>
                    <div class="bar-track"><div class="bar-fill" style="width:${stats.R4 * 100 / t5}%"></div></div>
                    <span style="width:36px;font-size:11px;color:var(--text-muted);text-align:right;">${stats.R4}</span>
                </div>
                <div class="bar-row">
                    <span class="bar-label">3점</span>
                    <div class="bar-track"><div class="bar-fill" style="width:${stats.R3 * 100 / t5}%"></div></div>
                    <span style="width:36px;font-size:11px;color:var(--text-muted);text-align:right;">${stats.R3}</span>
                </div>
                <div class="bar-row">
                    <span class="bar-label">2점</span>
                    <div class="bar-track"><div class="bar-fill" style="width:${stats.R2 * 100 / t5}%"></div></div>
                    <span style="width:36px;font-size:11px;color:var(--text-muted);text-align:right;">${stats.R2}</span>
                </div>
                <div class="bar-row">
                    <span class="bar-label">1점</span>
                    <div class="bar-track"><div class="bar-fill" style="width:${stats.R1 * 100 / t5}%"></div></div>
                    <span style="width:36px;font-size:11px;color:var(--text-muted);text-align:right;">${stats.R1}</span>
                </div>

                <div class="sentiment-row">
                    <div class="sent-box sent-pos">
                        <div class="num">${stats.POSCNT}</div>
                        <div class="lbl">긍정</div>
                    </div>
                    <div class="sent-box sent-neu">
                        <div class="num">${stats.NEUCNT}</div>
                        <div class="lbl">중립</div>
                    </div>
                    <div class="sent-box sent-neg">
                        <div class="num">${stats.NEGCNT}</div>
                        <div class="lbl">부정</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 오른쪽: 리뷰 목록 -->
        <div class="detail-card">
            <div class="table-header" style="margin-bottom:16px;">
                <h3>💬 리뷰</h3>
                <span class="count">총 ${total}건 · 도움순</span>
            </div>

            <c:forEach var="r" items="${reviewList}">
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-nick">${r.nickname}</span>
                        <span class="review-rating">
                            <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                        </span>
                        <span class="badge ${r.sentiment == '긍정' ? 'positive' : r.sentiment == '부정' ? 'negative' : 'neutral'}">${r.sentiment}</span>
                        <span class="review-date">${r.reviewDate}</span>
                    </div>
                    <c:if test="${not empty r.skinType or not empty r.skinTone}">
                        <div class="review-tags">
                            <c:if test="${not empty r.skinType}"><span class="tag">${r.skinType}</span></c:if>
                            <c:if test="${not empty r.skinTone}"><span class="tag">${r.skinTone}</span></c:if>
                        </div>
                    </c:if>
                    <div class="review-text">${r.reviewText}</div>
                    <div class="helpful">👍 도움 ${r.helpful}</div>
                </div>
            </c:forEach>

            <!-- 페이지네이션 -->
            <c:if test="${totalPages > 1}">
                <div class="page-nav">
                    <c:if test="${page > 1}">
                        <a href="${pageContext.request.contextPath}/product/detail?productId=${productId}&page=${page-1}">‹</a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <a href="${pageContext.request.contextPath}/product/detail?productId=${productId}&page=${p}" class="${p == page ? 'active' : ''}">${p}</a>
                    </c:forEach>
                    <c:if test="${page < totalPages}">
                        <a href="${pageContext.request.contextPath}/product/detail?productId=${productId}&page=${page+1}">›</a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
function toggleWish(productId) {
    fetch('${pageContext.request.contextPath}/product/wish', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'productId=' + productId
    })
    .then(r => r.json())
    .then(data => {
        const btn = document.getElementById('wishBtn');
        if (data.result === 'login') {
            alert('로그인 후 이용하세요.');
            location.href = '${pageContext.request.contextPath}/member/loginForm';
        } else if (data.result === 'added') {
            btn.textContent = '❤️ 찜 취소';
            btn.classList.add('wished');
        } else {
            btn.textContent = '🤍 찜하기';
            btn.classList.remove('wished');
        }
    });
}
</script>
</body>
</html>
