package org.green.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentCriteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String sort;
	private int gnum;
	
	// 생성자를 통해서 기본값 1페이지, 10개로 지정
	public CommentCriteria() {
		this(1,10, "regdate desc", 0);
	}
	public CommentCriteria(int pageNum, int amount, String sort, int gnum) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.sort = sort;
		this.gnum = gnum;
	}
	//검색조건을 배열로 만들어서 리턴(한번에 처리하기 위함)
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
