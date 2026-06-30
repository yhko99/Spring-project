package kr.ac.kopo.beauty.vo;

import java.util.Date;

public class MemberVO {

    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberEmail;
    private String faceDescriptor;
    private Date regDate;

    public MemberVO() {}

    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }

    public String getMemberPw() { return memberPw; }
    public void setMemberPw(String memberPw) { this.memberPw = memberPw; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public String getMemberEmail() { return memberEmail; }
    public void setMemberEmail(String memberEmail) { this.memberEmail = memberEmail; }

    public String getFaceDescriptor() { return faceDescriptor; }
    public void setFaceDescriptor(String faceDescriptor) { this.faceDescriptor = faceDescriptor; }

    public Date getRegDate() { return regDate; }
    public void setRegDate(Date regDate) { this.regDate = regDate; }

    @Override
    public String toString() {
        return "MemberVO [memberId=" + memberId + ", memberName=" + memberName + "]";
    }
}
