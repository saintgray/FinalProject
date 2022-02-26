package com.alj.dream.file_notice.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.alj.dream.file_notice.dao.NoticeFileDao;
import com.alj.dream.file_notice.domain.NoticeFileInfo;

@Service
public class NoticeFileUploadService {
	
	private NoticeFileDao dao;
	
	private SqlSessionTemplate template;
	
	public int insertNoticeFile(List<NoticeFileInfo> fileList) {
		
		int resultCnt = 0;
		
		dao = template.getMapper(NoticeFileDao.class);
		
		for(int i = 0; i< fileList.size(); i++) {
			resultCnt = dao.insertNoticeFiles(fileList.get(i));
			
			if(resultCnt==0) {
				return 0;
			}
		}
		return resultCnt;
	}
}
