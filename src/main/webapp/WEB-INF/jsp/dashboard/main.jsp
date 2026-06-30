<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>뷰티 리뷰 분석 대시보드</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4"></script>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>

<div class="container">
    <div class="card-row">
        <div class="stat-card">
            <div class="icon red">💬</div>
            <div class="info">
                <div class="num">${totalReviewCount}</div>
                <div class="label">전체 리뷰 수</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="icon blue">🛍️</div>
            <div class="info">
                <div class="num">${totalProductCount}</div>
                <div class="label">전체 상품 수</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="icon green">🏷️</div>
            <div class="info">
                <div class="num">${totalBrandCount}</div>
                <div class="label">전체 브랜드 수</div>
            </div>
        </div>
    </div>

    <div class="chart-row">
        <div class="chart-box">
            <h3>평점 분포 (1~5점)</h3>
            <canvas id="ratingChart"></canvas>
        </div>
        <div class="chart-box">
            <h3>감성 분석 비율</h3>
            <canvas id="sentimentChart"></canvas>
        </div>
        <div class="chart-box">
            <h3>피부톤별 리뷰 분포</h3>
            <canvas id="skinToneChart"></canvas>
        </div>
    </div>
</div>

<script>
Chart.defaults.font.family = "'Noto Sans KR', sans-serif";
Chart.defaults.color = '#6b7280';

const ratingLabels = [<c:forEach var="row" items="${ratingDistribution}">'${row.rating}점',</c:forEach>];
const ratingData = [<c:forEach var="row" items="${ratingDistribution}">${row.cnt},</c:forEach>];
new Chart(document.getElementById('ratingChart'), {
    type: 'bar',
    data: {
        labels: ratingLabels,
        datasets: [{
            label: '리뷰 수',
            data: ratingData,
            backgroundColor: ['#fecdd3','#fda4af','#fb7185','#f43f5e','#e8507a'],
            borderRadius: 6,
            borderSkipped: false
        }]
    },
    options: {
        responsive: true,
        plugins: { legend: { display: false } },
        scales: { y: { grid: { color: '#f0f2f5' } }, x: { grid: { display: false } } }
    }
});

const sentimentLabels = [<c:forEach var="row" items="${sentimentDistribution}">'${row.sentiment}',</c:forEach>];
const sentimentData = [<c:forEach var="row" items="${sentimentDistribution}">${row.cnt},</c:forEach>];
new Chart(document.getElementById('sentimentChart'), {
    type: 'doughnut',
    data: {
        labels: sentimentLabels,
        datasets: [{ data: sentimentData, backgroundColor: ['#059669','#9ca3af','#dc2626'], borderWidth: 0, hoverOffset: 6 }]
    },
    options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { padding: 16, font: { size: 12 } } } }, cutout: '62%' }
});

const skinToneLabels = [<c:forEach var="row" items="${skinToneDistribution}">'${row.skinTone}',</c:forEach>];
const skinToneData = [<c:forEach var="row" items="${skinToneDistribution}">${row.cnt},</c:forEach>];
new Chart(document.getElementById('skinToneChart'), {
    type: 'pie',
    data: {
        labels: skinToneLabels,
        datasets: [{ data: skinToneData, backgroundColor: ['#e8507a','#f97316','#eab308','#22c55e','#3b82f6','#8b5cf6','#ec4899','#14b8a6'], borderWidth: 0, hoverOffset: 6 }]
    },
    options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { padding: 12, font: { size: 11 } } } } }
});
</script>
</body>
</html>
