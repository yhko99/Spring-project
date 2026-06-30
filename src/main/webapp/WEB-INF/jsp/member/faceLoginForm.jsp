<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>얼굴 로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <script src="https://cdn.jsdelivr.net/npm/face-api.js@0.22.2/dist/face-api.min.js"></script>
    <style>
        .face-wrap { max-width: 560px; margin: 0 auto; padding: 40px 16px; }
        .face-card { background: var(--card); border-radius: 20px; padding: 36px; box-shadow: 0 8px 40px rgba(26,26,46,0.12); border: 1px solid var(--border); text-align: center; }
        .face-card h2 { font-size: 22px; font-weight: 700; margin-bottom: 6px; }
        .face-card p { color: var(--text-muted); font-size: 13px; margin-bottom: 24px; }
        #videoContainer { position: relative; display: inline-block; border-radius: 12px; overflow: hidden; }
        video { display: block; border-radius: 12px; width: 460px; max-width: 100%; }
        canvas { position: absolute; top: 0; left: 0; }
        #status { margin: 16px 0 6px; font-size: 14px; color: var(--text-sub); min-height: 22px; }
        #result { font-size: 15px; font-weight: 700; min-height: 24px; margin-bottom: 12px; }
        .result-ok { color: #059669; }
        .result-err { color: #dc2626; }
        .loader { display: inline-block; width: 14px; height: 14px; border: 2px solid var(--border); border-top-color: var(--accent); border-radius: 50%; animation: spin 0.7s linear infinite; vertical-align: middle; margin-right: 6px; }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/common/header.jspf" %>
<div class="face-wrap">
    <div class="face-card">
        <h2>👤 얼굴 로그인</h2>
        <p>카메라를 바라보고 버튼을 클릭하세요</p>

        <div id="videoContainer">
            <video id="video" autoplay muted playsinline></video>
            <canvas id="canvas"></canvas>
        </div>

        <div id="status"><span class="loader"></span> 모델 로딩 중...</div>
        <div id="result"></div>

        <button class="btn-primary" id="loginBtn" onclick="faceLogin()" disabled style="margin-bottom:14px;">얼굴로 로그인</button>

        <div class="form-footer">
            <a href="${pageContext.request.contextPath}/member/loginForm">일반 로그인으로 이동</a>
        </div>
    </div>
</div>

<script>
    const video = document.getElementById('video');
    const statusEl = document.getElementById('status');
    const resultEl = document.getElementById('result');
    const loginBtn = document.getElementById('loginBtn');
    const MODEL_URL = '${pageContext.request.contextPath}/resources/models';

    let labeledDescriptors = [];

    function setStatus(msg, loading = false) {
        statusEl.innerHTML = loading ? '<span class="loader"></span> ' + msg : msg;
    }

    async function loadModels() {
        try {
            setStatus('모델 로딩 중...', true);
            await faceapi.nets.tinyFaceDetector.loadFromUri(MODEL_URL);
            await faceapi.nets.faceLandmark68Net.loadFromUri(MODEL_URL);
            await faceapi.nets.faceRecognitionNet.loadFromUri(MODEL_URL);
            setStatus('얼굴 데이터 불러오는 중...', true);
            await loadFaceData();
            await startVideo();
        } catch (e) {
            console.error('모델 로딩 오류:', e);
            setStatus('⚠️ 모델 로딩 실패: ' + e.message);
        }
    }

    async function loadFaceData() {
        try {
            const res = await fetch('${pageContext.request.contextPath}/member/getFaceData');
            const members = await res.json();

            const valid = members.filter(m => m.faceDescriptor);
            if (valid.length === 0) {
                setStatus('등록된 얼굴 데이터가 없습니다. 먼저 얼굴을 등록해주세요.');
                return;
            }

            labeledDescriptors = valid
                .filter(m => {
                    try {
                        const arr = JSON.parse(m.faceDescriptor);
                        return Array.isArray(arr) && arr.length === 128;
                    } catch(e) { return false; }
                })
                .map(m => {
                    const descriptor = new Float32Array(JSON.parse(m.faceDescriptor));
                    return new faceapi.LabeledFaceDescriptors(m.memberId, [descriptor]);
                });

            setStatus('✅ 준비 완료! 버튼을 눌러 로그인하세요.');
            loginBtn.disabled = false;
        } catch (e) {
            console.error('얼굴 데이터 로드 오류:', e);
            setStatus('⚠️ 얼굴 데이터 로드 실패: ' + e.message);
        }
    }

    async function startVideo() {
        try {
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            video.srcObject = stream;
        } catch (e) {
            setStatus('⚠️ 카메라 접근 실패: ' + e.message);
        }
    }

    async function faceLogin() {
        if (labeledDescriptors.length === 0) {
            setStatus('등록된 얼굴 데이터가 없습니다.');
            return;
        }

        loginBtn.disabled = true;
        setStatus('얼굴 인식 중...', true);
        resultEl.textContent = '';

        try {
            // 5초 타임아웃
            const detectionPromise = faceapi
                .detectSingleFace(video, new faceapi.TinyFaceDetectorOptions({ inputSize: 224, scoreThreshold: 0.3 }))
                .withFaceLandmarks()
                .withFaceDescriptor();

            const timeoutPromise = new Promise((_, reject) =>
                setTimeout(() => reject(new Error('인식 시간 초과 (5초)')), 5000)
            );

            const detection = await Promise.race([detectionPromise, timeoutPromise]);

            if (!detection) {
                setStatus('얼굴을 찾을 수 없습니다. 카메라 정면을 바라보세요.');
                resultEl.className = 'result-err';
                resultEl.textContent = '다시 시도해주세요';
                loginBtn.disabled = false;
                return;
            }

            setStatus('얼굴 매칭 중...');
            const matcher = new faceapi.FaceMatcher(labeledDescriptors, 0.5);
            const match = matcher.findBestMatch(detection.descriptor);

            console.log('매칭 결과:', match.label, match.distance);

            if (match.label === 'unknown') {
                setStatus('일치하는 얼굴을 찾을 수 없습니다.');
                resultEl.className = 'result-err';
                resultEl.textContent = '등록된 얼굴과 일치하지 않습니다 (거리: ' + match.distance.toFixed(3) + ')';
                loginBtn.disabled = false;
                return;
            }

            setStatus('서버에 로그인 요청 중...');
            const res = await fetch('${pageContext.request.contextPath}/member/faceLogin', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ memberId: match.label })
            });

            const text = await res.text();
            if (text === 'success') {
                resultEl.className = 'result-ok';
                resultEl.textContent = '✅ 로그인 성공! ' + match.label + '님 환영합니다';
                setStatus('대시보드로 이동합니다...');
                setTimeout(() => { location.href = '${pageContext.request.contextPath}/dashboard'; }, 1000);
            } else {
                setStatus('로그인 실패. 다시 시도해주세요.');
                resultEl.className = 'result-err';
                resultEl.textContent = '서버 오류';
                loginBtn.disabled = false;
            }
        } catch (e) {
            console.error('얼굴 로그인 오류:', e);
            setStatus('⚠️ 오류: ' + e.message);
            resultEl.className = 'result-err';
            resultEl.textContent = '다시 시도해주세요';
            loginBtn.disabled = false;
        }
    }

    loadModels();
</script>
</body>
</html>
