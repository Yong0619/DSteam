package org.green.service;

import java.util.List;

import org.green.domain.BoardCriteria;
import org.green.domain.QnaVO;
import org.green.mapper.AuthMapper;
import org.green.mapper.MemberMapper;
import org.green.mapper.QnaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class QnaServiceImpl implements QnaService {
	@Setter(onMethod_= {@Autowired} )
	private QnaMapper mapper;
	
	//등록
	@Override
	public void register(QnaVO qvo) {
		mapper.insert(qvo);
	}
	//상세조회
	@Override
	public QnaVO view(int qnum) {
		QnaVO qvo = mapper.view(qnum);
		return qvo;
	}
	//수정
	@Override
	public boolean modify(QnaVO qvo) {
		int result = mapper.update(qvo);
		return result == 1;
	}
	//삭제
	@Override
	public boolean remove(int qnum) {
		return mapper.delete(qnum) == 1;
	}
	//목록
	@Override
	public List<QnaVO> getList(BoardCriteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(BoardCriteria cri) {
		return mapper.getTotalCount(cri);
	}
	
	
	
}
