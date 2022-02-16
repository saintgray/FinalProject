package com.alj.dream.post.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alj.dream.post.domain.PostListInfo;
import com.alj.dream.post.domain.PostViewRequest;
import com.alj.dream.post.domain.PostWriteRequest;
import com.alj.dream.post.domain.SearchParams;

public interface PostDao {

	int insertPost(PostWriteRequest wRequest);
	
	int updatePost(PostWriteRequest wRequest);
	
	int deletePost(int post_idx);

	PostViewRequest selectPostByPostIdx(int post_idx);
	
	PostWriteRequest selectWriteRequestByPostIdx(int post_idx);

	List<PostListInfo> selectListByMemberIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted, @Param("index")int index, @Param("count")int count);

	int selectCountByIdx(int m_idx);

	int selectTotalCountByIdx(@Param("m_idx")int m_idx, @Param("wanted")String wanted);
	
	int selectTotalCountBySearchParams(SearchParams params);
	
	List<PostListInfo> selectListBySearchParams(SearchParams params);
	
	HashMap<String, Integer> selectLocInterest(int m_idx);
	
	List<PostListInfo> selectRecommendedList(SearchParams params);

}
