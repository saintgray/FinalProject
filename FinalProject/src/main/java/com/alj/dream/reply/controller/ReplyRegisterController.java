package com.alj.dream.reply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alj.dream.reply.domain.ReplyRegisterData;
import com.alj.dream.reply.service.ReplyRegisterService;

@RestController
@RequestMapping("/admin/reply/register")
public class ReplyRegisterController {
	
	private ReplyRegisterService rrService;
	
	
	public ReplyRegisterController() {

	}

	@Autowired
	public ReplyRegisterController(ReplyRegisterService rrService) {
		this.rrService = rrService;
	}
	
	@PostMapping
	public int registerReply(ReplyRegisterData data) {
		int result =0;
		
		try {
			result=rrService.registerReply(data);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	

}
