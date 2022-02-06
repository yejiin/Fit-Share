package com.fitshare.backend.api.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@ApiModel("ListClothesRequest")
@Getter
@Setter
public class ListClothesReq {

    @ApiModelProperty(name = "쇼핑룸 Id", example = "1")
    private Long shoppingRoomId;

    @ApiModelProperty(name = "멤버 Id", example = "1")
    private Long memberId;

}
