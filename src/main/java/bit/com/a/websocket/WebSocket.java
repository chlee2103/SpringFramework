package bit.com.a.websocket;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 이 클래스가 서버가 된다.
public class WebSocket extends TextWebSocketHandler{
	
	
	// WebSocketSession : 저장공간
	// 서버는 각 클라이언트들의 주소를 다 알고 있어야 한다.
	// 클라이언트들을 모두 모으기 위해서 필요하다.				// ConcurrentHashMap : key, value에 null을 허용하지 않는 HashMap 
	private Map<String, WebSocketSession> userMap = new ConcurrentHashMap<String, WebSocketSession>();
				// id   , 주소?( WebSocket connection이 맺어진 세션 )
				// (id 예 : 9bb733da-2478-6831-af0a-1789e02f01ba)	
	public WebSocket() { // Echo : 메아리처럼 돌아온다.
		System.out.println("EchoHandler 생성됨 " + new Date());
	}
	
	// 클라이언트와 접속이 성공했을 때 자동호출된다.
	// 클라이언트들이 들어왔을 때마다 자동호출 된다.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결됨 : "+ session.getId() + " " + new Date());
		
		// Map에 추가 - 세션에 들어오는 id값을 스프링프레임워크가 알아서 다 가져온다.
		userMap.put(session.getId(), session); 
	}
	
	// 연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결종료 : "+ session.getId() + " " + new Date());
		userMap.remove(session.getId());
	}
	
	// 메세지(packet, 문자열)를 송(send)&수신(recv)하는 함수
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메세지가 언제 날라올 지 모르니 서버는 항상 받을 준비가 되있어야한다.
		// 수신(recv)
		System.out.println("메세지 수신:"+ message.getPayload()+ " "+ new Date());
		
		// 송신(send) - 접속되어 있는 모든 클라이언트에게 전송
		// 서버는 보태지 않고 바로 날려 보낸다.
		for (WebSocketSession s : userMap.values()) {
			s.sendMessage(message);
		}
		
		/////// 특정클라이언트한테 보낼때 이부분을 더 구현해야 한다 ///////
	}
	
	// 에러가 발생했을 때
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println("예외 발생 : "+ session.getId() + " " + new Date());
	}
	
	
	
	
	
}
