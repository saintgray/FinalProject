//package com.alj.dream.admin.service;
//
//import java.util.List;
//
//import org.mybatis.spring.SqlSessionTemplate;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.alj.dream.admin.dao.QnaDao;
//import com.alj.dream.admin.domain.QnaListMessage;
//import com.alj.dream.admin.domain.QnaListView;
//import com.bitcamp.op.guestbook.dao.GuestBookDao;
//import com.bitcamp.op.guestbook.domain.GuestBookListMessage;
//import com.bitcamp.op.guestbook.domain.GuestBookListView;
//
//@Service
//public class QnaListService {
//
//private QnaDao dao;
//	
//	@Autowired
//	private SqlSessionTemplate template;
//	
//	// 페이지 당 노출할 메시지의 수
//	private final int COUNT_PER_PAGE = 5;
//	// 페이징 번호 노출 개수
//	private final int COUNT_PER_PAGING_NUM = 5;
//	
//	public QnaListView  getPage(int currentPage) {
//		
//		dao = template.getMapper(QnaDao.class);
//		
//		// 전체 회원 수
//		int totalCount = dao.selectTotalCount();
//				
//		int index = (currentPage - 1) * COUNT_PER_PAGE;
//		// 화면에 노출할 메시지
//		List<QnaListMessage> list = dao.selectList(index, COUNT_PER_PAGE);
//		
//		return new QnaListView(currentPage, COUNT_PER_PAGE, COUNT_PER_PAGING_NUM, list, totalCount);
//		
//		
//		
//	}
//}
