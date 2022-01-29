package com.alj.dream.member.dao;

import com.alj.dream.member.domain.RegisterInfo;

public interface MemberDao {
	
	int insertMember(RegisterInfo info);
	String selectByEmail(String m_email);

}
