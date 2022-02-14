package com.alj.dream.report.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.report.dao.ReportDao;
import com.alj.dream.report.domain.ReportInfo;

@Service
public class ReportListService {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<ReportInfo> getReportListByIdx(String m_idx) {
		
		
		return sst.getMapper(ReportDao.class).getReportListByIdx(m_idx);
		
	}
}
