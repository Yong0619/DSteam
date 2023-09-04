package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.green.domain.GameStoreVO;
import org.green.domain.StoreCriteria;

public interface GameStoreMapper {
	//등록
	public void insert(GameStoreVO gsvo);
	//판매자리스트
	public List<GameStoreVO> getList(int gnum);
	//수정
	public int update(GameStoreVO gsvo);
	//삭제
	public int delete(int snum);
	//상세조회
	public GameStoreVO view(int snum);
	//페이징 사용해서 조회
	public List<GameStoreVO> getListWithPaging(StoreCriteria cri);
	//전체 데이터 개수
	public int getTotalCount(StoreCriteria cri);
	//검색
	public List<GameStoreVO> searchStore(Map<String, Map<String, String>> map);
	//판매 중복 체크
	public String storeCheck(@Param("gnum")int gnum, @Param("userid") String userid);
}
