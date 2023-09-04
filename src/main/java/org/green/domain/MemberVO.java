package org.green.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String userName;
	private boolean enabled;
	private Date regDate;
	private String email;
	private int mail_auth;
	private String mail_key;
	private List<AuthVO> authList; //사용권한 여러개
	private String auth;
}
