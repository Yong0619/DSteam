package org.green.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.green.domain.CommentCriteria;
import org.green.domain.CommentPageDTO;
import org.green.domain.Criteria;
import org.green.domain.GameVO;
import org.green.domain.LikeVO;
import org.green.domain.PageDTO;
import org.green.service.CommentService;
import org.green.service.GameService;
import org.green.service.GameStoreService;
import org.green.service.LikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
@RequestMapping("/game/*")
@Log4j
@AllArgsConstructor
public class GameController {
	@Setter(onMethod_= {@Autowired})
	private GameService service;
	
	@Setter(onMethod_= {@Autowired})
	private GameStoreService storeservice;
	
	@Setter(onMethod_= {@Autowired})
	private CommentService commentservice;
	
	@Setter(onMethod_= {@Autowired})
	private LikeService likeservice;
	
	//등록 페이지 가기위해 Get 전송 등록
	@GetMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void register() {
		
	}
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void register(GameVO gvo, Model model) {
		service.register(gvo);
		model.addAttribute("result", "등록했습니다.");
	}
	//리스트
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		model.addAttribute("list",service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	//게임정보보기
	@GetMapping({"/view","/modify"})
	public void view(@ModelAttribute("gnum") int gnum, Model model, Principal principal, LikeVO lvo) {
		//인증 세부 정보 가져오기
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//비로그인 상태일때
		if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
			model.addAttribute("gnum", gnum);
			//게임정보
			service.updateCount(gnum);
			model.addAttribute("view", service.view(gnum));
			model.addAttribute("list", storeservice.getList(gnum));
			//한줄평
			model.addAttribute("commentlist", commentservice.getList(gnum));
		//로그인 상태일때
		} else {
			model.addAttribute("gnum", gnum);
			//게임정보
			service.updateCount(gnum);
			model.addAttribute("view", service.view(gnum));
			model.addAttribute("list", storeservice.getList(gnum));
			//한줄평
			model.addAttribute("commentlist", commentservice.getList(gnum));
			String userid = principal.getName();
			lvo.setGnum(gnum);
			lvo.setUserid(principal.getName());
			model.addAttribute("like", likeservice.getList(lvo));
			model.addAttribute("likeinfo", likeservice.view(gnum,userid));
		}
		
	}
	//수정
	@PostMapping("/modify")
	public String modify(GameVO gvo, RedirectAttributes rttr) {
		if(gvo.getFullname().equals("undefined") || gvo.getFullname() == null) {
			GameVO nvo = service.view(gvo.gnum);
			gvo.setFullname(nvo.getFullname());
			gvo.setFileName(nvo.getFileName());
			gvo.setUploadPath(nvo.getUploadPath());
		}
		boolean result = service.modify(gvo);
		if(result) {
			rttr.addAttribute("result", "수정 되었습니다.");
		}
		return "redirect:/game/list";
	}
	//삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("gnum") int gnum, RedirectAttributes rttr) {
		boolean result = service.remove(gnum);
		if(result) {
			rttr.addAttribute("result", "삭제 되었습니다.");
		} else {
			rttr.addAttribute("result", "삭제 되지 않았습니다.");
		}
		return "redirect:/game/list";
	}
}
