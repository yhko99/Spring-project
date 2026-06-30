<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>얼굴 등록</title>
    <script src="https://cdn.jsdelivr.net/npm/face-api.js@0.22.2/dist/face-api.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; text-align: center; }
        h2 { color: #333; }
        #videoContainer { position: relative; display: inline-block; }
        video { border: 2px solid #ddd; border-radius: 8px; }
        canvas { position: absolute; top: 0; left: 0; }
        .btn { padding: 10px 25px; margin: 10px; background: #333; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 15px; }
        .btn:hover { background: #555; }
        #status { margin: 15px 0; font-size: 16px; color: #444; }
        #result { font-size: 18px; font-weight: bold; margin: 10px; }
    </style>
</head>
<body>
    <h2>얼굴 등록</h2>
    <p>카메라를 바라보고 얼굴 등록 버튼을 클릭하세요</p>

    <div id="videoContainer">
        <video id="video" width="480" height="360" autoplay muted></video>
        <canvas id="canvas"></canvas>
    </div>

    <br>
    <div id="status">모델 로딩 중...</div>
    <div id="result"></div>
    <br>
    <button class="btn" id="registBtn" onclick="registFace()" disabled>얼굴 등록</button>
    <button class="btn" onclick="location.href='${pageContext.request.contextPath}/dashboard'">홈으로</button>

    <script>
        const video = document.getElementById('video');
        const canvas = document.getElementById('canvas');
        const status = document.getElementById('status');
        const result = document.getElementById('result');
        const registBtn = document.getElementById('registBtn');
        const MODEL_URL = '${pageContext.request.contextPath}/resources/models';

        async function loadModels() {
            await faceapi.nets.tinyFaceDetector.loadFromUri(MODEL_URL);
            await faceapi.nets.faceLandmark68Net.loadFromUri(MODEL_URL);
            await faceapi.nets.faceRecognitionNet.loadFromUri(MODEL_URL);
            status.innerText = '모델 로딩 완료! 카메라를 바라보세요.';
            registBtn.disabled = false;
            startVideo();
        }

        async function startVideo() {
            const stream = await navigator.mediaDevices.getUserMedia({ video: true });
            video.srcObject = stream;
        }

        async function registFace() {
            status.innerText = '얼굴 인식 중...';
            const detection = await faceapi.detectSingleFace(video,
                new faceapi.TinyFaceDetectorOptions())
                .withFaceLandmarks()
                .withFaceDescriptor();

            if (!detection) {
                status.innerText = '얼굴을 찾을 수 없습니다. 다시 시도하세요.';
                return;
            }

            const descriptor = Array.from(detection.descriptor);

            const response = await fetch('${pageContext.request.contextPath}/member/saveFace', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ faceDescriptor: JSON.stringify(descriptor) })
            });

            const resultText = await response.text();
            if (resultText === 'success') {
                result.style.color = 'green';
                result.innerText = '얼굴 등록 완료!';
                status.innerText = '이제 얼굴로 로그인할 수 있습니다.';
            } else {
                result.style.color = 'red';
                result.innerText = '등록 실패. 로그인 후 다시 시도하세요.';
            }
        }

        loadModels();
    </script>
</body>
</html>
