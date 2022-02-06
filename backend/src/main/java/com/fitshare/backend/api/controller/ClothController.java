package com.fitshare.backend.api.controller;

import com.fitshare.backend.api.request.AddClothReq;
import com.fitshare.backend.api.service.ClothService;
import com.fitshare.backend.common.model.BaseResponseBody;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static com.fitshare.backend.common.model.ResponseMessage.ADD_CLOTH;
import static com.fitshare.backend.common.model.ResponseMessage.GET_CLOTHES_LIST;

@Api(value = "옷장 API", tags = {""})
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/clothes")
public class ClothController {

    private final ClothService clothService;

    @PostMapping("")
    @ApiOperation(value = "옷 추가",notes = "입력받은 옷 정보를 DB에 추가하는 API입니다.")
    public ResponseEntity<BaseResponseBody> addCloth(@RequestBody AddClothReq req) {

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.CREATED, ADD_CLOTH,clothService.addCloth(req)));
    }

//    // 쇼핑룸 아이디, 멤버 아이디
//    @PostMapping("/list")
//    @ApiOperation(value = "옷 리스트", notes = "참가자 별 옷 목록을 반환하는 API입니다.")
//    public ResponseEntity<BaseResponseBody> listClothes(@RequestParam Long memberId) {
//
//        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.OK,GET_CLOTHES_LIST,clothService.listClothes(memberId)));
//    }
}
