package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.MakeShoppingRoomReq;
import com.fitshare.backend.api.response.ShoppingRoomRes;
import com.fitshare.backend.common.exception.MemberNotFoundException;
import com.fitshare.backend.common.exception.ShoppingMallNotFoundException;
import com.fitshare.backend.common.exception.ShoppingRoomNotFoundException;
import com.fitshare.backend.db.entity.Member;
import com.fitshare.backend.db.entity.RoomParticipant;
import com.fitshare.backend.db.entity.ShoppingMall;
import com.fitshare.backend.db.entity.ShoppingRoom;
import com.fitshare.backend.db.repository.MemberRepository;
import com.fitshare.backend.db.repository.RoomParticipantRepository;
import com.fitshare.backend.db.repository.ShoppingMallRepository;
import com.fitshare.backend.db.repository.ShoppingRoomRepository;
import io.openvidu.java.client.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class ShoppingRoomServiceImpl_v1 implements ShoppingRoomService {

    private MemberRepository memberRepository;
    private ShoppingRoomRepository shoppingRoomRepository;
    private ShoppingMallRepository shoppingMallRepository;
    private RoomParticipantRepository roomParticipantRepository;

    // openvidu 객체
    private OpenVidu openVidu;

    // openvidu server 관련 변수
    private String OPENVIDU_URL;
    private String SECRET;

    // openvidu 세션 정보 저장
    private Map<Long, Session> mapSessions = new ConcurrentHashMap<>();

    // openvidu 세션 참여자 정보 저장
    private Map<Long, Map<String, Member>> mapSessionNamesTokens = new ConcurrentHashMap<>();

    public ShoppingRoomServiceImpl_v1(MemberRepository memberRepository, ShoppingRoomRepository shoppingRoomRepository, ShoppingMallRepository shoppingMallRepository,
                                      RoomParticipantRepository roomParticipantRepository,
                                      @Value("${openvidu.url}") String openviduUrl, @Value("${openvidu.secret}") String secret) {
        this.memberRepository = memberRepository;
        this.shoppingRoomRepository = shoppingRoomRepository;
        this.shoppingMallRepository = shoppingMallRepository;
        this.roomParticipantRepository = roomParticipantRepository;

        this.OPENVIDU_URL = openviduUrl;
        this.SECRET = secret;
        this.openVidu = new OpenVidu(OPENVIDU_URL, SECRET);
    }

    /**
     * 쇼핑룸 생성
     **/
    @Transactional
    @Override
    public ShoppingRoomRes makeShoppingRoom(Long memberId, MakeShoppingRoomReq req) {
        ShoppingRoomRes res = new ShoppingRoomRes();

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new MemberNotFoundException(memberId));

        ShoppingRoom shoppingRoom = ShoppingRoom.builder()
                .host(member)
                .participantCount(req.getParticipantCount())
                .isPrivate(req.isPrivate())
                .isCustomShoppingMall(req.isCustomShoppingMall())
                .isActive(true)
                .build();

        // 쇼핑몰 정보 등록
        if (req.isCustomShoppingMall()) {  // 쇼핑몰 직접 입력했을 경우
            shoppingRoom.setShoppingMallName(req.getShoppingMallName());
            shoppingRoom.setShoppingMallUrl(req.getShoppingMallUrl());

            res.setShoppingRoomName(req.getShoppingMallName());
            res.setShoppingRoomUrl(req.getShoppingMallUrl());
        } else {  // DB에 있는 쇼핑몰을 사용할 경우
            ShoppingMall shoppingMall = shoppingMallRepository.findById(req.getShoppingMallId())
                    .orElseThrow(() -> new ShoppingMallNotFoundException(req.getShoppingMallId()));
            shoppingRoom.setShoppingMall(shoppingMall);

            res.setShoppingRoomName(shoppingRoom.getShoppingMallName());
            res.setShoppingRoomUrl(shoppingRoom.getShoppingMallUrl());
        }

        // 비밀방인 경우 비밀번호 등록
        if (req.isPrivate())
            shoppingRoom.setPassword(req.getPassword());

        String token = getSessionToken(OpenViduRole.PUBLISHER, shoppingRoom.getId(), member);

        // 쇼핑룸 정보 DB 저장
        shoppingRoomRepository.save(shoppingRoom);
//        // host member 를 참여자 DB 저장
//        roomParticipantRepository.save(
//                RoomParticipant
//                        .builder()
//                        .member(member).shoppingRoom(shoppingRoom)
//                        .build()
//        );

        res.setShoppingRoomId(shoppingRoom.getId());
        res.setToken(token);
        return res;
    }

    /**
     * 쇼핑룸 입장
     **/
    @Transactional
    @Override
    public ShoppingRoomRes enterShoppingRoom(Long memberId, Long shoppingRoomId) {

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new MemberNotFoundException(memberId));
        ShoppingRoom shoppingRoom = shoppingRoomRepository.findById(shoppingRoomId).orElseThrow(() -> new ShoppingRoomNotFoundException(shoppingRoomId));

        String token = getSessionToken(OpenViduRole.SUBSCRIBER, shoppingRoomId, member);

        // 참여자 DB 저장
//        roomParticipantRepository.save(
//                RoomParticipant
//                        .builder()
//                        .member(member).shoppingRoom(shoppingRoom)
//                        .build()
//        );

        ShoppingRoomRes res = new ShoppingRoomRes();

        if (shoppingRoom.getIsCustomShoppingMall()) {
            res.setShoppingRoomName(shoppingRoom.getShoppingMallName());
            res.setShoppingRoomUrl(shoppingRoom.getShoppingMallUrl());
        } else {
            ShoppingMall shoppingMall = shoppingMallRepository.findById(shoppingRoom.getShoppingMall().getId())
                    .orElseThrow(() -> new ShoppingMallNotFoundException(shoppingRoom.getShoppingMall().getId()));
            res.setShoppingRoomName(shoppingMall.getName());
            res.setShoppingRoomUrl(shoppingMall.getUrl());
        }
        res.setShoppingRoomId(shoppingRoomId);
        res.setToken(token);

        return res;
    }

    // openvidu 세션 속성 설정
    private ConnectionProperties getConnectionProperties(OpenViduRole role) {
        return new ConnectionProperties.Builder()
                .type(ConnectionType.WEBRTC)
                .role(role)
                .build();
    }
    
    private String getSessionToken(OpenViduRole role, Long shoppingRoomId, Member member) {
        String token = "";
        try {
            Session session = null;
            // 쇼핑룸 호스트인 경우 openvidu 세션 생성
            if (role.equals(OpenViduRole.PUBLISHER)) {

                session = this.openVidu.createSession();

                // 세션 저장
                this.mapSessions.put(shoppingRoomId, session);
                this.mapSessionNamesTokens.put(shoppingRoomId, new ConcurrentHashMap<>());
            } else {
                session = this.mapSessions.get(shoppingRoomId);
            }

            // 세션 입장 토큰 생성
            token = session.createConnection(getConnectionProperties(role)).getToken();

            // 토큰 저장
            this.mapSessionNamesTokens.get(shoppingRoomId).put(token, member);
        } catch (OpenViduJavaClientException | OpenViduHttpException e) {
            e.printStackTrace();
        }
        return token;
    }
}
