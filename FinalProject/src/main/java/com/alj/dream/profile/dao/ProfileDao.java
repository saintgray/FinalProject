package com.alj.dream.profile.dao;

import com.alj.dream.profile.domain.MyProfileInfo;

public interface ProfileDao {

	MyProfileInfo getProfile(String m_idx);
	
}
