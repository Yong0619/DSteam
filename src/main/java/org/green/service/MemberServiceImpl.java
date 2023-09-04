package org.green.service;

import java.util.List;

import org.green.domain.AuthVO;
import org.green.domain.MemberCriteria;
import org.green.domain.MemberVO;
import org.green.mapper.AuthMapper;
import org.green.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	@Setter(onMethod_= {@Autowired} )
	private MemberMapper memberMapper;
	
	@Setter(onMethod_= {@Autowired} )
	private AuthMapper authMapper;
	
	//회원가입
	@Override
	public void register(MemberVO mvo, AuthVO avo) {
		memberMapper.insert(mvo);
		authMapper.insert(avo);	
	}
	
	//아이디 중복 체크
	@Override
	public String idCheck(String userid) {
		return memberMapper.idCheck(userid);
	}

	//아이디찾기
	@Override
	public MemberVO findId(MemberVO mvo) {
		return memberMapper.findId(mvo);
	}
	
	//임시 비밀번호 발급위해 정보체크 
	@Override
	public String findPw(String userid, String email) {
		return memberMapper.findPw(userid, email);
	}
	//임시비밀번호로 비밀번호변경처리
	@Override
	public void changPw(String userid, String enc_pw) {
		memberMapper.changPw(userid, enc_pw);
		
	}
	//회원정보 보기
	@Override
	public MemberVO view(String userid) {
		MemberVO mvo = memberMapper.view(userid);
		return mvo;
	}

	//회원정보 수정
	@Override
	public boolean modify(MemberVO mvo) {
		return memberMapper.update(mvo) == 1;
	}
	//회원탈퇴
	@Override
	public boolean remove( AuthVO avo, MemberVO mvo) {
		boolean result = (authMapper.delete(avo) == 1);
		boolean result1 = (memberMapper.delete(mvo) == 1);
		if(result && result1) {
			return true;
		}
		return false;
	}
	//페이징 회원 리스트
	@Override
	public List<MemberVO> getList(MemberCriteria cri) {
		log.info(cri);
		return memberMapper.getListWithPaging(cri);
	}
	//회원 총 수
	@Override
	public int getTotal(MemberCriteria cri) {
		return memberMapper.getTotalCount(cri);
	}
	//관리자의 회원 정보 수정
	@Override
	public boolean adminModify(MemberVO mvo, AuthVO avo) {
		boolean result = (memberMapper.adminUpdate(mvo) == 1);
		boolean result1 = (authMapper.adminUpdate(avo) == 1);
		if(result && result1) {
			return true;
		}
		return false;
	}
	//이메일 중복
	@Override
	public String emailCheck(String email) {
		return memberMapper.emailCheck(email);
	}
	
	
	
	

	
	
	

}
