package kr.ac.kopo.beauty.dao;

import java.util.List;
import java.util.Map;

import kr.ac.kopo.beauty.vo.ReviewVO;

public interface ReviewDAO {

    // 키워드/감성/피부타입 조건으로 리뷰 검색
    List<ReviewVO> selectSearchList(Map<String, Object> params);

    // 검색 결과 건수
    int selectSearchCount(Map<String, Object> params);
}
