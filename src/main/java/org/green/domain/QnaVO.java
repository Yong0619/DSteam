package org.green.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnaVO {
	private int qnum;
	private String title;
	private String writer;
	private String content;
	private Date regdate;
}
