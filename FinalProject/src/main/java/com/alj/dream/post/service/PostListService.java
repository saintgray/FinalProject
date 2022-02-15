package com.alj.dream.post.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.PostListInfo;
import com.alj.dream.post.domain.PostListView;
import com.alj.dream.post.domain.SearchParams;

@Service
public class PostListService {

	private PostDao dao;

	@Autowired
	private SqlSessionTemplate template;

	// 페이지 당 노출할 메시지의 수
	private final int COUNT_PER_PAGE = 10;

	// 내가 쓴 글 목록
	public PostListView getMyPostList(int m_idx, String wanted, int pageNum) {
		
		dao = template.getMapper(PostDao.class);
		
		// 해당 회원이 쓴 전체 글의 개수
		int totalCount = dao.selectTotalCountByIdx(m_idx, wanted);
		
		int index = (pageNum-1)*COUNT_PER_PAGE;

		List<PostListInfo> list = new ArrayList<PostListInfo>();
		
		list = dao.selectListByMemberIdx(m_idx, wanted, index, COUNT_PER_PAGE);
		
		return new PostListView(totalCount, COUNT_PER_PAGE, pageNum, list);
	}
	
	// 멘토/멘티찾기 글 목록
	public List<PostListInfo> getList(SearchParams params){
		
		dao = template.getMapper(PostDao.class);
		
		List<PostListInfo> list = dao.selectListBySearchParams(params);
		
		return list;
		
	}
	
	public PostListView getSearchResult(SearchParams params) {
		
		dao = template.getMapper(PostDao.class);
		
		int totalCount = dao.selectTotalCountBySearchParams(params);
		int pageNum = params.getPageNum();
		int index = (pageNum-1)*COUNT_PER_PAGE;
		
		params.setIndex(index);
		params.setCount(COUNT_PER_PAGE);
		
		List<PostListInfo> list = dao.selectListBySearchParams(params);
		
		return new PostListView(totalCount, COUNT_PER_PAGE, pageNum, list);
	}

}
