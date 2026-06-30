package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.beauty.vo.ProductVO;

public interface WishlistDAO {
    void insert(Map<String, Object> params);
    void delete(Map<String, Object> params);
    int selectCount(Map<String, Object> params);
    List<ProductVO> selectMyList(String memberId);
}
