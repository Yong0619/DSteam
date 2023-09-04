package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.green.domain.Criteria;
import org.green.domain.GameVO;

public interface GameMapper {
	//등록
	public void insert(GameVO gvo);
	//페이징 사용해서 조회
	public List<GameVO> getListWithPaging(Criteria cri);
	//전체 데이터 개수
	public int getTotalCount(Criteria cri);
	//검색
	public List<GameVO> searchGame(Map<String, Map<String, String>> map);
	//상세조회
	public GameVO view(int gnum);
	//조회 횟수 카운트
	public int updateCount(int gnum);
	//수정
	public int update(GameVO gvo);
	//삭제
	public int delete(int gnum);
	//인기 조회
	public List<GameVO> getTopList();
	//인기 조회
	public List<GameVO> getLastList();
	
}
