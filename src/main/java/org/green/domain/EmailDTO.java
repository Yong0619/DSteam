package org.green.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmailDTO {
	//보내는사람 이름
	private String senderName;
	//보내는사람 메일주소
	private String senderMail;
	//받는사람 메일주소(회원 이메일 주소)
	private String receiverMail;
	//메일 제목
	private String subject;
	//메일 내용
	private String message;
	
	public EmailDTO() {
		this.senderName = "DSteam";
		this.senderMail = "eternal0619@gmail.com";
		this.subject = "DSteam 회원가입 메일 인증코드 입니다.";
		this.message = "메일 인증을 위한 인증코드를 확인하시고, 회원 가입시 인증코드 입력란에 입력하세요.";
	}
}
