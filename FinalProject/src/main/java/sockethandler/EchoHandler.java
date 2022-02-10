package sockethandler;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.alj.dream.post.domain.Chat;
import com.google.gson.Gson;


public class EchoHandler extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private Map<String, WebSocketSession> sessionMap = new HashMap<String, WebSocketSession>();

	@Autowired
	private ChatService service;
	


	// 채팅창에 들어왔을때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		String myIdx = (String) session.getAttributes().get("myidx");
		String myName = (String) session.getAttributes().get("myname");
		System.out.println("myidx>>>"+myIdx);
		System.out.println("myname>>"+myName);
		
		
		sessionMap.put(myIdx, session);								// 맵에 idx키에 세션저장
		
		logger.info("연결되었습니다", session.getId()+" : "+myName);		// 세션의아이디 가죠옴???? 어떻게??
		System.out.println(myIdx);
		System.out.println("채팅 참여자 : " + myName);						// 고유번호가 출력
	}

	
	// 채팅메세지 전달
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// chatDB에 저장할 데이터들
		int myIdx = (int) session.getAttributes().get("myidx");
		int matchIdx = (int) session.getAttributes().get("matchIdx");
		int recieverIdx = (int) session.getAttributes().get("reciever");		// 전달받을 상대방idx
		

		String myName = (String) session.getAttributes().get("myname");
		logger.info("{}로부터 {}를 전달받았습니다", myName, message.getPayload());		// 입력해서 sendMessage(웹소켓으로 메세지를 보내려던)에서 받은 메세지
		Gson gson = new Gson();
		Chat chat = gson.fromJson(message.getPayload(), Chat.class);
		System.out.println(chat);
		
		// chat객체에 데이터저장
		chat.setMatch_idx(matchIdx);
		chat.setM_sender(myIdx);
		chat.setM_reciever(recieverIdx);
		int result = service.insertChatDB(chat);	// DB에 chat데이터 저장하는 메소드실행
		
		
		WebSocketSession ws = sessionMap.get(recieverIdx); 	// 전달할 세션?
		
		// 전달 메세지
		TextMessage sendMsg = new TextMessage(gson.toJson(chat));
		
		ws.sendMessage(sendMsg);		// 상대방에 메세지 전달
		session.sendMessage(sendMsg);	//나에게 메세지전달
		
		// 보낼 때 컨트롤러에서 필요로하는 postidx랑 midx를 보내준다?
	}

	// 채팅창에 나갔을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	
		int myIdx = (int) session.getAttributes().get("sender");
		String myName = (String) session.getAttributes().get("myname");
		
		sessionMap.remove(myIdx);	// 나간 사람의 세션이 삭제
		
		logger.info("{} 창을 나감", myName);
		
		System.out.println("채팅창나감"+myName);
		
		
		
	}
	
	
}