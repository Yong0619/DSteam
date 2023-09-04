package org.green.service;

import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.GameVO;

public interface GameService {
	//등록
	public void register(GameVO gvo);
	//페이징을 사용한 목록
	public List<GameVO> getList(Criteria cri);
	//게시글 총 개수
	public int getTotal(Criteria cri);
	//게임정보
	public GameVO view(int gnum);
	//조회 횟수 카운트
	public int updateCount(int gnum);
	//수정
	public boolean modify(GameVO gvo);
	//삭제
	public boolean remove(int gnum);
	//인기 목록
	public List<GameVO> getTopList();
	//최신 목록
	public List<GameVO> getLastList();
}
