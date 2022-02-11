package sockethandler;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.alj.dream.post.dao.PostDao;
import com.alj.dream.post.domain.Chat;
import com.alj.dream.post.domain.Match;

import security.AccountDetails;


public class MatchService {
	
	private PostDao dao;
	
	
	@Autowired
	private SqlSessionTemplate template;
	
//	MatchCheckService에서 사용
//	// 매칭테이블 생성
//	public int checkMatch( int postidx, int midx, Authentication auth) {
//		
//		//여기서 select를 먼저 해준다.
//		//select해서 가져와지면 성공,
//		//아니라면 insert해줘야한다.
//		
//		System.out.println("서비스insertMatch메소드 진입 성공");
//		
//		dao = template.getMapper(PostDao.class);
//		System.out.println("dao.getMapper성공");
//		
//		AccountDetails logininfo = (AccountDetails)auth.getPrincipal();		// 로그인정보 가져오기
//		System.out.println("로그인인포 가져오기 성공");
//		String mtype = logininfo.getM_type();
//		System.out.println("mtype : " + mtype);
//		int myidx = Integer.parseInt(logininfo.getM_idx());
//		System.out.println("myidx : "+ myidx);
//		
//		
//		int menteeIdx = 0;
//		int mentorIdx = 0;
//		
//		if (mtype.equalsIgnoreCase("mentee")) {
//			menteeIdx = myidx;
//			mentorIdx = midx;
//		}else if(mtype.equalsIgnoreCase("mentor")) {
//			menteeIdx = midx;
//			mentorIdx = myidx;;
//		}
//		System.out.println("menteeIdx : "+menteeIdx);
//		System.out.println("mentorIdx : "+mentorIdx);
//		
//		Match match=dao.selectMatch(postidx, menteeIdx, mentorIdx);	// 매칯테이블 가져오기
//		System.out.println("매칭테이블가져오기성공");
//		
//		if(match == null) {
//			//매칭테이블이 존재하지 않는다면 테이블을 생성한다.
//			System.out.println("매칭테이블 비어있음");
//			int resultCnt = dao.insertMatch(match);	
//			match = dao.selectMatch(postidx, match.getMentee_idx(), match.getMentor_idx());
//			System.out.println("매칭테이블저장 또는 가져오기성공");
//		}
//		
//		return resultCnt;
//	}
	
	// 채팅발송시 받을 사람 idx구해서 보내기
//	public int getRecieverIdx(int myIdx) {
//		
//		//매치테이블에서 menteeidx==내idx와 같다면 seder(나)는 menteeidx일 것이고,
//		//reciever(상대방)는 mentoridx일 것.
//		//이 외는 그 반대일 것이다!
//		Match match;
//		int recieverIdx = 0;
//		
//		if(match.getMentee_idx()==myIdx) {
//			recieverIdx = match.getMentor_idx();
//		}else {
//			recieverIdx = match.getMentee_idx();
//		}
//		return recieverIdx;
//	}
	
	
	// insertChatt 메소드가 필요하다
	public int insertChatDB(Chat chat) {
		
		//시간처리필요
		int resultCnt = dao.insertChat(chat);
		
		return resultCnt;
	}
	
	
	
}
