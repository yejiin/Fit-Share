package com.fitshare.backend.api.controller;

import io.swagger.annotations.ApiOperation;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Log4j2
public class ChatController {
    @ApiOperation(value="채팅", notes="채팅 전송")
    @GetMapping("/chat")
    public String getChat() {
        log.info("@ChatController, chat GET()");

        return "chat";
    }
}
