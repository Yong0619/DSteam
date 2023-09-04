package org.green.service;

import java.util.List;

import org.green.domain.CommentCriteria;
import org.green.domain.CommentVO;
import org.green.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CommentServiceImpl implements CommentService {
	@Setter(onMethod_= {@Autowired} )
	private CommentMapper mapper;
	
	//등록
	@Override
	public void register(CommentVO cvo) {
		mapper.insert(cvo);
	}
	//리스트
	@Override
	public List<CommentVO> getList(int gnum) {
		return mapper.getList(gnum);
	}
	//수정
	@Override
	public boolean modify(CommentVO cvo) {
		int result = mapper.update(cvo);
		return result == 1;
	}
	//삭제
	@Override
	public boolean remove(int cnum) {
		return mapper.delete(cnum) == 1;
	}
	@Override
	public void register2(CommentVO cvo) {
		mapper.insert(cvo);
	}
	@Override
	public boolean remove2(int cnum) {
		return mapper.delete(cnum) == 1;
	}
	@Override
	public List<CommentVO> getList2(int gnum) {
		return mapper.getList2(gnum);
	}
	@Override
	public boolean modify2(CommentVO cvo) {
		int result = mapper.update(cvo);
		return result == 1;
	}
	@Override
	public void register3(CommentVO cvo) {
		mapper.insert(cvo);
	}
	@Override
	public List<CommentVO> getList3(int gnum) {
		return mapper.getList3(gnum);
	}
	@Override
	public boolean modify3(CommentVO cvo) {
		int result = mapper.update(cvo);
		return result == 1;
	}
	@Override
	public boolean remove3(int cnum) {
		return mapper.delete(cnum) == 1;
	}
	
	
	
	
	
	
	
	
}
