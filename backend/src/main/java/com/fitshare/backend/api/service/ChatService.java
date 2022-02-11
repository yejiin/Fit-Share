package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.PrivateChatReq;
import com.fitshare.backend.db.entity.PrivateChat;

import java.time.LocalDateTime;
import java.util.List;

public interface ChatService {

    void addPrivateChat(Long memberId, PrivateChatReq privateChatReq);

    void checkChatByTime(LocalDateTime time);

    List<PrivateChat> getPrivateChatListByMembers(Long memberId, Long friendId);

}
