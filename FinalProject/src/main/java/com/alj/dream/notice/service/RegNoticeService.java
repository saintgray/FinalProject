package com.alj.dream.notice.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.alj.dream.notice.dao.NoticeDao;
import com.alj.dream.notice.domain.NoticeRegisterData;

import security.AccountDetails;

@Service
public class RegNoticeService {

	@Autowired
	private SqlSessionTemplate sst;
	
	// 관리자가 적은 데이터(공지사항)을 notice 테이블에 추가하는 서비스 클래스의 메소드
	public int insertNotice(Authentication auth, NoticeRegisterData data) {
		
		// 시큐리티의 UserDetails 객체를 상속받은 AccountDetails 객체안에 있는 관리자의 idx를 얻는법
		AccountDetails logininfo = (AccountDetails)auth.getPrincipal();
		String admin_idx= logininfo.getAdmin_idx();
		
		data.setAdmin_idx(admin_idx);
		
		int result=sst.getMapper(NoticeDao.class).insertNotice(data);
		
		return result;
	}
}
