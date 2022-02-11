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
		int midx = Integer.parseInt(logininfo.getM_idx());
		String mtype = logininfo.getM_type();
		
		String wanted = null;						// 게시물의 제안 대상
		
		if (mtype.equalsIgnoreCase("mentee")) {
			wanted="mentor";
			
		}else if(mtype.equalsIgnoreCase("mentor")) {
			wanted="mentee";
		}
		
		
		// 회원이 올린 게시글의 총 개수(문의를 받은 게시글만)
		int totalPostCount = dao.selectTotalPost(midx, wanted);
		int i =0;
		
		List<RequestMember> rmemberList = new ArrayList<RequestMember>();
		List<RequestGroup> rgroupList = dao.selectRequestPostByMIdx(midx, wanted);	
		
		while(i<totalPostCount) {
							
			int postidx = rgroupList.get(i).getPost_idx();			
	
			rmemberList = dao.selectRequestMemberByPostIdx(postidx);	// 게시글 고유번호에 문의한 회원정보를 rmemberList리스트에 add.
			


			rgroupList.get(i).setList(rmemberList);		
			
			i++;
		}

		return rgroupList;
	}
	
	
	
}
