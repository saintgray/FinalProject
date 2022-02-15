package com.alj.dream.match.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alj.dream.match.service.MatchChkService;

@Controller
public class MatchChkController {

	@Autowired
	MatchChkService service;
	
	@RequestMapping(value="/post/matchchk", method=RequestMethod.POST)
	@ResponseBody
	public int matchChk(
			@RequestParam("postidx") int postidx,
			@RequestParam("midx") int midx,
			@RequestParam("myidx") int myidx,
			@RequestParam("wanted") String wanted
			) {
		
		//확인용
		System.out.println("MatchChkController : matchChk진입성공");
		
		System.out.println("postidx" + postidx);
		System.out.println("midx"+ midx);
		System.out.println("myidx" + myidx);
		System.out.println("wanted" + wanted);
		
		
		int matchIdx = service.getMatch(postidx, midx, myidx, wanted);
		
		System.out.println("MatchChkController : MatchChkService다녀온 후");
		System.out.println("matchIdx : "+ matchIdx);
		
		return matchIdx;
	}
}
