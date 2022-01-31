package com.fitshare.backend.api.controller;


import com.fitshare.backend.api.service.MemberService;
import com.fitshare.backend.common.model.KakaoProfile;
import com.fitshare.backend.common.model.OAuthToken;
import com.fitshare.backend.common.auth.KakaoApiService;
import com.fitshare.backend.db.entity.Member;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.Optional;


@Api(value = "카카오 인증 API")
@RestController
@RequestMapping("/api/v1/kakao")
public class KakaoController {

    @Autowired
    KakaoApiService kakaoApiService;

    @Autowired
    MemberService memberService;

    @GetMapping(value = "/login")
    @ApiOperation(value = "카카오 로그인", notes = "인가코드 받고 카카오에 토큰을 요청합니다. 토큰 발급 후 받은 유저 정보를 토대로 로그인하는 API입니다.")
    public ModelAndView login(@RequestParam String code){

        // 1. 인가 코드로 카카오 access 토큰, refresh 토큰 받아오기
        OAuthToken oAuthToken = kakaoApiService.requestToken(code);

        // 2. 유저 정보 받아오기
        KakaoProfile kakaoProfile = kakaoApiService.requestUserInfo(oAuthToken);
        System.out.println(kakaoProfile.toString());

        // 3. DB에서 카카오회원번호로 회원 정보 불러오기
        Long uid = kakaoProfile.getId();
        System.out.println(uid);

        Optional<Member> member = memberService.findMemberByUid(uid);

        // 4. 없으면 DB에 저장
        if(null==member)
            memberService.createMember(kakaoProfile);

        // 5. redis에 refreshToken 저장


        ModelAndView mav = new ModelAndView();
        mav.setViewName("경로");
        mav.addObject("accessToken", oAuthToken.getAccess_token()); //토큰

        return mav;
    }


}
