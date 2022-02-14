package com.alj.dream.member.dao;

import java.util.List;

import com.alj.dream.member.domain.MemberInfo;
import com.alj.dream.member.domain.PageRequest;
import com.alj.dream.member.domain.RegisterInfo;

public interface MemberDao {
	
	int insertMember(RegisterInfo info);
	String selectByEmail(String m_email);
	List<MemberInfo> getMemberList(PageRequest req);
	String getTotalNumOfMember();
	MemberInfo getMemberInfo(String m_idx);
}
