package com.alj.dream.post.controller;

import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.service.PostWriteService;

@Controller
public class PostWriteController {
	
	@Autowired
	private PostWriteService writeService;

	@GetMapping("/post/write")
	public String getWriteForm() {
		return "post/writeform";
	}
	
	@PostMapping("/post/write")
	public String writePost(
			PostWriteRequest wRequest,
			HttpServletRequest request,
			Model model
			) {

		writeService.insertPost(wRequest, request);
		model.addAttribute("m_idx", wRequest.getM_idx());
		model.addAttribute("wanted", wRequest.getWanted());
		
		return "redirect:/post/list";
		
	}
	
}
