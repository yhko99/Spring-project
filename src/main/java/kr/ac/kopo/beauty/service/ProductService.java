package kr.ac.kopo.beauty.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.beauty.dao.ProductDAO;
import kr.ac.kopo.beauty.vo.ProductVO;
import kr.ac.kopo.beauty.vo.ReviewVO;

@Service
public class ProductService {

    @Autowired
    private ProductDAO productDAO;

    public ProductVO selectOne(int productId) {
        return productDAO.selectOne(productId);
    }

    public List<ProductVO> selectListByBrand(String brandName) {
        return productDAO.selectListByBrand(brandName);
    }

    public List<ProductVO> getTopRated(int limit) {
        return productDAO.selectTopRated(limit);
    }

    public List<ProductVO> getTopReviewed(int limit) {
        return productDAO.selectTopReviewed(limit);
    }

    public List<ProductVO> getRecommendBySkinType(String skinType, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("skinType", skinType);
        params.put("limit", limit);
        return productDAO.selectRecommendBySkinType(params);
    }

    public Map<String, Object> getDetailStats(int productId) {
        return productDAO.selectDetailStats(productId);
    }

    public List<ReviewVO> getReviewsByProduct(int productId, int page, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("productId", productId);
        params.put("offset", (page - 1) * limit);
        params.put("limit", limit);
        return productDAO.selectReviewsByProduct(params);
    }

    public int getReviewCountByProduct(int productId) {
        return productDAO.selectReviewCountByProduct(productId);
    }

    public Map<String, Object> getBrandStats(String brandName) {
        return productDAO.selectBrandStats(brandName);
    }

    public List<ProductVO> getListByBrandWithStats(String brandName) {
        return productDAO.selectListByBrandWithStats(brandName);
    }
}
