package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

/* 채팅 서버 구현 */
//해당 애너테이션으로 웹소켓 서버의 요청명을 지정하여, 해당 요청명으로 접속하는 클라이언트를 이 클래스가 처리하게 함.
// "ws://호스트:포트번호/컨텍스트루트/서버 요청명"으로 접속하면 됨.
@ServerEndpoint("/ChatingServer")
public class ChatServer {
	//Collections의 synchronizedSet 메서드는 멀티 스레드 환경에서도 안전한(thread-safe) Set 컬렉션을 생성해줌.
	//즉, 여러 클라이언트가 동시에 접속해도 문제가 생기지 않게 동기화한 것.
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen //클라이언트 접속 시 실행
	public void onOpen(Session session) {
		clients.add(session); //세션 추가
		System.out.println("웹소켓 연결: " + session.getId());
	}
	
	@OnMessage // 메시지를 받으면 실행
	public void onMessage(String message, Session session) 
				throws IOException {
		System.out.println("메시지 전송: " + session.getId() + ": " + message);
		//동기화 블록
		synchronized (clients) { //모든 클라이언트에게 메시지 전달
			for (Session client : clients) {
				if (!client.equals(session)) {
					//단, 메시지를 보낸 클라이언트에게는 제외하고 전달
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}
	
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("웹소켓 종료: "+  session.getId());
	}
	
	@OnError
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
	
	
}
