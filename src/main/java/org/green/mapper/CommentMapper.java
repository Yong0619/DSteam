package org.green.mapper;

import java.util.List;
import java.util.Map;

import org.green.domain.CommentCriteria;
import org.green.domain.CommentVO;

public interface CommentMapper {
	//등록
	public void insert(CommentVO cvo);
	//수정
	public int update(CommentVO cvo);
	//삭제
	public int delete(int cnum);
	//조회
	public List<CommentVO> getList(int gnum);
	
	//등록
	public void insert2(CommentVO cvo);
	//수정
	public int update2(CommentVO cvo);
	//삭제
	public int delete2(int cnum);
	//조회
	public List<CommentVO> getList2(int gnum);
	
	//등록
	public void insert3(CommentVO cvo);
	//수정
	public int update3(CommentVO cvo);
	//삭제
	public int delete3(int cnum);
	//조회
	public List<CommentVO> getList3(int gnum);
}
