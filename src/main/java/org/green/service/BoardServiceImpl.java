package org.green.service;

import java.util.List;

import org.green.domain.BoardAttachVO;
import org.green.domain.BoardCriteria;
import org.green.domain.BoardVO;
import org.green.mapper.BoardAttachMapper;
import org.green.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	@Setter(onMethod_= {@Autowired} )
	private BoardMapper mapper;
	
	@Setter(onMethod_= {@Autowired} )
	private BoardAttachMapper attachMapper;
	
	//등록
	@Override
	public void register(BoardVO bvo) {
		mapper.insertSelectKey(bvo);
		if(bvo.getAttachList() == null 
				|| bvo.getAttachList().size() <= 0) { return; }
		bvo.getAttachList().forEach(attach->{
			attach.setBnum(bvo.getBnum());
			attachMapper.insert(attach);
		});

	}
	//게시글 보기
	@Override
	public BoardVO view(int bnum) {
		BoardVO bvo = mapper.view(bnum);
		return bvo;
	}
	//게시글 수정
	@Override
	public boolean modify(BoardVO bvo) {
		//bnum번호에 해당하는 첨부파일 게시글 삭제
		attachMapper.deleteAll(bvo.getBnum());
		//board테이블 수정
		boolean modifyResult = mapper.update(bvo) == 1;
		//전송받은 첨부파일 항목은 데이터베이스에 등록하기
		if(bvo.getAttachList() != null && bvo.getAttachList().size() > 0) {
			bvo.getAttachList().forEach(attach->{
				attach.setBnum(bvo.getBnum());
				log.info(attach.getBnum());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	//삭제
	@Override
	public boolean remove(int bnum) {
		//첨부파일 삭제하기
		attachMapper.deleteAll(bnum);
		return mapper.delete(bnum) == 1;
	}
	//자유게시판 목록
	@Override
	public List<BoardVO> getList(BoardCriteria cri) {
		return mapper.getListWithPaging(cri);
	}
	//자유게시판 전체 글 개수
	@Override
	public int getTotal(BoardCriteria cri) {
		return mapper.getTotalCount(cri);
	}
	//글 조회수
	@Override
	public void updateCount(int bnum) {
		mapper.updateCount(bnum);
	}
	
	@Override
	public List<BoardAttachVO> getAttachList(int bnum) {
		return attachMapper.findByBnum(bnum);
	}
	
	
	
}
