package com.alj.dream.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.interest.service.RegisterInterestService;
import com.alj.dream.member.domain.Emailinfos;
import com.alj.dream.member.domain.RegisterInfo;
import com.alj.dream.member.exception.MemberExistException;
import com.alj.dream.member.service.RegisterService;

@Controller
@RequestMapping("/register")
public class RegisterController {
	
	private RegisterService service;
	private RegisterInterestService interestService;
	
	
	public RegisterController() {}
	
	
	


	@Autowired
	public RegisterController(RegisterService service, RegisterInterestService interestService) {
		
		this.service = service;
		this.interestService = interestService;
	}




	@GetMapping
	public String showRegisterForm(String adyn, Model model) {
		
		model.addAttribute("adyn", adyn==null?'N':'Y');
		
		return "member/registerform";
	}
	
	@PostMapping
	@ResponseBody
	@Transactional
	public String registerMember(HttpServletRequest req, Emailinfos email, RegisterInfo infos) {
		
	
		
		String result=null; 
		
		try {
			int insertResult =service.insertMember(req,email,infos);
			if(insertResult==1) {
				///////////////////////
				// 회원의 관심사 InterestCat 테이블에 추가
				
				interestService.insertInterest(infos);
				
				
				
				
				///////////////////////
				// 회원 가입 축하 이메일 전송
				
				
				
				////////////////////
				result="REGISTERED";
			}else {
				result="정상적으로 등록되지 않았습니다. 잠시 후 다시 시도하세요";
			}
			
		} catch (MemberExistException e) {
			result="이미 존재하는 이메일입니다";
			e.printStackTrace();
		} catch(Exception e) {
			// IllegalStateException, IOException 모두 하나의 오류타입으로 설정
			result="오류가 발생했습니다. 잠시 후 다시 시도하세요";
			e.printStackTrace();
		}
		
		return result;
	}
	
	
}
