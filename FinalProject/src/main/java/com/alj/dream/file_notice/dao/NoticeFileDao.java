package com.alj.dream.file_notice.dao;

import java.util.List;

import com.alj.dream.file_notice.domain.NoticeFileInfo;
import com.alj.dream.file_profile.domain.FileInfo;

public interface NoticeFileDao {
	
	int insertNoticeFiles(NoticeFileInfo noticeFileInfo);

	int selectCountByNoticeIdx(int notice_idx);

	List<NoticeFileInfo> selectByNoticeIdx(int notice_idx);

	int deleteNoticeFile(int notice_idx);

	int deleteOneFile(int notice_idx, String file_nm);

}
