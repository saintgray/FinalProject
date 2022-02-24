package com.alj.dream.file_post.dao;

import java.util.List;

import com.alj.dream.file_post.domain.PostFileRequest;

public interface PostFilesDao {

	int insertPostFile(PostFileRequest fileRequest);
	
	int selectCountByPostIdx(int post_idx);
	
	int deletePostFile(int post_idx);
	
	List<PostFileRequest> selectByPostIdx(int post_idx);

}
