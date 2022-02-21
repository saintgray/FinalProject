package com.alj.dream.request.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.alj.dream.request.dao.RequestDao;
import com.alj.dream.request.domain.RequestGroup;
import com.alj.dream.request.domain.RequestMember;

import security.AccountDetails;
@Service
public class RequestGroupService {
	
	private RequestDao dao;
	
	@Autowired 
	private SqlSessionTemplate template;
	
	
	
	// 받은 제의를 가져 올 메소드
	public List<RequestGroup> getRequestGroup (Authentication auth){
		
		dao = template.getMapper(RequestDao.class);
	
		AccountDetails logininfo = (AccountDetails)auth.getPrincipal();
		int myidx = Integer.parseInt(logininfo.getM_idx());
		String mytype = logininfo.getM_type();
		
		String wanted = null;						// 게시물의 제안 대상
		
		if (mytype.equalsIgnoreCase("mentee")) {
			wanted="mentor";
			
		}else if(mytype.equalsIgnoreCase("mentor")) {
			wanted="mentee";
		}
		
		
		// 회원이 올린 게시글의 총 개수(문의를 받은 게시글만)
		int totalPostCount = dao.selectTotalPost(myidx, wanted);
		int i =0;
		int totalMember = 0;
		String overfive = null;
		
		
		
		List<RequestMember> rmemberList = new ArrayList<RequestMember>();
		List<RequestGroup> rgroupList = dao.selectRequestPostByMIdx(myidx, wanted);	
		
		while(i<totalPostCount) {
							
			int postidx = rgroupList.get(i).getPost_idx();
			// 종현 수정
			String watned=rgroupList.get(i).getWanted();
			
			// 게시글 고유번호에 문의한 회원정보를 rmemberList리스트에 add.
			// 종현 수정(파라미터추가)
			rmemberList = dao.selectRequestMemberByPostIdx(postidx, wanted);	
			
			rgroupList.get(i).setList(rmemberList);
			
			totalMember = dao.totalRequestMemberByPostIdx(postidx);
			System.out.println("totalMember:"+totalMember);
			// 화면에 표시할  멤버수는 최대 4명이다. 그 이상은 ...으로 표기할 예정
			if(totalMember > 4) {
				overfive = "Y";
			}else {
				overfive = "N";
			}
			rgroupList.get(i).setOverfive(overfive);
			
			System.out.println(i+"번째 : "+overfive);
			
			i++;
		}

		return rgroupList;
	}
	
	
	
}
