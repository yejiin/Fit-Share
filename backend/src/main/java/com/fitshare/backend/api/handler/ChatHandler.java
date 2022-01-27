package com.fitshare.backend.api.handler;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.List;

@Component
@Log4j2
public class ChatHandler extends TextWebSocketHandler {
    private static List<WebSocketSession> webSocketSessionList = new ArrayList<>();

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();

        log.debug("payload : " + payload);
        log.debug(session);

        sendMessageToAll(message);
    }

    /* Client가 접속 시 호출되는 메서드 */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("클라이언트 접속 " + session);

        // TODO: session 님이 접속하셨습니다 전송

        webSocketSessionList.add(session);
    }

    /* Client가 접속 해제 시 호출되는 메서드 */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        log.info("클라이언트 접속 해제 " + session);
        webSocketSessionList.remove(session);

        // TODO: session 님이 퇴장하셨습니다 전송
    }

    public void sendMessageToAll(TextMessage message) throws Exception {
        for (WebSocketSession session : webSocketSessionList) {
            session.sendMessage(message);
        }
    }
}
