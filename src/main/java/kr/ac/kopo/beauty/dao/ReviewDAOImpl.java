package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.beauty.vo.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public List<ReviewVO> selectSearchList(Map<String, Object> params) {
        return sqlSessionTemplate.selectList("beauty.dao.ReviewDAO.selectSearchList", params);
    }

    @Override
    public int selectSearchCount(Map<String, Object> params) {
        return sqlSessionTemplate.selectOne("beauty.dao.ReviewDAO.selectSearchCount", params);
    }
}
