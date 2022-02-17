package com.alj.dream.post.service;

import java.util.ArrayList;
import java.util.HashMap;
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
	
	// 멘토/멘티찾기 listview
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
	
	// 멘토/멘티찾기 글 목록
	public List<PostListInfo> getList(SearchParams params){
		
		dao = template.getMapper(PostDao.class);
		
		List<PostListInfo> list = dao.selectListBySearchParams(params);
		
		return list;
		
	}
	
	// 추천 리스트 선별시 필요한 파라미터 가져오기 : cat_idx, loc_idx
	private HashMap<String, Integer> getLocInterest(int m_idx){
		
		dao = template.getMapper(PostDao.class);
		
		return dao.selectLocInterest(m_idx);
		
	}
	
	// 추천 리스트 무작위로 5개 뽑아서 보여주기
	public List<PostListInfo> getRecommend(int m_idx, String wanted){
		
		dao = template.getMapper(PostDao.class);
		
		HashMap<String, Integer> map = getLocInterest(m_idx);
		System.out.println("result>>");
		System.out.println(map);
		
		// 회원가입시 관심분야를 선택하지 않을 수 있으므로 선택하지 않았을 경우 SearchParams 의 cat_idx 를 0으로 지정
		SearchParams params = new SearchParams(m_idx, wanted, map.get("cat_idx")==null?0:map.get("cat_idx"), map.get("loc_idx"));
		params.setIndex(0);
		params.setCount(5);
		
		return dao.selectRecommendedList(params);
		
	}

}
