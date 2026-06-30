package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StatsDAOImpl implements StatsDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int selectTotalReviewCount() {
        return sqlSessionTemplate.selectOne("beauty.dao.StatsDAO.selectTotalReviewCount");
    }

    @Override
    public int selectTotalProductCount() {
        return sqlSessionTemplate.selectOne("beauty.dao.StatsDAO.selectTotalProductCount");
    }

    @Override
    public int selectTotalBrandCount() {
        return sqlSessionTemplate.selectOne("beauty.dao.StatsDAO.selectTotalBrandCount");
    }

    @Override
    public List<Map<String, Object>> selectRatingDistribution() {
        return sqlSessionTemplate.selectList("beauty.dao.StatsDAO.selectRatingDistribution");
    }

    @Override
    public List<Map<String, Object>> selectSentimentDistribution() {
        return sqlSessionTemplate.selectList("beauty.dao.StatsDAO.selectSentimentDistribution");
    }

    @Override
    public List<Map<String, Object>> selectSkinToneDistribution() {
        return sqlSessionTemplate.selectList("beauty.dao.StatsDAO.selectSkinToneDistribution");
    }

    @Override
    public List<Map<String, Object>> selectBrandRatingRanking() {
        return sqlSessionTemplate.selectList("beauty.dao.StatsDAO.selectBrandRatingRanking");
    }

    @Override
    public List<Map<String, Object>> selectBrandReviewRanking() {
        return sqlSessionTemplate.selectList("beauty.dao.StatsDAO.selectBrandReviewRanking");
    }
}
