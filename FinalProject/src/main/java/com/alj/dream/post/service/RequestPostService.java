package com.alj.dream.post.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.RequestGroup;
import com.alj.dream.post.domain.RequestMember;

@Service
public class RequestPostService {

	PostDao dao;
	@Autowired
	SqlSessionTemplate template;
	
	
	public RequestGroup getRequestPost (int postIdx){
		
		dao = template.getMapper(PostDao.class);
		System.out.println("getRequestPost메소드 시작");
		// 가져올때 : postidx에 맞는 게시글을 가져오고, 그 게시글idx를 가지고있는 매칭테이블들을 가져온다.
		
		RequestGroup rgroup = null;
		List<RequestMember> memList = new ArrayList<RequestMember>();
		
		System.out.println("//postidx에 맞는 게시글 가져오기 시작");
		//postidx에 맞는 게시글 가져오기
		System.out.println(postIdx);
		rgroup = dao.selectRequestPostByPostIdx(postIdx);
		System.out.println("rgroup 정보 (멤버리스트 저장 전): " + rgroup);
		
		
		System.out.println();
		System.out.println("//postidx에 맞는멤버리스트 가져오기");
		//postidx에 맞는멤버리스트 가져오기
		memList = dao.selectRequestMemberByPostIdx(postIdx);
		System.out.println("memList 정보 :"+ memList);
		
		System.out.println();
		System.out.println("//RequestGroup 객체에 멤버 객체 저장하기");
		//RequestGroup 객체에 멤버 객체 저장하기
		rgroup.setList(memList);
		System.out.println("rgroup 정보 (멤버리스트 저장 후):" + rgroup);
		
		System.out.println("저장성공");
		return rgroup;
		
		
	}
	
	
}
