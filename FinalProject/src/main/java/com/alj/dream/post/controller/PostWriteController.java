package com.alj.dream.post.controller;

import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
			HttpServletRequest request
			) {
		
		request.setAttribute("result", writeService.insertPost(wRequest, request));
		// HttpSession session = request.getSession();
		// session.setAttribute("post", wRequest);
		
		return "post/list";
		
	}
	
//	@RequestMapping("/post/writeresult")
//	public String getResult() {
//		return "post/writeresult";
//	}
	
}
