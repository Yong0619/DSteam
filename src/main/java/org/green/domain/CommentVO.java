package org.green.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	public int cnum;
	public int gnum;
	public String userid;
	public Date regdate;
	public String content;
}
