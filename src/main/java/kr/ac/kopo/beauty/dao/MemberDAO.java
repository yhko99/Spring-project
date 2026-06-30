package kr.ac.kopo.beauty.dao;

import java.util.List;

import kr.ac.kopo.beauty.vo.MemberVO;

public interface MemberDAO {

    // 회원가입
    int insert(MemberVO memberVO);

    // 로그인 (아이디 + 비밀번호)
    MemberVO selectOne(MemberVO memberVO);

    // 아이디 중복 체크
    int selectCount(String memberId);

    // 이메일로 회원 조회 (소셜 로그인용)
    MemberVO selectByEmail(String memberEmail);

    // 얼굴 데이터 저장
    int updateFaceDescriptor(MemberVO memberVO);

    // 얼굴로 회원 찾기
    MemberVO selectByFace(String memberId);

    // 전체 회원 얼굴 데이터 조회 (얼굴 로그인용)
    List<MemberVO> selectAllFace();
}
