package sockethandler;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.alj.dream.chat.dao.ChatDao;
import com.alj.dream.chat.domain.Chat;




public class ChatRoomService {
	
	private ChatDao dao;
	@Autowired 
	private SqlSessionTemplate template;


	public int insertChatting(Chat chat) {

		System.out.println("ChatRoomService : insertChatting메소드");
		
		dao = template.getMapper(ChatDao.class);
		
		int resultCnt = dao.insertChat(chat);
		
		//System.out.println("Chat_IDX>>>".concat(String.valueOf(chat.getChat_idx())));
		
		System.out.println("chatinsert성공");
	
		
		return resultCnt;
		
	}
	  
	
	
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
//	public int insertChatDB(Chat chat) {
//		
//		//시간처리필요
//		int resultCnt = dao.insertChat(chat);
//		
//		return resultCnt;
//	}
//	
	
	
}
