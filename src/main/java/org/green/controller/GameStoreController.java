package org.green.controller;

import java.security.Principal;

import org.green.domain.Criteria;
import org.green.domain.GameStoreVO;
import org.green.domain.GameVO;
import org.green.domain.StoreCriteria;
import org.green.domain.StorePageDTO;
import org.green.service.GameService;
import org.green.service.GameStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("/gamestore/*")
@Log4j
@AllArgsConstructor
public class GameStoreController {
	@Setter(onMethod_= {@Autowired})
	private GameStoreService service;
	
	@Setter(onMethod_= {@Autowired})
	private GameService gameservice;
	
	@GetMapping("/register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
	public void register(int gnum, Model model) {
		model.addAttribute("register", gameservice.view(gnum));
	}
	@PostMapping("/register")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
	public String register(GameStoreVO gsvo, RedirectAttributes rttr) {
		service.register(gsvo);
		rttr.addAttribute("result", "판매 등록되었습니다.");
		return "redirect:/game/list"; 
	}
	//수정 페이지 접근을 위한 getmapping 생성
	@GetMapping("/modify")
	public void modify(int snum,int gnum, Model model) {
		model.addAttribute("modify", gameservice.view(gnum));
		model.addAttribute("modify",service.view(snum));
	}
	//수정
	@PostMapping("/modify")
	public String modify(int gnum, GameStoreVO gsvo, RedirectAttributes rttr) {
		boolean result = service.modify(gsvo);
		if(result) {
			rttr.addAttribute("result", "수정 되었습니다.");
		}
		return "redirect:/game/view?gnum=" + gnum;
	}
	//삭제
	@PostMapping("/remove")
	public String remove(@RequestParam("snum") int snum,int gnum, RedirectAttributes rttr) {
		boolean result = service.remove(snum);
		if(result) {
			rttr.addAttribute("result", "삭제 되었습니다.");
		} else {
			rttr.addAttribute("result", "삭제 되지 않았습니다.");
		}
		return "redirect:/game/view?gnum=" + gnum;
	}
	//리스트
	@GetMapping("/list")
	public void list(StoreCriteria cri, Model model, Principal principal, GameStoreVO gsvo) {
		String userid = principal.getName();
		cri.setUserid(userid);
		model.addAttribute("list",service.getListWithPaging(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new StorePageDTO(cri, total));
	}
	//수정
	@PostMapping("/storemodify")
	public String storemodify(int gnum, GameStoreVO gsvo, RedirectAttributes rttr,@ModelAttribute("cri") StoreCriteria cri) {
		log.info(gsvo);
		boolean result = service.modify(gsvo);
		if(result) {
			rttr.addAttribute("result", "수정 되었습니다.");
		}
		return "redirect:/gamestore/list";
	}
	//판매 등록 시 중복 체크
	@ResponseBody
	@GetMapping("/storeCheck")
	public ResponseEntity<String> storeCheck(@RequestParam("gnum") int gnum,@RequestParam("userid") String userid) {
		ResponseEntity<String> entity = null;
			
		String isUseID = "";
		if(service.storeCheck(gnum, userid) != null) {
			isUseID = "no"; // 판매중
		} else {
			isUseID = "yes"; // 판매 등록 가능
		}
			
		entity = new ResponseEntity<String>(isUseID, HttpStatus.OK);
			
		return entity;
	}
}
