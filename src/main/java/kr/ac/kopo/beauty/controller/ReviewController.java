package kr.ac.kopo.beauty.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.kopo.beauty.service.ReviewService;
import kr.ac.kopo.beauty.vo.ReviewVO;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    // 리뷰 검색 (키워드 + 감성 필터 + 피부타입 필터)
    @GetMapping("/review/search")
    public String search(@RequestParam(name = "keyword", defaultValue = "") String keyword,
                          @RequestParam(name = "sentiment", defaultValue = "") String sentiment,
                          @RequestParam(name = "skinType", defaultValue = "") String skinType,
                          @RequestParam(name = "page", defaultValue = "1") int page,
                          Model model) {

        int limit = 20;
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("sentiment", sentiment);
        params.put("skinType", skinType);
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);

        List<ReviewVO> reviewList = reviewService.search(params);
        int totalCount = reviewService.searchCount(params);

        model.addAttribute("reviewList", reviewList);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("page", page);
        model.addAttribute("totalPage", (int) Math.ceil((double) totalCount / limit));
        model.addAttribute("keyword", keyword);
        model.addAttribute("sentiment", sentiment);
        model.addAttribute("skinType", skinType);

        return "review/search";
    }
}
