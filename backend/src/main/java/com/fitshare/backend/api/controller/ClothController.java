package com.fitshare.backend.api.controller;

import com.fitshare.backend.api.request.AddClothReq;
import com.fitshare.backend.api.request.GetClothesByIdReq;
import com.fitshare.backend.api.service.ClothService;
import com.fitshare.backend.common.model.BaseResponseBody;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import static com.fitshare.backend.common.model.ResponseMessage.ADD_CLOTH;

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

}
