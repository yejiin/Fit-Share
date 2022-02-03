package com.fitshare.backend.api.controller;

import com.fitshare.backend.api.request.MakeShoppingRoomReq;
import com.fitshare.backend.api.service.ShoppingRoomService;
import com.fitshare.backend.common.model.BaseResponseBody;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static com.fitshare.backend.common.model.ResponseMessage.*;

@Api(value = "쇼핑룸 API", tags = {"Shopping Room"})
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/shopping-rooms")
public class ShoppingRoomController {

    private final ShoppingRoomService shoppingRoomService;

    @ApiOperation(value = "쇼핑룸 생성")
    @PostMapping("")
    public ResponseEntity<BaseResponseBody> makeShoppingRoom(@RequestBody MakeShoppingRoomReq req) {
        // TODO: 사용자 정보 얻기
        Long memberId = 1L;

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.CREATED, MAKE_SHOPPING_ROOM, shoppingRoomService.makeShoppingRoom(memberId, req)));
    }

    @ApiOperation(value = "쇼핑룸 입장")
    @GetMapping("/{shoppingRoomId}")
    public ResponseEntity<BaseResponseBody> enterShoppingRoom(@PathVariable Long shoppingRoomId) {
        // TODO: 사용자 정보 얻기
        Long memberId = 3L;

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.OK, ENTER_SHOPPING_ROOM, shoppingRoomService.enterShoppingRoom(memberId, shoppingRoomId)));
    }
}
