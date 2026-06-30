package kr.ac.kopo.beauty.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.beauty.dao.StatsDAO;

@Service
public class StatsService {

    @Autowired
    private StatsDAO statsDAO;

    public int getTotalReviewCount() {
        return statsDAO.selectTotalReviewCount();
    }

    public int getTotalProductCount() {
        return statsDAO.selectTotalProductCount();
    }

    public int getTotalBrandCount() {
        return statsDAO.selectTotalBrandCount();
    }

    public List<Map<String, Object>> getRatingDistribution() {
        return statsDAO.selectRatingDistribution();
    }

    public List<Map<String, Object>> getSentimentDistribution() {
        return statsDAO.selectSentimentDistribution();
    }

    public List<Map<String, Object>> getSkinToneDistribution() {
        return statsDAO.selectSkinToneDistribution();
    }

    public List<Map<String, Object>> getBrandRatingRanking() {
        return statsDAO.selectBrandRatingRanking();
    }

    public List<Map<String, Object>> getBrandReviewRanking() {
        return statsDAO.selectBrandReviewRanking();
    }
}
