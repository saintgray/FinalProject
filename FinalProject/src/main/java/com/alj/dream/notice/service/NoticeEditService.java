package com.alj.dream.notice.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeEditService {

	@Autowired
	private SqlSessionTemplate sst;
}
