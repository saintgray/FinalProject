package com.alj.dream.report.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.report.dao.ReportDao;
import com.alj.dream.report.domain.Report;

@Service
public class ReportInsertService {

	ReportDao dao;
	
	@Autowired
	SqlSessionTemplate template;
	
	public int insertReport(Report r) {
		
		dao = template.getMapper(ReportDao.class);
		
		int resultCnt = dao.insertReport(r);
		
		return resultCnt;
		
	}
	
	
}
