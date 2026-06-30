package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.beauty.vo.ProductVO;
import kr.ac.kopo.beauty.vo.ReviewVO;

public interface ProductDAO {

    // 상품 상세 조회
    ProductVO selectOne(int productId);

    // 브랜드별 상품 목록
    List<ProductVO> selectListByBrand(String brandName);

    // 평점 높은 상품 Top N
    List<ProductVO> selectTopRated(int limit);

    // 리뷰 많은 상품 Top N
    List<ProductVO> selectTopReviewed(int limit);

    // 피부타입별 추천 상품
    List<ProductVO> selectRecommendBySkinType(Map<String, Object> params);

    // 상품 상세 통계 (평점분포, 감성분포)
    Map<String, Object> selectDetailStats(int productId);

    // 상품별 리뷰 목록 (페이징)
    List<ReviewVO> selectReviewsByProduct(Map<String, Object> params);

    // 상품별 리뷰 총 건수
    int selectReviewCountByProduct(int productId);

    // 브랜드 통계
    Map<String, Object> selectBrandStats(String brandName);

    // 브랜드별 상품 + 통계
    List<ProductVO> selectListByBrandWithStats(String brandName);
}
