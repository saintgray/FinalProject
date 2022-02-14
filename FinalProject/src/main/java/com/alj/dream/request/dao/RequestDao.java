package com.alj.dream.request.dao;

import java.util.List;

import com.alj.dream.request.domain.RequestGroup;
import com.alj.dream.request.domain.RequestMember;

public interface RequestDao {

	public int selectTotalPost(int idx, String wanted); 								

	public List<RequestGroup> selectRequestPostByMIdx(int idx, String wanted);

	public List<RequestMember> selectRequestMemberByPostIdx(int postidx); 																						

	public RequestGroup selectRequestPostByPostIdx(int postidx);
	
}