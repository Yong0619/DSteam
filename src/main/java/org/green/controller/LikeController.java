package org.green.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.green.domain.LikeCriteria;
import org.green.domain.LikePageDTO;
import org.green.domain.LikeVO;
import org.green.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/like/*")
@Log4j
@AllArgsConstructor
public class LikeController {
	
	@Setter(onMethod_= {@Autowired})
	private LikeService service;
	
	//등록
	@PostMapping("/register")
	public String register(LikeVO lvo, int gnum) {
		log.info(lvo);
		service.register(lvo);
		return "redirect:/game/view?gnum=" + gnum; 
	}
	//삭제
	@PostMapping("/remove")
	public String remove(int lnum, int gnum, RedirectAttributes rttr,HttpServletResponse resp) {
		boolean result = service.remove(lnum);
		return "redirect:/game/view?gnum=" + gnum;
	}
	//리스트
	@GetMapping("/list")
	public void list(LikeCriteria cri, Model model, Principal principal, LikeVO lvo) {
		String userid = principal.getName();
		cri.setUserid(userid);
		log.info(cri);
		model.addAttribute("list",service.getListWithPaging(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new LikePageDTO(cri, total));
	}
	
}
