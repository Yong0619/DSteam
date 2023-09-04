package org.green.service;

import java.util.List;

import org.green.domain.Criteria;
import org.green.domain.GameVO;
import org.green.mapper.GameMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
public class GameServiceImpl implements GameService{
	@Setter(onMethod_= {@Autowired} )
	private GameMapper mapper;
	
	//등록
	@Override
	public void register(GameVO gvo) {
		mapper.insert(gvo);
	}
	//페이징을 사용한 목록
	@Override
	public List<GameVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	//전체 리스트 개수
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri);
	}
	//상세조회
	@Override
	public GameVO view(int gnum) {
		GameVO gvo = mapper.view(gnum);
		return gvo;
	}
	//조회 횟수 카운트
	@Override
	public int updateCount(int gnum) {
		return mapper.updateCount(gnum);
	}
	//수정
	@Override
	public boolean modify(GameVO gvo) {
		int result = mapper.update(gvo);
		return result == 1;
	}
	//삭제
	@Override
	public boolean remove(int gnum) {
		return mapper.delete(gnum) == 1;
	}
	//인기 목록
	@Override
	public List<GameVO> getTopList() {
		return mapper.getTopList();
	}
	//최신 목록
	@Override
	public List<GameVO> getLastList() {
		return mapper.getLastList();
	}
	
	
	
	
	
	
}
