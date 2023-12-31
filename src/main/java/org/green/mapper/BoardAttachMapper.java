package org.green.mapper;

import java.util.List;

import org.green.domain.BoardAttachVO;

public interface BoardAttachMapper {
	//등록
	public void insert(BoardAttachVO vo);
	//삭제
	public void delete(String uuid);
	//조회
	public List<BoardAttachVO> findByBnum(int bnum);
	//게시글에 해당하는 레코드 삭제
	public void deleteAll(int bnum);

}
