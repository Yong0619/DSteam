package org.green.mapper;

import org.green.domain.AuthVO;

public interface AuthMapper {
	//회원가입
	public void insert(AuthVO avo);
	//회원탈퇴
	public int delete(AuthVO avo);
	//권한수정
	public int adminUpdate(AuthVO avo);
	
	

}
