package com.alj.dream.file_notice.dao;

import java.util.List;

import com.alj.dream.file_profile.domain.FileInfo;

public interface NoticeFileDao {
	
	int insertNoticeFiles(List<FileInfo> files);

}
