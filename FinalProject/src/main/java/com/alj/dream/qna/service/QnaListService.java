package com.alj.dream.qna.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.qna.dao.QnaDao;
import com.alj.dream.qna.domain.PageRequest;
import com.alj.dream.qna.domain.Qna;
import com.alj.dream.qna.domain.QnaPageView;

@Service
public class QnaListService {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public QnaPageView getQnaList(PageRequest pagereq) {
		
		int selectPage = pagereq.getSelectPage()==null? 1: Integer.parseInt(pagereq.getSelectPage());
		//선택한페이지 = PageRequest의 getSelectPage가 null과 같다면 1의값을 넣어주고 값이 있다면 문자열을 정수로 변환해서 넣어줌
		int numOfQnaPerPage = pagereq.getNumOfQnaPerPage()==null? 5: Integer.parseInt(pagereq.getNumOfQnaPerPage());
		//페이지에 보여줄qna갯수 = PageRequest의 getNumOfQnaPerPage가 null가 같다면 5의값을 넣어주고 값이 있다면 문자열을 정수로 변환해서 넣어줌
		
		int selectPageFirstIndex = numOfQnaPerPage *(selectPage-1);
		//페이지의첫번쨰 인덱스 = 페이지에 보여줄qna갯수 *(선택한페이지-1)
		int totalNumOfQna = sst.getMapper(QnaDao.class).getTotalNumOfQna();
		//총qna의 갯수 = 문자열을 정수로 변환해 QnaDao에 매칭된 sql문을 매퍼가 실행.
		
		int totalPage = totalNumOfQna/numOfQnaPerPage;
		// 총페이지 = 총qna의 갯수/페이지에 보여줄 qna갯수
		totalPage = totalNumOfQna%numOfQnaPerPage==0?totalPage:totalPage+1;
		//총페이지 = 총qna의 갯수를 한 페이지에 보여줄 qna 갯수로 나눈 나머지가 0과 같다면 총페이지=총페이지  아니라면 총페이지=총페이지+1
		
		
		// limit ?, ? >> 1번쨰 ? = selectPageFirstIndex ,2번째 ? = numOfQnaPerPage
		List<Qna> list = sst.getMapper(QnaDao.class).getQnaList(selectPageFirstIndex, numOfQnaPerPage);
		QnaPageView pageView = new QnaPageView(totalPage, numOfQnaPerPage, selectPage, list);
		return pageView;
		
	}
}
