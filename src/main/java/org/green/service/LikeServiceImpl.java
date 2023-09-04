package org.green.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.domain.LikeCriteria;
import org.green.domain.LikeVO;
import org.green.mapper.LikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class LikeServiceImpl implements LikeService{
	@Setter(onMethod_= {@Autowired} )
	private LikeMapper mapper;
	//찜 등록
	@Override
	public void register(LikeVO lvo) {
		mapper.insert(lvo);
	}
	//찜 리스트
	@Override
	public List<LikeVO> getList(LikeVO lvo) {
		return mapper.getList(lvo);
	}
	//찜 삭제
	@Override
	public boolean remove(int lnum) {
		return mapper.delete(lnum) == 1;
	}
	//찜 조회
	@Override
	public LikeVO view(@Param("gnum") int gnum, @Param("userid") String userid) {
		LikeVO lvo = mapper.view(gnum, userid);
		return lvo;
	}
	//페이징 목록
	@Override
	public List<LikeVO> getListWithPaging(LikeCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	//총 찜 개수
	@Override
	public int getTotal(LikeCriteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	
	
}
