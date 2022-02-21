package com.alj.dream.request.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.profile.dao.ProfileDao;
import com.alj.dream.profile.domain.MyProfileInfo;
import com.alj.dream.request.dao.RequestDao;
import com.alj.dream.request.domain.RequestGroup;
import com.alj.dream.request.domain.RequestMember;

@Service
public class RequestPostService {

	private static final int String = 0;
	RequestDao dao;
	ProfileDao pdao;
	@Autowired
	SqlSessionTemplate template;
	
	
	public RequestGroup getRequestPost (int postIdx){
		
		System.out.println("RequestPostService : getRequestPost 진입");
		
		dao = template.getMapper(RequestDao.class);
		
		// 가져올때 : postidx에 맞는 게시글을 가져오고, 그 게시글idx를 가지고있는 매칭테이블들을 가져온다.
		
		RequestGroup rgroup = null;
		List<RequestMember> memList = new ArrayList<RequestMember>();
		
		//postidx에 맞는 게시글 가져오기
		rgroup = dao.selectRequestPostByPostIdx(postIdx);
		
		
		//postidx에 맞는멤버리스트 가져오기
		// 종현 수정
		memList = dao.selectRequestMemberByPostIdx(postIdx, rgroup.getWanted());
		System.out.println("memList 정보 :"+ memList);
		
		
		//RequestGroup 객체에 멤버 객체 저장하기
		rgroup.setList(memList);
		
		return rgroup;
	}
	
	
	public MyProfileInfo chkProfile(int myidx) {
		
		String m_idx = Integer.toString(myidx);
		
		pdao = template.getMapper(ProfileDao.class);
		
		MyProfileInfo info = pdao.getProfile(m_idx);  
		
		return info;
		
	}
	
}
