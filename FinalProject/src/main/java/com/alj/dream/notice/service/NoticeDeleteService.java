package com.alj.dream.notice.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.notice.dao.NoticeDao;

@Service
public class NoticeDeleteService {

	@Autowired
	private SqlSessionTemplate sst;
	
	
	
	public int deleteNotice(String notice_idx) {
		return sst.getMapper(NoticeDao.class).deleteNotice(notice_idx);
	}
}
