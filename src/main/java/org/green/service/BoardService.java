package org.green.service;

import java.util.List;

import org.green.domain.BoardAttachVO;
import org.green.domain.BoardCriteria;
import org.green.domain.BoardVO;

public interface BoardService {
	//등록 insert
	public void register(BoardVO bvo);
	//게시글 1개 조회 select
	public BoardVO view(int bnum);
	//수정하기
	public boolean modify(BoardVO bvo);
	//삭제하기
	public boolean remove(int bnum);
	//목록받기
	public List<BoardVO> getList(BoardCriteria cri);
	//게시글 총 개수
	public int getTotal(BoardCriteria cri);
	//조회 횟수 카운트
	public void updateCount(int bnum);
	//게시글 번호에 맞는 BoardAttachVO 받기
	public List<BoardAttachVO> getAttachList(int bnum);

}
