package org.green.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.green.domain.BoardCriteria;
import org.green.domain.CommentVO;
import org.green.service.CommentService;
import org.green.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/comment/*")
@Log4j
@AllArgsConstructor
public class CommentController {
	@Setter(onMethod_= {@Autowired})
	private CommentService service;
	
	@Setter(onMethod_= {@Autowired})
	private GameService gameservice;
	
	//등록
	@PostMapping("/register")
	public String register(CommentVO cvo, RedirectAttributes rttr, int gnum) {
		service.register(cvo);
		rttr.addAttribute("result", "소감이 등록되었습니다.");
		return "redirect:/game/view?gnum=" + gnum; 
	}
	//삭제
	@PostMapping("/remove")
	public String remove(int cnum,int gnum, RedirectAttributes rttr,HttpServletResponse resp) {
		boolean result = service.remove(cnum);
		return "redirect:/game/view?gnum=" + gnum;
	}
	//등록
	@PostMapping("/boardregister")
	public String register2(CommentVO cvo, RedirectAttributes rttr, int gnum, int pageNum, int amount, String keyword, String type) {
		service.register(cvo);
		return "redirect:/board/view?bnum=" + gnum + "&pageNum=" + pageNum + "&amount=" +amount+ "&keyword=" + keyword + "&type=" + type; 
	}
	//삭제
	@PostMapping("/boardremove")
	public String remove2(int cnum,int gnum, RedirectAttributes rttr,HttpServletResponse resp, int pageNum, int amount, String keyword, String type) {
		boolean result = service.remove(cnum);
		return "redirect:/board/view?bnum=" + gnum + "&pageNum=" + pageNum + "&amount=" +amount+ "&keyword=" + keyword + "&type=" + type;
	}
	//등록
	@PostMapping("/qnaregister")
	public String register3(CommentVO cvo, RedirectAttributes rttr, int gnum, int pageNum, int amount, String keyword, String type) {
		service.register(cvo);
		return "redirect:/qna/view?qnum=" + gnum + "&pageNum=" + pageNum + "&amount=" +amount+ "&keyword=" + keyword + "&type=" + type; 
	}
	//삭제
	@PostMapping("/qnaremove")
	public String remove3(int cnum,int gnum, RedirectAttributes rttr,HttpServletResponse resp, int pageNum, int amount, String keyword, String type) {
		boolean result = service.remove(cnum);
		return "redirect:/qna/view?qnum=" + gnum + "&pageNum=" + pageNum + "&amount=" +amount+ "&keyword=" + keyword + "&type=" + type;
	}
	
}
