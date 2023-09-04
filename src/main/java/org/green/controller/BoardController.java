package org.green.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.green.domain.BoardAttachVO;
import org.green.domain.BoardCriteria;
import org.green.domain.BoardPageDTO;
import org.green.domain.BoardVO;
import org.green.service.BoardService;
import org.green.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {
	@Setter(onMethod_= {@Autowired})
	private BoardService service;
	
	@Setter(onMethod_= {@Autowired})
	private CommentService commentservice;
	
	//등록 페이지 가기위해 Get 전송 등록
	@GetMapping("/register")
	public void register() {
			
	}
	@PostMapping("/register")
	public String register(BoardVO bvo,RedirectAttributes rttr) {
		service.register(bvo);
		rttr.addAttribute("result", "등록 되었습니다.");
		return "redirect:/board/freeboardlist";
	}
	//리스트
	@GetMapping("/freeboardlist")
	public void list(BoardCriteria cri, Model model) {
		model.addAttribute("list",service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
	}
	//게시글 보기
	@GetMapping({"/view","/modify"})
	public void view(@RequestParam("bnum") int bnum, @ModelAttribute("cri") BoardCriteria cri,Model model) {
		service.updateCount(bnum);
		model.addAttribute("view", service.view(bnum));
		model.addAttribute("commentlist", commentservice.getList2(bnum));
	}
	
	@GetMapping(value="/getAttachList", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(int bnum) {
		return new ResponseEntity<>(service.getAttachList(bnum), HttpStatus.OK);

	}
	//게시글 수정
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes rttr,@ModelAttribute("cri") BoardCriteria cri) {
		bvo.setBnum(bvo.getBnum());
		if(service.modify(bvo)) {
			rttr.addAttribute("result","수정 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("bnum", bvo.getBnum());
		return "redirect:/board/view";
	}
	//삭제 처리
	@PostMapping("/remove")
	public String remove(@RequestParam("bnum") int bnum, RedirectAttributes rttr) {
		List<BoardAttachVO> attachList = service.getAttachList(bnum);
		if(service.remove(bnum)) {
			deleteFiles(attachList);
			rttr.addAttribute("result","삭제 되었습니다.");
		}
		return "redirect:/board/freeboardlist";
	}
	//파일 삭제 메소드
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		attachList.forEach(attach->{
			Path file = Paths.get("C:\\upload\\"
					+attach.getUploadPath()+"\\"
					+attach.getUuid()+"_"
					+attach.getFileName());
			try {
				//파일이 있으면 삭제
				Files.deleteIfExists(file);
				//이미지일 경우 썸네일 삭제
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"
							+attach.getUploadPath()+"\\s_"
							+attach.getUuid()+"_"
							+attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
	}
	
}
