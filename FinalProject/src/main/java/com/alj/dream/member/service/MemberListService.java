package com.alj.dream.member.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.member.dao.MemberDao;
import com.alj.dream.member.domain.MemberInfo;
import com.alj.dream.member.domain.MemberListView;
import com.alj.dream.member.domain.PageRequest;

@Service
public class MemberListService {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public MemberListView getMemberList(PageRequest pagereq) {
	int selectPage =pagereq.getSelectPage();
	int numOfMemberPerPage = pagereq.getNumOfMemberPerPage();
	
	int firstMemberIndexOfSelectedPage = numOfMemberPerPage*(selectPage-1);
	pagereq.setFirstMemberIndexOfSelectedPage(firstMemberIndexOfSelectedPage);
	
	
	int totalNumOfMember = Integer.parseInt(sst.getMapper(MemberDao.class).getTotalNumOfMember());
	int totalPage=totalNumOfMember/numOfMemberPerPage;
	
	System.out.println(pagereq.getFirstMemberIndexOfSelectedPage());
	System.out.println(pagereq.getNumOfMemberPerPage());
	System.out.println(pagereq.getSelectPage());
	System.out.println(pagereq.getBlacklisted());
	
	
	List<MemberInfo> list = sst.getMapper(MemberDao.class).getMemberList(pagereq);
		
	MemberListView pageView=
			new MemberListView(totalPage,
							   numOfMemberPerPage,
							   selectPage,
							   list);
		return pageView;
	}
}
