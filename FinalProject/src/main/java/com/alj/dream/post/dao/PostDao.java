package com.alj.dream.post.dao;

import java.util.List;

import com.alj.dream.post.domain.PostListRequest;
import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.domain.RequestGroup;
import com.alj.dream.post.domain.RequestMember;

public interface PostDao {

	// 작성자 : 정지원
	// 사용분야 : 받은요청 
	public int selectTotalPost(int idx, String wanted); 								

	public List<RequestGroup> selectRequestPostByMIdx(int idx, String wanted);

	public List<RequestMember> selectRequestMemberByPostIdx(int postidx); 																						

	public RequestGroup selectRequestPostByPostIdx(int postidx);
	
	
	// 작성자 : 김지현
	int insertPost(PostWriteRequest wRequest);

	List<PostViewRequest> selectPostByPostIdx(int post_idx);

	List<PostListRequest> selectListByMemberIdx(int m_idx);

	int selectCountByIdx(int m_idx);

}
