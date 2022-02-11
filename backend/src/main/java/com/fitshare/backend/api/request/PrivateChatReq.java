package com.fitshare.backend.api.request;

import lombok.*;

@Getter
@Setter
public class PrivateChatReq extends ChatReq {

    private String receiverId;

}
