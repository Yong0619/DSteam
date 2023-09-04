package org.green.service;

import java.util.List;

import org.green.domain.BoardCriteria;
import org.green.domain.QnaVO;

public interface QnaService {
	//등록 insert
	public void register(QnaVO qvo);
	//게시글 1개 조회 select
	public QnaVO view(int qnum);
	//수정하기
	public boolean modify(QnaVO qvo);
	//삭제하기
	public boolean remove(int qnum);
	//목록받기
	public List<QnaVO> getList(BoardCriteria cri);
	//게시글 총 개수
	public int getTotal(BoardCriteria cri);
}
