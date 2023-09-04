package org.green.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.domain.AuthVO;
import org.green.domain.MemberCriteria;
import org.green.domain.MemberVO;

public interface MemberService {
	//등록 insert
	public void register(MemberVO mvo, AuthVO avo);
	//아이디찾기 findId
	public MemberVO findId(MemberVO mvo);
	//아이디중복 idCheck
	public String idCheck(String userid);
	//아이디중복 emailCheck
	public String emailCheck(String email);
	//임시 비밀번호 발급을 위한 정보 확인
	public String findPw(@Param("userid") String userid, @Param("email") String email);
	//임시 비밀번호로 변경
	public void changPw(@Param("userid") String userid, @Param("enc_pw") String enc_pw);
	//회원정보
	public MemberVO view(String userid);
	//회원정보수정
	public boolean modify(MemberVO mvo);
	//관리자 회원정보수정
	public boolean adminModify(MemberVO mvo, AuthVO avo);
	//회원탈퇴
	public boolean remove(AuthVO avo ,MemberVO mvo);
	//목록
	public List<MemberVO> getList(MemberCriteria cri);
	//게시글 총 개수
	public int getTotal(MemberCriteria cri);
}
