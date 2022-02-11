package com.fitshare.backend.api.controller;

import com.fitshare.backend.api.request.ChatReq;
import com.fitshare.backend.api.request.PrivateChatReq;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class ChatController {

    private final SimpMessagingTemplate messagingTemplate;

    // 쇼핑룸 내 단체 메시지 전송
    @MessageMapping("/rooms/{roomId}")
    public ChatReq sendBroadcastMessage(ChatReq chatReq) {
        return chatReq;
    }

    // 개인 메시지 전송
    @MessageMapping("/messages")
    public void sendPrivateMessage(PrivateChatReq privateChatReq) {
        messagingTemplate.convertAndSendToUser(privateChatReq.getReceiverId(), "/queue/messages", privateChatReq);
    }
}
