package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.MakeShoppingRoomReq;
import com.fitshare.backend.api.response.MakeShoppingRoomRes;
import com.fitshare.backend.common.exception.MemberNotFoundException;
import com.fitshare.backend.common.exception.ShoppingMallNotFoundException;
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

@Service
public class ShoppingRoomServiceImpl implements ShoppingRoomService {

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
    private Map<Long, Map<String, OpenViduRole>> mapSessionNamesTokens = new ConcurrentHashMap<>();

    public ShoppingRoomServiceImpl(MemberRepository memberRepository, ShoppingRoomRepository shoppingRoomRepository, ShoppingMallRepository shoppingMallRepository,
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

    @Transactional
    @Override
    public MakeShoppingRoomRes makeShoppingRoom(Long memberId, MakeShoppingRoomReq req) {
        MakeShoppingRoomRes res = new MakeShoppingRoomRes();

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

        String token = "";
        try {
            // openvidu 세션 생성
            Session session = this.openVidu.createSession();

            // 세션 입장 토큰 생성
            token = session.createConnection(getConnectionProperties(OpenViduRole.PUBLISHER)).getToken();

            // 쇼핑룸 정보 DB 저장
            shoppingRoomRepository.save(shoppingRoom);
            // host member 를 참여자 DB 저장
            roomParticipantRepository.save(
                    RoomParticipant
                            .builder()
                            .member(member).shoppingRoom(shoppingRoom)
                            .build()
            );

            // openvidu 세션, 토큰 저장
            this.mapSessions.put(shoppingRoom.getId(), session);
            this.mapSessionNamesTokens.put(shoppingRoom.getId(), new ConcurrentHashMap<>());
            this.mapSessionNamesTokens.get(shoppingRoom.getId()).put(token, OpenViduRole.PUBLISHER);


        } catch (OpenViduJavaClientException | OpenViduHttpException e) {
            e.printStackTrace();
        }

        res.setShoppingRoomId(shoppingRoom.getId());
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
}
