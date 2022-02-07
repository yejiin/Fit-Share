package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.ClothReq;
import com.fitshare.backend.api.request.ListClothesReq;
import com.fitshare.backend.api.response.ClothRes;

import java.util.List;

public interface ClothService {

    ClothRes addCloth(Long memberId,ClothReq req);

    List<ClothRes> listClothes(ListClothesReq req);

    void deleteCloth(Long clothId);

}
