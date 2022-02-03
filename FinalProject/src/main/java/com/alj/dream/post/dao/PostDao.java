package com.alj.dream.post.dao;

import java.util.List;

import com.alj.dream.post.domain.RequestGroup;
import com.alj.dream.post.domain.RequestMember;

public interface PostDao {

	public int selectTotalPost(int idx, String wanted);										// 회원(나)이 올린 게시물의 총 개수(조건 : 매칭테이블이 있는 것만=문의가 있는 것만)		
	
	//public RequestGroup selectRequestGroup(int idx, String wanted);							// 회원(나)이 올린 게시물의 받은요청 가져오기			
	
	//확인용
	public List<RequestGroup> selectRequestGroup(int idx, String wanted);
	
	
	public List<RequestMember>selectRequestMember(int midx, String wanted, int postidx);	// 회원(나)이 올린 게시물에 문의한 회원들 정보 리스트
	
	
}
