<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
</head>
<body>
<div class="form-page">
    <div class="form-card">
        <h2>로그인</h2>
        <p class="subtitle">무신사 뷰티 분석 대시보드에 오신 걸 환영합니다</p>

        <c:if test="${param.error == 'login'}">
            <div style="background:#fef2f2;color:#dc2626;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;border:1px solid #fecaca;">
                아이디 또는 비밀번호가 올바르지 않습니다.
            </div>
        </c:if>
        <c:if test="${param.joined == '1'}">
            <div style="background:#ecfdf5;color:#059669;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;border:1px solid #a7f3d0;">
                회원가입이 완료되었습니다. 로그인해주세요!
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/member/login" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="memberId" placeholder="아이디 입력" required>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="memberPw" placeholder="비밀번호 입력" required>
            </div>
            <button type="submit" class="btn-primary">로그인</button>
        </form>

        <div class="social-divider">또는 소셜 로그인</div>
        <div class="social-btns">
            <a href="${pageContext.request.contextPath}/member/kakao/login" class="btn-kakao">카카오로 로그인</a>
            <a href="${pageContext.request.contextPath}/member/naver/login" class="btn-naver">네이버로 로그인</a>
            <a href="${pageContext.request.contextPath}/member/faceLoginForm" class="btn-face">👤 얼굴로 로그인</a>
        </div>

        <div class="form-footer">
            계정이 없으신가요? <a href="${pageContext.request.contextPath}/member/joinForm">회원가입</a>
        </div>
    </div>
</div>
</body>
</html>
