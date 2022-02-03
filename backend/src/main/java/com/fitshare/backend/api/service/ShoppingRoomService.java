package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.MakeShoppingRoomReq;
import com.fitshare.backend.api.response.ShoppingRoomRes;

public interface ShoppingRoomService {
    ShoppingRoomRes makeShoppingRoom(Long memberId, MakeShoppingRoomReq req);
    ShoppingRoomRes enterShoppingRoom(Long memberId, Long shoppingRoomId);
}
