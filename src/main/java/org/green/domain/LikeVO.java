package org.green.domain;

import java.util.Date;

import lombok.Data;

@Data
public class LikeVO {
	private int lnum;
	private int gnum;
	private String userid;
	private String title;
	private String releasedate;
	private String price;
	private Date regdate;
	
}
