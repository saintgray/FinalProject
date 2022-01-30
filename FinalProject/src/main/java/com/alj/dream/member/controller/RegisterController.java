package com.alj.dream.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.member.domain.RegisterInfo;
import com.alj.dream.member.service.RegisterService;

@Controller
@RequestMapping("/register")
public class RegisterController {
	
	private RegisterService service;
	
	
	public RegisterController() {}
	
	
	@Autowired
	public RegisterController(RegisterService service) {
		this.service = service;
	}



	@GetMapping
	public String showRegisterForm() {
		return "member/registerform";
	}
	
	@PostMapping
	@ResponseBody
	public String registerMember(RegisterInfo infos) {
		
		System.out.println(infos==null);
		System.out.println(infos.getM_email());
		System.out.println(infos.getInterest());
		
		String result=null; 
		
//		try {
//			int insertResult =service.insertMember(info);
//			if(insertResult==1) {
//				// 회원 가입 축하 이메일 전송
//				
//				
//				
//				////////////////////
//				result="회원 가입이 완료되었습니다!!!";
//			}else {
//				result="정상적으로 등록되지 않았습니다. 잠시 후 다시 시도하세요";
//			}
			
//		} catch (MemberExistException e) {
//			result="이미 존재하는 이메일입니다";
//			e.printStackTrace();
//		} catch(Exception e) {
//			result="오류가 발생했습니다. 잠시 후 다시 시도하세요";
//			e.printStackTrace();
//		}
		
		return "123";
	}
	
	
}
