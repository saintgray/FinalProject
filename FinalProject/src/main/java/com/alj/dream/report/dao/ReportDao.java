package com.alj.dream.report.dao;

import java.util.List;

import com.alj.dream.report.domain.ReportInfo;

public interface ReportDao {
	List<ReportInfo> getReportListByIdx(String m_idx);
}
