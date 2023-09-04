package org.green.controller;

import org.green.domain.BoardCriteria;
import org.green.domain.BoardPageDTO;
import org.green.domain.QnaVO;
import org.green.service.CommentService;
import org.green.service.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/qna/*")
@Log4j
@AllArgsConstructor
public class QnaController {
	@Setter(onMethod_= {@Autowired})
	private QnaService service;
	
	@Setter(onMethod_= {@Autowired})
	private CommentService commentservice;
	
	
	//등록 페이지 가기위해 Get 전송 등록
	@GetMapping("/register")
	public void register() {
		
	}
	//등록
	@PostMapping("/register")
	public String register(QnaVO qvo, RedirectAttributes rttr) {
		service.register(qvo);
		rttr.addAttribute("result", "등록했습니다.");
		return "redirect:/qna/list";
	}
	//리스트
	@GetMapping("/list")
	public void list(BoardCriteria cri, Model model) {
		model.addAttribute("list",service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
	}
	//QNA보기
	@GetMapping({"/view","/modify"})
	public void view(int qnum, Model model, @ModelAttribute("cri") BoardCriteria cri) {
		model.addAttribute("view", service.view(qnum));
		model.addAttribute("commentlist", commentservice.getList3(qnum));
	}
	//수정
	@PostMapping("/modify")
	public String modify(QnaVO qvo, RedirectAttributes rttr, @ModelAttribute("cri") BoardCriteria cri) {
		boolean result = service.modify(qvo);
		if(result) {
			rttr.addAttribute("result", "수정 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("qnum", qvo.getQnum());
		return "redirect:/qna/view";
	}
	//삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("qnum") int qnum, RedirectAttributes rttr) {
		boolean result = service.remove(qnum);
		if(result) {
			rttr.addAttribute("result", "삭제 되었습니다.");
		} else {
			rttr.addAttribute("result", "삭제 되지 않았습니다.");
		}
		return "redirect:/qna/list";
	}

	
}
