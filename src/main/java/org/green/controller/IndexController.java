package org.green.controller;

import org.green.service.GameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/*")
@Log4j
@AllArgsConstructor
public class IndexController {
	@Setter(onMethod_= {@Autowired})
	private GameService gameservice;
	
	@GetMapping("/index")
	public void index(Model model) {
		model.addAttribute("top", gameservice.getTopList());
		model.addAttribute("last", gameservice.getLastList());
	}
	
}
