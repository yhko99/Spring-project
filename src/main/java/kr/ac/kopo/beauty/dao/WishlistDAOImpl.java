package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.beauty.vo.ProductVO;

@Repository
public class WishlistDAOImpl implements WishlistDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public void insert(Map<String, Object> params) {
        sqlSessionTemplate.insert("beauty.dao.WishlistDAO.insert", params);
    }

    @Override
    public void delete(Map<String, Object> params) {
        sqlSessionTemplate.delete("beauty.dao.WishlistDAO.delete", params);
    }

    @Override
    public int selectCount(Map<String, Object> params) {
        return sqlSessionTemplate.selectOne("beauty.dao.WishlistDAO.selectCount", params);
    }

    @Override
    public List<ProductVO> selectMyList(String memberId) {
        return sqlSessionTemplate.selectList("beauty.dao.WishlistDAO.selectMyList", memberId);
    }
}
