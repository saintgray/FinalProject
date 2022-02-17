package com.alj.dream.reply.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alj.dream.reply.dao.ReplyDao;
import com.alj.dream.reply.domain.ReplyRegisterData;

@Service
public class ReplyRegisterService {
	
	private SqlSessionTemplate sst;
	
	public ReplyRegisterService() {
		
	}
	@Autowired
	public ReplyRegisterService(SqlSessionTemplate sst) {
		this.sst = sst;
	}
	
	public int registerReply(ReplyRegisterData data) {
		
		return sst.getMapper(ReplyDao.class).insertReply(data);
		
	}
	
	
	
	
	

}
