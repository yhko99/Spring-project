package kr.ac.kopo.beauty.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.ac.kopo.beauty.service.ProductService;
import kr.ac.kopo.beauty.service.WishlistService;
import kr.ac.kopo.beauty.vo.MemberVO;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private WishlistService wishlistService;

    // 평점 높은 상품 Top 10
    @GetMapping("/product/topRated")
    public String topRated(Model model) {
        model.addAttribute("productList", productService.getTopRated(10));
        return "product/topRated";
    }

    // 리뷰 많은 상품 Top 10
    @GetMapping("/product/topReviewed")
    public String topReviewed(Model model) {
        model.addAttribute("productList", productService.getTopReviewed(10));
        return "product/topReviewed";
    }

    // 피부타입별 추천 상품
    @GetMapping("/product/bySkinType")
    public String bySkinType(@RequestParam(name = "skinType", defaultValue = "") String skinType, Model model) {
        if (skinType != null && !skinType.isEmpty()) {
            model.addAttribute("productList", productService.getRecommendBySkinType(skinType, 10));
        }
        model.addAttribute("skinType", skinType);
        return "product/bySkinType";
    }

    // 상품 상세
    @GetMapping("/product/detail")
    public String detail(@RequestParam("productId") int productId, Model model, HttpSession session) {
        int page = 1;
        int limit = 10;
        int total = productService.getReviewCountByProduct(productId);
        int totalPages = (int) Math.ceil((double) total / limit);

        model.addAttribute("product", productService.selectOne(productId));
        model.addAttribute("stats", productService.getDetailStats(productId));
        model.addAttribute("reviewList", productService.getReviewsByProduct(productId, page, limit));
        model.addAttribute("total", total);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("page", page);
        model.addAttribute("productId", productId);

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember != null) {
            model.addAttribute("wished", wishlistService.isWished(loginMember.getMemberId(), productId));
        }
        return "product/detail";
    }

    // 상품 상세 — 리뷰 페이징 (AJAX)
    @GetMapping("/product/detail/reviews")
    public String detailReviews(@RequestParam int productId, @RequestParam(defaultValue = "1") int page, Model model) {
        int limit = 10;
        model.addAttribute("reviewList", productService.getReviewsByProduct(productId, page, limit));
        model.addAttribute("total", productService.getReviewCountByProduct(productId));
        model.addAttribute("totalPages", (int) Math.ceil((double) productService.getReviewCountByProduct(productId) / limit));
        model.addAttribute("page", page);
        model.addAttribute("productId", productId);
        return "product/detail :: reviewSection";
    }

    // 찜 토글 (AJAX)
    @PostMapping("/product/wish")
    @ResponseBody
    public Map<String, String> toggleWish(@RequestParam int productId, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return Map.of("result", "login");
        }
        String result = wishlistService.toggle(loginMember.getMemberId(), productId);
        return Map.of("result", result);
    }
}
