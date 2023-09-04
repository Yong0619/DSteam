package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.green.domain.BoardCriteria;
import org.green.domain.QnaVO;

public interface QnaMapper {
	//등록
	public void insert(QnaVO qvo);
	//페이징 사용해서 조회
	public List<QnaVO> getListWithPaging(BoardCriteria cri);
	//전체 데이터 개수
	public int getTotalCount(BoardCriteria cri);
	//검색
	public List<QnaVO> searchQna(Map<String, Map<String, String>> map);
	//상세조회
	public QnaVO view(int qnum);
	//수정
	public int update(QnaVO qvo);
	//삭제
	public int delete(int qnum);
}
