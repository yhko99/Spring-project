package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

public interface StatsDAO {

    // 전체 리뷰 수
    int selectTotalReviewCount();

    // 전체 상품 수
    int selectTotalProductCount();

    // 전체 브랜드 수
    int selectTotalBrandCount();

    // 평점 분포 (1~5점)
    List<Map<String, Object>> selectRatingDistribution();

    // 감성 분석 비율 (긍정/중립/부정)
    List<Map<String, Object>> selectSentimentDistribution();

    // 피부톤별 리뷰 분포
    List<Map<String, Object>> selectSkinToneDistribution();

    // 브랜드별 평균 평점 랭킹
    List<Map<String, Object>> selectBrandRatingRanking();

    // 브랜드별 리뷰 수 랭킹
    List<Map<String, Object>> selectBrandReviewRanking();
}
