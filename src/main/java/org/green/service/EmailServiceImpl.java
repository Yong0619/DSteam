package org.green.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.green.domain.EmailDTO;
import org.green.domain.MailVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {
	//주입 : mailSender bean 주입.
	@Setter(onMethod_= {@Autowired})
	private JavaMailSender mailSender;

	@Override
	public void sendMail(EmailDTO dto, String message) {
		//메일구성정보를 담당하는 객체(받는사람, 보내는 사람, 전자우편주소, 본문내용)
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			//받는사람 메일주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiverMail()));
			//보내는 사람(메일, 이름)
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			//메일제목
			msg.setSubject(dto.getSubject(), "utf-8");
			//본문내용
			msg.setText(message, "utf-8");
			
			mailSender.send(msg);  // GMail SMTP서버를 이용하여, 메일 발송이 된다.
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
	public void sendSimpleEmail(MailVO mailVO) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject(mailVO.getTitle());
		message.setTo(mailVO.getRecipientList().toArray(new String[mailVO.getRecipientList().size()]));
		message.setText(mailVO.getContent());
		
		mailSender.send(message);
	}
	
}
