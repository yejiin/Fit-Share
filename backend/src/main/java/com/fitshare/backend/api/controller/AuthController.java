package com.fitshare.backend.api.controller;


import com.fitshare.backend.api.response.LoginRes;
import com.fitshare.backend.api.service.AuthService;
import com.fitshare.backend.api.service.MemberService;
import com.fitshare.backend.common.model.BaseResponseBody;
import com.fitshare.backend.common.model.KakaoProfile;
import com.fitshare.backend.common.model.NaverProfile;
import com.fitshare.backend.common.model.RoleType;
import com.fitshare.backend.db.entity.Member;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

import static com.fitshare.backend.common.model.ResponseMessage.GET_ACCESS_TOKEN;
import static com.fitshare.backend.common.model.ResponseMessage.LOGIN;
import static org.springframework.security.config.Elements.LOGOUT;


@Api(value = "소셜 로그인 API", tags = "Auth")
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;
    private final MemberService memberService;

    @GetMapping(value="/kakao/token")
    @ApiOperation(value = "카카오 토큰 요청", notes = "카카오 인가 코드로 액세스 토큰을 요청하는 api입니다.")
    public ResponseEntity<BaseResponseBody> requestToken(@RequestParam String code){
        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.OK,GET_ACCESS_TOKEN, authService.getKakaoAccessToken(code)));
    }

    @GetMapping(value = "/kakao/login")
    @ApiOperation(value = "카카오 로그인", notes = "카카오 액세스 토큰으로 유저 정보를 받아 jwt 토큰을 발급하고 전송하는 api입니다.")
    public ResponseEntity<BaseResponseBody> login(@RequestParam String accessToken){
        // 1. access token으로 유저 정보 받아오기
        KakaoProfile kakaoProfile = authService.getKakaoUserInfo(accessToken);
        System.out.println(kakaoProfile.toString());

        // 2. DB에서 카카오회원번호로 회원 정보 불러오기
        String uid = Long.toString(kakaoProfile.getId());

        Optional<Member> member = memberService.findMemberByUid(uid);

        // 3. 없으면 DB에 저장
        if(member == null)
           member = Optional.ofNullable(memberService.createKakaoMember(kakaoProfile));

        // 4. JWT token 발급
        String jwt = authService.createToken(member.get().getId(), RoleType.USER);

        LoginRes loginRes = new LoginRes(member.get().getId(), jwt, member.get().getName(), member.get().getProfileImg());

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.CREATED, LOGIN, loginRes));
    }

    @GetMapping(value = "/kakao/logout")
    @ApiOperation(value = "카카오 로그아웃",notes = "토큰을 만료 시킨 후 로그아웃한다.")
    public ResponseEntity<BaseResponseBody> logout(@RequestHeader("Authorization") String accessToken) {
        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.OK,LOGOUT));
    }

    @GetMapping(value="/naver/token")
    @ApiOperation(value = "네이버 토큰 요청", notes = "네이버 인가 코드로 액세스 토큰을 요청하는 api입니다.")
    public ResponseEntity<BaseResponseBody> requestNaverToken(
            @RequestParam(required = false) String code,
            @RequestParam(required = false) String state,
            @RequestParam(required = false) String error,
            @RequestParam(required = false) String error_description){

        if (error != null)
            throw new RuntimeException(error_description);

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.OK,GET_ACCESS_TOKEN, authService.getNaverAccessToken(code, state)));
    }

    @GetMapping(value = "/naver/login")
    @ApiOperation(value = "네이버 로그인", notes = "네이버 액세스 토큰으로 유저 정보를 받아 jwt 토큰을 발급하고 전송하는 api입니다.")
    public ResponseEntity<BaseResponseBody> naverLogin(@RequestParam String accessToken){

        NaverProfile naverProfile = authService.getNaverUserInfo(accessToken);

        String uid = naverProfile.getResponse().getId();

        Optional<Member> member = memberService.findMemberByUid(uid);

        if(member == null)
            member = Optional.ofNullable(memberService.createNaverMember(naverProfile));

        String jwt = authService.createToken(member.get().getId(), RoleType.USER);

        return ResponseEntity.ok(BaseResponseBody.of(HttpStatus.CREATED, LOGIN, new LoginRes(member.get().getId(), jwt, member.get().getName(), member.get().getProfileImg())));
    }
}
