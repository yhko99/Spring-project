package kr.ac.kopo.beauty.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.beauty.dao.ReviewDAO;
import kr.ac.kopo.beauty.vo.ReviewVO;

@Service
public class ReviewService {

    @Autowired
    private ReviewDAO reviewDAO;

    public List<ReviewVO> search(Map<String, Object> params) {
        return reviewDAO.selectSearchList(params);
    }

    public int searchCount(Map<String, Object> params) {
        return reviewDAO.selectSearchCount(params);
    }
}
