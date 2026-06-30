package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.beauty.vo.ProductVO;
import kr.ac.kopo.beauty.vo.ReviewVO;

@Repository
public class ProductDAOImpl implements ProductDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public ProductVO selectOne(int productId) {
        return sqlSessionTemplate.selectOne("beauty.dao.ProductDAO.selectOne", productId);
    }

    @Override
    public List<ProductVO> selectListByBrand(String brandName) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectListByBrand", brandName);
    }

    @Override
    public List<ProductVO> selectTopRated(int limit) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectTopRated", limit);
    }

    @Override
    public List<ProductVO> selectTopReviewed(int limit) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectTopReviewed", limit);
    }

    @Override
    public List<ProductVO> selectRecommendBySkinType(Map<String, Object> params) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectRecommendBySkinType", params);
    }

    @Override
    public Map<String, Object> selectDetailStats(int productId) {
        return sqlSessionTemplate.selectOne("beauty.dao.ProductDAO.selectDetailStats", productId);
    }

    @Override
    public List<ReviewVO> selectReviewsByProduct(Map<String, Object> params) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectReviewsByProduct", params);
    }

    @Override
    public int selectReviewCountByProduct(int productId) {
        return sqlSessionTemplate.selectOne("beauty.dao.ProductDAO.selectReviewCountByProduct", productId);
    }

    @Override
    public Map<String, Object> selectBrandStats(String brandName) {
        return sqlSessionTemplate.selectOne("beauty.dao.ProductDAO.selectBrandStats", brandName);
    }

    @Override
    public List<ProductVO> selectListByBrandWithStats(String brandName) {
        return sqlSessionTemplate.selectList("beauty.dao.ProductDAO.selectListByBrandWithStats", brandName);
    }
}
