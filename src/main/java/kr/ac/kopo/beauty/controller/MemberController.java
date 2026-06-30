package kr.ac.kopo.beauty.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.beauty.service.MemberService;
import kr.ac.kopo.beauty.service.WishlistService;
import kr.ac.kopo.beauty.vo.MemberVO;

import org.springframework.ui.Model;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private WishlistService wishlistService;

    @Value("${kakao.rest-api-key}")
    private String kakaoRestApiKey;

    @Value("${kakao.redirect-uri}")
    private String kakaoRedirectUri;

    @Value("${kakao.client-secret}")
    private String kakaoClientSecret;

    @Value("${naver.client-id}")
    private String naverClientId;

    @Value("${naver.client-secret}")
    private String naverClientSecret;

    @Value("${naver.redirect-uri}")
    private String naverRedirectUri;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // 회원가입 폼
    @GetMapping("/member/joinForm")
    public String joinForm() {
        return "member/joinForm";
    }

    // 회원가입 처리
    @PostMapping("/member/join")
    public String join(MemberVO memberVO) {
        int cnt = memberService.idCheck(memberVO.getMemberId());
        if (cnt > 0) {
            return "redirect:/member/joinForm?error=duplicate";
        }
        try {
            memberService.join(memberVO);
        } catch (Exception e) {
            return "redirect:/member/joinForm?error=db";
        }
        return "redirect:/member/loginForm?joined=1";
    }

    // 로그인 폼
    @GetMapping("/member/loginForm")
    public String loginForm() {
        return "member/loginForm";
    }

    // 로그인 처리
    @PostMapping("/member/login")
    public String login(MemberVO memberVO, HttpSession session) {
        MemberVO loginMember = memberService.login(memberVO);
        if (loginMember == null) {
            return "redirect:/member/loginForm?error=login";
        }
        session.setAttribute("loginMember", loginMember);
        return "redirect:/dashboard";
    }

    // 로그아웃
    @GetMapping("/member/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/dashboard";
    }

    // 카카오 로그인 시작 -> 카카오 인증 화면으로 이동
    @GetMapping("/member/kakao/login")
    public String kakaoLogin() {
        String url = "https://kauth.kakao.com/oauth/authorize"
                + "?client_id=" + kakaoRestApiKey
                + "&redirect_uri=" + kakaoRedirectUri
                + "&response_type=code";
        return "redirect:" + url;
    }

    // 카카오 로그인 콜백
    @GetMapping("/member/kakao/callback")
    public String kakaoCallback(@RequestParam("code") String code, HttpSession session) {
        // 1) 인가 코드로 액세스 토큰 발급
        MultiValueMap<String, String> tokenParams = new LinkedMultiValueMap<>();
        tokenParams.add("grant_type", "authorization_code");
        tokenParams.add("client_id", kakaoRestApiKey);
        tokenParams.add("client_secret", kakaoClientSecret);
        tokenParams.add("redirect_uri", kakaoRedirectUri);
        tokenParams.add("code", code);

        HttpHeaders tokenHeaders = new HttpHeaders();
        tokenHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<MultiValueMap<String, String>> tokenRequest = new HttpEntity<>(tokenParams, tokenHeaders);

        String tokenResponse = restTemplate.postForObject(
                "https://kauth.kakao.com/oauth/token", tokenRequest, String.class);

        try {
            JsonNode tokenJson = objectMapper.readTree(tokenResponse);
            String accessToken = tokenJson.get("access_token").asText();

            // 2) 액세스 토큰으로 사용자 정보 조회
            HttpHeaders userHeaders = new HttpHeaders();
            userHeaders.setBearerAuth(accessToken);
            HttpEntity<Void> userRequest = new HttpEntity<>(userHeaders);

            String userResponse = restTemplate.exchange(
                    "https://kapi.kakao.com/v2/user/me", HttpMethod.GET, userRequest, String.class).getBody();

            JsonNode userJson = objectMapper.readTree(userResponse);
            String kakaoId = "kakao_" + userJson.get("id").asText();
            JsonNode account = userJson.get("kakao_account");
            String nickname = account.get("profile").get("nickname").asText();
            String email = account.has("email") ? account.get("email").asText() : kakaoId + "@kakao.local";

            MemberVO loginMember = memberService.socialLogin(kakaoId, nickname, email);
            session.setAttribute("loginMember", loginMember);
        } catch (Exception e) {
            return "redirect:/member/loginForm";
        }
        return "redirect:/dashboard";
    }

    // 네이버 로그인 시작
    @GetMapping("/member/naver/login")
    public String naverLogin(HttpSession session) {
        String state = String.valueOf(System.currentTimeMillis());
        session.setAttribute("naverState", state);
        String url = "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + naverClientId
                + "&redirect_uri=" + naverRedirectUri
                + "&state=" + state;
        return "redirect:" + url;
    }

    // 네이버 로그인 콜백
    @GetMapping("/member/naver/callback")
    public String naverCallback(@RequestParam("code") String code,
                                 @RequestParam("state") String state,
                                 HttpSession session) {
        try {
            String tokenUrl = "https://nid.naver.com/oauth2.0/token"
                    + "?grant_type=authorization_code"
                    + "&client_id=" + naverClientId
                    + "&client_secret=" + naverClientSecret
                    + "&code=" + code
                    + "&state=" + state;

            String tokenResponse = restTemplate.getForObject(tokenUrl, String.class);
            JsonNode tokenJson = objectMapper.readTree(tokenResponse);
            String accessToken = tokenJson.get("access_token").asText();

            HttpHeaders userHeaders = new HttpHeaders();
            userHeaders.setBearerAuth(accessToken);
            HttpEntity<Void> userRequest = new HttpEntity<>(userHeaders);

            String userResponse = restTemplate.exchange(
                    "https://openapi.naver.com/v1/nid/me", HttpMethod.GET, userRequest, String.class).getBody();

            JsonNode userJson = objectMapper.readTree(userResponse);
            JsonNode response = userJson.get("response");
            String naverId = "naver_" + response.get("id").asText();
            String name = response.has("name") ? response.get("name").asText() : naverId;
            String email = response.has("email") ? response.get("email").asText() : naverId + "@naver.local";

            MemberVO loginMember = memberService.socialLogin(naverId, name, email);
            session.setAttribute("loginMember", loginMember);
        } catch (Exception e) {
            return "redirect:/member/loginForm";
        }
        return "redirect:/dashboard";
    }

    // 얼굴 등록 폼
    @GetMapping("/member/faceRegist")
    public String faceRegist() {
        return "member/faceRegist";
    }

    // 얼굴 데이터 저장 (AJAX)
    @PostMapping("/member/saveFace")
    @ResponseBody
    public String saveFace(@RequestBody MemberVO memberVO, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "fail";
        }
        memberVO.setMemberId(loginMember.getMemberId());
        memberService.updateFaceDescriptor(memberVO);
        return "success";
    }

    // 전체 얼굴 데이터 조회 (얼굴 로그인용)
    @GetMapping("/member/getFaceData")
    @ResponseBody
    public List<MemberVO> getFaceData() {
        return memberService.selectAllFace();
    }

    // 얼굴 로그인 처리
    @PostMapping("/member/faceLogin")
    @ResponseBody
    public String faceLogin(@RequestBody MemberVO memberVO, HttpSession session) {
        MemberVO loginMember = memberService.selectByFace(memberVO.getMemberId());
        if (loginMember == null) {
            return "fail";
        }
        session.setAttribute("loginMember", loginMember);
        return "success";
    }

    // 얼굴 로그인 폼
    @GetMapping("/member/faceLoginForm")
    public String faceLoginForm() {
        return "member/faceLoginForm";
    }

    // 마이페이지
    @GetMapping("/member/mypage")
    public String mypage(HttpSession session, Model model) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/loginForm";
        }
        model.addAttribute("wishList", wishlistService.getMyList(loginMember.getMemberId()));
        return "member/mypage";
    }
}
