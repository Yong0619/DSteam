package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.green.domain.LikeCriteria;
import org.green.domain.LikeVO;
import org.springframework.web.bind.annotation.RequestParam;

public interface LikeMapper {
	//찜 등록
	public void insert(LikeVO lvo);
	//찜 리스트
	public List<LikeVO> getList(LikeVO lvo);
	//찜 삭제
	public int delete(int lnum);
	//찜 정보 조회
	public LikeVO view(@Param("gnum") int gnum, @Param("userid") String userid);
	//페이징 사용해서 조회
	public List<LikeVO> getListWithPaging(LikeCriteria cri);
	//전체 데이터 개수
	public int getTotalCount(LikeCriteria cri);
	//검색
	public List<LikeVO> searchLike(Map<String, Map<String, String>> map);
	
}
