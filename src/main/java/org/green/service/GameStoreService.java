package org.green.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.domain.GameStoreVO;
import org.green.domain.StoreCriteria;

public interface GameStoreService {
	//등록
	public void register(GameStoreVO gsvo);
	//목록
	public List<GameStoreVO> getList(int gnum);
	//수정
	public boolean modify(GameStoreVO gsvo);
	//삭제
	public boolean remove(int snum);
	//게임정보
	public GameStoreVO view(int snum);
	//목록
	public List<GameStoreVO> getListWithPaging(StoreCriteria cri);
	//게시글 총 개수
	public int getTotal(StoreCriteria cri);
	//판매 중복 Check
	public String storeCheck(@Param("gnum")int gnum, @Param("userid") String userid);
	
}
