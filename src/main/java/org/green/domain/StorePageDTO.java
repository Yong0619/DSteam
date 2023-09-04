package org.green.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class StorePageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private StoreCriteria cri;
	
	//생성자
	public StorePageDTO(StoreCriteria cri, int total) {
		this.cri = cri;
		//전체 레코드 수
		this.total = total;
		this.endPage = (int) (Math.ceil(cri.getPageNum()/10.0)) * 10;
		this.startPage = this.endPage -9;
		//전체 마지막 페이지번호
		int realEnd = (int) (Math.ceil((total*1.0)/cri.getAmount()));
		//마지막 페이지 보다 페이징 마지막 번호가 크면 
		//페이징 마지막 번호에 실제 마지막 번호를 할당
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		//시작페이지 번호가 1보다 크면 prev는 true
		this.prev = this.startPage > 1;
		//마지막 페이지 번호가 실제 마지막 페이지 번호보다 작으면 next는 true
		this.next = this.endPage < realEnd;
	}
}
