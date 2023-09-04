package org.green.service;

import java.util.List;

import org.green.domain.CommentCriteria;
import org.green.domain.CommentVO;

public interface CommentService {
	//등록
	public void register(CommentVO cvo);
	public void register2(CommentVO cvo);
	public void register3(CommentVO cvo);
	//목록
	public List<CommentVO> getList(int gnum);
	public List<CommentVO> getList2(int gnum);
	public List<CommentVO> getList3(int gnum);
	//수정
	public boolean modify(CommentVO cvo);
	public boolean modify2(CommentVO cvo);
	public boolean modify3(CommentVO cvo);
	//삭제
	public boolean remove(int cnum);
	public boolean remove2(int cnum);
	public boolean remove3(int cnum);
	
}
