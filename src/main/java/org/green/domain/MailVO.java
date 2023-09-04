package org.green.domain;

import java.util.List;

import lombok.Data;

@Data
public class MailVO {
	private String title;
	private String content;
	private List<String> recipientList;
}
