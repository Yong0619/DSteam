package org.green.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int bnum;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	public int visitcount;

	private List<BoardAttachVO> attachList;

}
