package org.green.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.green.domain.AuthVO;
import org.green.domain.EmailDTO;
import org.green.domain.MemberCriteria;
import org.green.domain.MemberPageDTO;
import org.green.domain.MemberVO;
import org.green.email.Email;
import org.green.email.EmailSender;
import org.green.service.EmailService;
import org.green.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/member/*")
@Log4j
@AllArgsConstructor
public class CommonController {
	@Setter(onMethod_= {@Autowired})
	private MemberService service;
	
	@Setter(onMethod_= {@Autowired})
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_= {@Autowired})
	private EmailSender emailSender;
	
	@Setter(onMethod_= {@Autowired})
	private Email email;
	
	@Setter(onMethod_= {@Autowired})
	private EmailService emailService;
	
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		model.addAttribute("msg","접근 거부");
	}
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		
		//값이 있을 경우
		if(error != null) {
			model.addAttribute("error", "로그인오류");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃~!");
		}
	}
	@GetMapping("/logout")
	public void logoutGet() {
	}
	
	//회원 등록 페이지 가기위해 Get 전송 등록
	@GetMapping("/register")
	public void register() {
			
	}
	//회원 등록
	@PostMapping("/register")
	public String memberRegister(MemberVO mvo, AuthVO avo, RedirectAttributes rttr) {
		mvo.setUserpw(pwencoder.encode(mvo.getUserpw()));
		service.register(mvo, avo);
		rttr.addAttribute("msg", mvo.getUserName()+"님 회원가입을 축하드립니다.");
		return "redirect:/member/login";
	}
	//회원 등록 시 아이디 중복 체크
	@ResponseBody
	@GetMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestParam("userid") String userid) {
		ResponseEntity<String> entity = null;
		
		String isUseID = "";
		if(service.idCheck(userid) != null) {
			isUseID = "no"; // 아이디 사용중
		} else {
			isUseID = "yes"; // 아이디 사용가능
		}
		
		entity = new ResponseEntity<String>(isUseID, HttpStatus.OK);
		
		return entity;
	}
	//회원 등록 시 이메일 중복 체크
	@ResponseBody
	@GetMapping("/emailCheck")
	public ResponseEntity<String> emailCheck(@RequestParam("email") String email) {
		ResponseEntity<String> entity = null;
		
		String isUseEmail = "";
		if(service.emailCheck(email) != null) {
			isUseEmail = "no"; // 아이디 사용중
		} else {
			isUseEmail = "yes"; // 아이디 사용가능
		}
		
		entity = new ResponseEntity<String>(isUseEmail, HttpStatus.OK);
		
		return entity;
	}
	//아이디 찾기 페이지 접속을 위한 get 전송
	@GetMapping({"/findid","/findidresult","/remove"})
	public void findId() {
		
	}
	//아이디 찾기
	@PostMapping("/findid")
	public String findId(MemberVO mvo, RedirectAttributes rttr) {
		MemberVO userid = service.findId(mvo);
		rttr.addAttribute("result", userid.getUserid());
		return "redirect:/member/findidresult";
	}
	//비밀번호 찾기
	@GetMapping("/findpw")
	public void findPw() {
		
	}
	@PostMapping("/findpw")
	public String findPw(@RequestParam("userid") String userid, @RequestParam("email") String email, RedirectAttributes rttr) {
		
		String db_userid = service.findPw(userid, email);
		String temp_pw = "";
		
		String url = "";
		String msg = "";
		
		if(db_userid != null) {
			UUID uid = UUID.randomUUID();
			
			//임시비밀번호는 8자리로
			temp_pw = uid.toString().substring(0,8); 
			
			//사용자의 임시 비밀번호를 암호화하여 DB에 저장
			service.changPw(db_userid, pwencoder.encode(temp_pw));
			
			//사용자에게 임시비밀번호 메일 발송
			EmailDTO dto = new EmailDTO("DSteam", "DSteam", email, "DSteam 임시 비밀번호 입니다.", "");
			
			try {
				emailService.sendMail(dto, temp_pw);
				url = "/member/login";
				rttr.addAttribute("msg", "메일이 발송되었습니다.");
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			url = "/member/findpw";
			
			rttr.addAttribute("msg", "입력하신 정보와 일치하는 회원이 없습니다. \n 확인해주세요.");
		}
		
		return "redirect:" + url;
	}
	
	//회원정보 보기
	@PostMapping("/view")
	public void view(String userid, Model model) {
		model.addAttribute("view", service.view(userid));
	}
	
	//회원정보 수정
	@PostMapping("/modify")
	public String modify(MemberVO mvo, RedirectAttributes rttr) {
		mvo.setUserpw(pwencoder.encode(mvo.getUserpw()));
		if(service.modify(mvo)) {
			rttr.addAttribute("result", "개인정보가 변경 되었습니다.");
		} else {
			rttr.addAttribute("result", "개인정보가 변경되지 않았습니다.");
		}
		return "redirect:/index";
	}
	
	//회원탈퇴
	@PostMapping("/remove")
	public String remove(MemberVO mvo, AuthVO avo, RedirectAttributes rttr) {
		boolean result = service.remove(avo, mvo);
		if(result) {
			rttr.addAttribute("result", "회원탈퇴가 완료되었습니다. 감사합니다.");
			SecurityContextHolder.clearContext();
		} else {
			rttr.addAttribute("result", "회원탈퇴가 되지 않았습니다.");
		}
		return "redirect:/index";
	}
	//회원목록
	@GetMapping("/list")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	public void list(MemberCriteria cri, Model model) {
		model.addAttribute("list",service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new MemberPageDTO(cri, total));
	}
	//관리자권한 회원정보수정
	@PostMapping("/adminModify")
	public String adminModify(MemberVO mvo,AuthVO avo, RedirectAttributes rttr) {
		log.info(mvo);
		log.info(avo);
		boolean result = service.adminModify(mvo, avo);
		if(result) {
			rttr.addAttribute("result", "회원정보가 수정되었습니다.");
		} else {
			rttr.addAttribute("result", "회원정보가 수정되지 않았습니다.");
		}
		return "redirect:/member/list";
	}
	
	
}