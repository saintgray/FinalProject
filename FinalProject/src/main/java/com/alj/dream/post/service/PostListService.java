package com.alj.dream.post.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostListInfo;

@Service
public class PostListService {

	private PostDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 페이지 당 노출할 메시지의 수
	private final int COUNT_PER_PAGE = 10;
	// 페이징 번호 노출 개수
	private final int COUNT_PER_PAGING_NUM = 5;

	public List<PostListInfo> getPage(int m_idx, String wanted, int pageNum) {
		
		dao = template.getMapper(PostDao.class);
		
		// 해당 회원이 쓴 전체 글의 개수
		int totalCount = dao.selectTotalCountByIdx(m_idx, wanted);
		
		int index = (pageNum-1)*COUNT_PER_PAGE;

		List<PostListInfo> list = new ArrayList<PostListInfo>();

		list = dao.selectListByMemberIdx(m_idx, wanted, index, COUNT_PER_PAGE);
		// 매칭유무 컬럼을 나중에 mapper sql에 추가해야 함
		
		return list;
	}

}
