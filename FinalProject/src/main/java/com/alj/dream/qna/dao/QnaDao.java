package com.alj.dream.qna.dao;

import java.util.List;

import com.alj.dream.qna.domain.PageRequest;
import com.alj.dream.qna.domain.Qna;
import com.alj.dream.qna.domain.QnaListContent;

public interface QnaDao {
	
	
	int getTotalNumOfQna(String m_idx);

	List<Qna> getQnaList(PageRequest pagereq);

	QnaListContent getQna(String qna_idx);
}
