package com.alj.dream.reply.dao;

import java.util.List;

import com.alj.dream.reply.domain.ReplyInfo;
import com.alj.dream.reply.domain.ReplyRegisterData;

public interface ReplyDao {

	int insertReply(ReplyRegisterData data);
	ReplyInfo getReplyByQnaIdx(String qna_idx);

}
