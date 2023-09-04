package org.green.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.domain.GameStoreVO;
import org.green.domain.StoreCriteria;
import org.green.mapper.GameStoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class GameStoreServiceImpl implements GameStoreService{
	@Setter(onMethod_= {@Autowired} )
	private GameStoreMapper mapper;

	//등록
	@Override
	public void register(GameStoreVO gsvo) {
		mapper.insert(gsvo);
		
	}
	//목록
	@Override
	public List<GameStoreVO> getList(int gnum) {
		return mapper.getList(gnum);
	}
	//수정
	@Override
	public boolean modify(GameStoreVO gsvo) {
		int result = mapper.update(gsvo);
		return result == 1;
	}
	//삭제
	@Override
	public boolean remove(int snum) {
		return mapper.delete(snum) == 1;
	}
	//판매정보보기
	@Override
	public GameStoreVO view(int snum) {
		GameStoreVO gsvo = mapper.view(snum);
		return gsvo;
	}
	//페이징목록
	@Override
	public List<GameStoreVO> getListWithPaging(StoreCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	//총 판매 등록 개수
	@Override
	public int getTotal(StoreCriteria cri) {
		return mapper.getTotalCount(cri);
	}
	//판매 중복 체크
	@Override
	public String storeCheck(@Param("gnum")int gnum, @Param("userid") String userid) {
		return mapper.storeCheck(gnum, userid);
	}
	
	
	
}
