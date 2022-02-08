package com.alj.dream.profile.dao;

import com.alj.dream.profile.domain.MyProfileInfo;
import com.alj.dream.profile.domain.ProfileRegisterData;

public interface ProfileDao {

	MyProfileInfo getProfile(String m_idx);
	int insertProfile(ProfileRegisterData data);
	int deleteProfile(String profile_idx);
}
