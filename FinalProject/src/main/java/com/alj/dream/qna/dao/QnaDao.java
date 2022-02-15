package com.alj.dream.qna.dao;

import java.util.List;

import com.alj.dream.qna.domain.Qna;
import com.alj.dream.qna.domain.QnaListContent;

public interface QnaDao {
	
	
	int getTotalNumOfQna();

	List<Qna> getQnaList(int selectPageFirstIndex, int numOfQnaPerPage);

	QnaListContent getQna(String qna_idx);
}
