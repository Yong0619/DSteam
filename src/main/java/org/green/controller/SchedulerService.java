package org.green.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.green.email.Email;
import org.green.email.EmailSender;
import org.green.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class SchedulerService {
	@Setter(onMethod_= {@Autowired})
	private EmailSender emailSender;
	
	@Setter(onMethod_= {@Autowired})
	private Email email;
	
	@Setter(onMethod_= {@Autowired})
	private EmailService emailService;
	
	
	@Scheduled(cron="*/30 * * * * *")
	public void scheduleRun(){
		
	}
}
