package kr.ac.kopo.beauty.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.beauty.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int insert(MemberVO memberVO) {
        return sqlSessionTemplate.insert("beauty.dao.MemberDAO.insert", memberVO);
    }

    @Override
    public MemberVO selectOne(MemberVO memberVO) {
        return sqlSessionTemplate.selectOne("beauty.dao.MemberDAO.selectOne", memberVO);
    }

    @Override
    public int selectCount(String memberId) {
        return sqlSessionTemplate.selectOne("beauty.dao.MemberDAO.selectCount", memberId);
    }

    @Override
    public MemberVO selectByEmail(String memberEmail) {
        return sqlSessionTemplate.selectOne("beauty.dao.MemberDAO.selectByEmail", memberEmail);
    }

    @Override
    public int updateFaceDescriptor(MemberVO memberVO) {
        return sqlSessionTemplate.update("beauty.dao.MemberDAO.updateFaceDescriptor", memberVO);
    }

    @Override
    public MemberVO selectByFace(String memberId) {
        return sqlSessionTemplate.selectOne("beauty.dao.MemberDAO.selectByFace", memberId);
    }

    @Override
    public List<MemberVO> selectAllFace() {
        return sqlSessionTemplate.selectList("beauty.dao.MemberDAO.selectAllFace");
    }
}
