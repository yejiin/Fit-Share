package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.AddClothReq;
import com.fitshare.backend.api.response.AddClothRes;

public interface ClothService {

    AddClothRes addCloth(AddClothReq req);

}
