package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.green.domain.Criteria;
import org.green.domain.MemberCriteria;
import org.green.domain.MemberVO;

public interface MemberMapper {
	//로그인
	public MemberVO read(String userid);
	//회원가입
	public void insert(MemberVO mvo);
	//아이디 찾기
	public MemberVO findId(MemberVO mvo);
	//아이디 중복
	public String idCheck(String userid);
	//이메일 중복
	public String emailCheck(String email);
	//임시 비밀번호 발급을 위하여 정보 확인
	public String findPw(@Param("userid") String userid, @Param("email") String email);
	//임시 비밀번호 발급
	public void changPw(@Param("userid") String userid, @Param("enc_pw") String enc_pw);
	//회원정보
	public MemberVO view(String userid);
	//회원정보수정
	public int update(MemberVO mvo);
	//관리자권한 회원정보수정
	public int adminUpdate(MemberVO mvo);
	//회원탈퇴
	public int delete(MemberVO mvo);
	//회원리스트
	public List<MemberVO> getListWithPaging(MemberCriteria cri);
	//전체 데이터 개수
	public int getTotalCount(MemberCriteria cri);
	//검색
	public List<MemberVO> searchMember(Map<String, Map<String, String>> map);
	
}
