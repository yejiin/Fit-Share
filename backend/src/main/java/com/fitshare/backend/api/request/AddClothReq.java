package com.fitshare.backend.api.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@ApiModel("AddClothRequest")
@Getter
@Setter
@AllArgsConstructor
public class AddClothReq {

    @ApiModelProperty(name = "쇼핑룸 Id", example = "1")
    private Long ShoppingRoomId;


    @ApiModelProperty(name = "옷 이미지 url", example = "https://xxx.jpg")
    private String imageUrl;
    
}
