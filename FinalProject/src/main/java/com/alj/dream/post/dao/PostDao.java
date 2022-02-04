package com.alj.dream.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alj.dream.post.domain.PostListInfo;
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

	List<PostListInfo> selectListByMemberIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted, @Param("index")int index, @Param("count")int count);

	int selectCountByIdx(int m_idx);

	int selectTotalCountByIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted);

}
