package com.alj.dream.notice.dao;

import java.util.List;

import com.alj.dream.notice.domain.Notice;

public interface NoticeDao {
	
	List<Notice> getNoticeList(int firstIndex, int numOfNotices);
	String getTotalNumOfNotice();

}
