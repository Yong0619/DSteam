package org.green.service;

import org.green.domain.EmailDTO;

public interface EmailService {
	//메일발송
	public void sendMail(EmailDTO dto, String message);

}
