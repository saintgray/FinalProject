package com.alj.dream.post.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.RequestGroup;
import com.alj.dream.post.domain.RequestMember;

import security.AccountDetails;
@Service
public class RequestGroupService {
	
	
	private PostDao dao;
	@Autowired 
	SqlSessionTemplate template;
	
	
	// 받은 제의를 가져 올 메소드
	public List<RequestGroup> getRequestGroup (HttpSession session){
		
		dao = template.getMapper(PostDao.class);
		
		// 현재 로그인한 회원의 m_idx와 m_type(멘티/멘토)을 세션에서 가져온다.
		//int midx= Integer.parseInt(((AccountDetails) session.getAttribute("accountDetails")).getM_idx());
		//String mtype=((AccountDetails)session.getAttribute("accountDetails")).getM_type();
		
		// 임시테스트용 로그인 정보
		int midx=1;
		String mtype="mentee";
		
		
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
