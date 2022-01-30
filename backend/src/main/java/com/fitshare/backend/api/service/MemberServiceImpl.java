package com.fitshare.backend.api.service;

import com.fitshare.backend.common.model.KakaoProfile;
import com.fitshare.backend.common.model.OAuthToken;
import com.fitshare.backend.db.entity.Member;
import com.fitshare.backend.db.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MemberServiceImpl implements MemberService  {

    @Autowired
    MemberRepository memberRepository;

    @Override
    public Member createMember(KakaoProfile kakaoProfile) {

        Member member = new Member();

        //카카오에서 받은 정보들로 회원 생성
        member.setUid(kakaoProfile.getId());
        member.setName(kakaoProfile.getKakao_account().getProfile().getNickname());
        member.setEmail(kakaoProfile.getKakao_account().getEmail());
        member.setProfileImg(kakaoProfile.getKakao_account().getProfile().getProfile_image_url());

        memberRepository.save(member);

        return member;
    }

    @Override
    public Optional<Member> findMemberByUid(Long uid) {

        Optional<Member> member = memberRepository.findByUid(uid);

        if(member.isPresent())
            return Optional.empty();

        return null;
    }
}
