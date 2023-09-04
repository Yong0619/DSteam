package org.green.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.green.domain.LikeCriteria;
import org.green.domain.LikeVO;
import org.springframework.web.bind.annotation.RequestParam;

public interface LikeService {
	//찜 등록
	public void register(LikeVO lvo);
	//찜 리스트
	public List<LikeVO> getList(LikeVO lvo);
	//찜 삭제
	public boolean remove(int lnum);
	//찜 정보
	public LikeVO view(@Param("gnum") int gnum, @Param("userid") String userid);
	//목록
	public List<LikeVO> getListWithPaging(LikeCriteria cri);
	//게시글 총 개수
	public int getTotal(LikeCriteria cri);
	
}
