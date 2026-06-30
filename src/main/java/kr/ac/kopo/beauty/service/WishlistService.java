package kr.ac.kopo.beauty.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.beauty.dao.WishlistDAO;
import kr.ac.kopo.beauty.vo.ProductVO;

@Service
public class WishlistService {

    @Autowired
    private WishlistDAO wishlistDAO;

    public boolean isWished(String memberId, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("productId", productId);
        return wishlistDAO.selectCount(params) > 0;
    }

    public String toggle(String memberId, int productId) {
        Map<String, Object> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("productId", productId);
        if (wishlistDAO.selectCount(params) > 0) {
            wishlistDAO.delete(params);
            return "removed";
        } else {
            wishlistDAO.insert(params);
            return "added";
        }
    }

    public List<ProductVO> getMyList(String memberId) {
        return wishlistDAO.selectMyList(memberId);
    }
}
