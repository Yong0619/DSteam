package org.green.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LikeCriteria {
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String sort;
	private String userid;
	
	// 생성자를 통해서 기본값 1페이지, 10개로 지정
	public LikeCriteria() {
		this(1,10, "regdate desc", "");
	}
	public LikeCriteria(int pageNum, int amount, String sort, String userid) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.sort = sort;
		this.userid = userid;
	}
	//검색조건을 배열로 만들어서 리턴(한번에 처리하기 위함)
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
