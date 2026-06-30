package kr.ac.kopo.beauty.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.beauty.dao.MemberDAO;
import kr.ac.kopo.beauty.vo.MemberVO;

@Service
public class MemberService {

    @Autowired
    private MemberDAO memberDAO;

    public int idCheck(String memberId) {
        return memberDAO.selectCount(memberId);
    }

    public int join(MemberVO memberVO) {
        return memberDAO.insert(memberVO);
    }

    public MemberVO login(MemberVO memberVO) {
        return memberDAO.selectOne(memberVO);
    }

    // 소셜 로그인 시 이메일로 기존 회원 여부 확인 후 없으면 자동 가입
    public MemberVO socialLogin(String memberId, String memberName, String memberEmail) {
        MemberVO existing = memberDAO.selectByEmail(memberEmail);
        if (existing != null) {
            return existing;
        }
        MemberVO newMember = new MemberVO();
        newMember.setMemberId(memberId);
        newMember.setMemberPw(memberId); // 소셜 로그인 회원은 비밀번호를 사용하지 않음
        newMember.setMemberName(memberName);
        newMember.setMemberEmail(memberEmail);
        memberDAO.insert(newMember);
        return newMember;
    }

    // 얼굴 데이터 저장
    public int updateFaceDescriptor(MemberVO memberVO) {
        return memberDAO.updateFaceDescriptor(memberVO);
    }

    // 얼굴로 회원 찾기
    public MemberVO selectByFace(String memberId) {
        return memberDAO.selectByFace(memberId);
    }

    // 전체 회원 얼굴 데이터 조회 (얼굴 로그인용)
    public List<MemberVO> selectAllFace() {
        return memberDAO.selectAllFace();
    }
}
