<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
</head>
<body>
<div class="form-page">
    <div class="form-card">
        <h2>회원가입</h2>
        <p class="subtitle">계정을 만들고 분석 서비스를 이용하세요</p>

        <c:if test="${param.error == 'duplicate'}">
            <div style="background:#fef2f2;color:#dc2626;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;border:1px solid #fecaca;">
                이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.
            </div>
        </c:if>
        <c:if test="${param.error == 'db'}">
            <div style="background:#fef2f2;color:#dc2626;padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;border:1px solid #fecaca;">
                오류가 발생했습니다. 잠시 후 다시 시도해주세요.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/member/join" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="memberId" placeholder="아이디 입력" required>
            </div>
            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="memberPw" placeholder="비밀번호 입력" required>
            </div>
            <div class="form-group">
                <label>이름</label>
                <input type="text" name="memberName" placeholder="이름 입력" required>
            </div>
            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="memberEmail" placeholder="이메일 입력" required>
            </div>
            <button type="submit" class="btn-primary">가입하기</button>
        </form>
        <div class="form-footer">
            이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/member/loginForm">로그인</a>
        </div>
    </div>
</div>
</body>
</html>
