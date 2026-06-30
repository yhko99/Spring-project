package kr.ac.kopo.beauty.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import kr.ac.kopo.beauty.service.ProductService;
import kr.ac.kopo.beauty.service.StatsService;

@Controller
public class BrandController {

    @Autowired
    private StatsService statsService;

    @Autowired
    private ProductService productService;

    // 브랜드별 평균 평점 / 리뷰 수 랭킹
    @GetMapping("/brand")
    public String list(Model model) {
        model.addAttribute("ratingRanking", statsService.getBrandRatingRanking());
        model.addAttribute("reviewRanking", statsService.getBrandReviewRanking());
        return "brand/list";
    }

    // 브랜드 상세 (통계 + 상품 목록)
    @GetMapping("/brand/detail")
    public String detail(@RequestParam("brandName") String brandName, Model model) {
        model.addAttribute("brandName", brandName);
        model.addAttribute("brandStats", productService.getBrandStats(brandName));
        model.addAttribute("productList", productService.getListByBrandWithStats(brandName));
        return "brand/detail";
    }
}
