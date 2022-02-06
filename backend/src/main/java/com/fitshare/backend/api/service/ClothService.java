package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.AddClothReq;
import com.fitshare.backend.api.request.ListClothesReq;
import com.fitshare.backend.api.response.ClothRes;

import java.util.List;

public interface ClothService {

    ClothRes addCloth(AddClothReq req);
    List<ClothRes> listClothes(ListClothesReq req);

}
