package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.green.domain.BoardCriteria;
import org.green.domain.BoardVO;

public interface BoardMapper {
	//등록
	public void insert(BoardVO bvo);
	//페이징 사용해서 조회
	public List<BoardVO> getListWithPaging(BoardCriteria cri);
	//전체 데이터 개수
	public int getTotalCount(BoardCriteria cri);
	//검색
	public List<BoardVO> searchBoard(Map<String, Map<String, String>> map);
	//상세조회
	public BoardVO view(int bnum);
	//조회 횟수 카운트
	public void updateCount(int bnum);
	//수정
	public int update(BoardVO bvo);
	//삭제
	public int delete(int bnum);
	
	public void insertSelectKey(BoardVO bvo);
	
	public List<BoardVO> findByBnum(int Bnum);
}
