package com.alj.dream.post.dao;

import java.util.List;

import com.alj.dream.post.domain.PostListRequest;
import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.domain.RequestGroup;
import com.alj.dream.post.domain.RequestMember;

public interface PostDao {

	public int selectTotalPost(int idx, String wanted); 								

	public List<RequestGroup> selectRequestGroup(int idx, String wanted);

	public List<RequestMember> selectRequestMember(int postidx); 																						

	
	
	int insertPost(PostWriteRequest wRequest);

	List<PostViewRequest> selectPostByPostIdx(int post_idx);

	List<PostListRequest> selectListByMemberIdx(int m_idx);

	int selectCountByIdx(int m_idx);

}
