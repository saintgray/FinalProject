package com.alj.dream.notice.dao;

import java.util.List;

import com.alj.dream.notice.domain.Notice;
import com.alj.dream.notice.domain.NoticeContent;
import com.alj.dream.notice.domain.NoticeRegisterData;

public interface NoticeDao {
	
	List<Notice> getNoticeList(int firstIndex, int numOfNotices);
	String getTotalNumOfNotice();
	int insertNotice(NoticeRegisterData data);
	NoticeContent getNotice(String notice_idx);
	int updateNotice(NoticeRegisterData data);
	int deleteNotice(String notice_idx);

}
