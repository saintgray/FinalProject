package com.alj.dream.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alj.dream.post.domain.PostListInfo;
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

	List<PostListInfo> selectListByMemberIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted, @Param("index")int index, @Param("count")int count);

	int selectCountByIdx(int m_idx);

	int selectTotalCountByIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted);

}
