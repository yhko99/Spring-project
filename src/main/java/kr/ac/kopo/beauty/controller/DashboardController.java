package kr.ac.kopo.beauty.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.ac.kopo.beauty.service.StatsService;

@Controller
public class DashboardController {

    @Autowired
    private StatsService statsService;

    // 메인 대시보드
    @GetMapping({"/", "/dashboard"})
    public String main(Model model) {
        model.addAttribute("totalReviewCount", statsService.getTotalReviewCount());
        model.addAttribute("totalProductCount", statsService.getTotalProductCount());
        model.addAttribute("totalBrandCount", statsService.getTotalBrandCount());
        model.addAttribute("ratingDistribution", statsService.getRatingDistribution());
        model.addAttribute("sentimentDistribution", statsService.getSentimentDistribution());
        model.addAttribute("skinToneDistribution", statsService.getSkinToneDistribution());
        return "dashboard/main";
    }
}
