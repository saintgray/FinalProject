package com.alj.dream.file_post.dao;

import com.alj.dream.file_post.domain.PostFileRequest;

public interface PostFilesDao {

	int insertPostFile(PostFileRequest fileRequest);
	
	int selectCountByPostIdx(int post_idx);
	
	int deletePostFile(int post_idx);

}
