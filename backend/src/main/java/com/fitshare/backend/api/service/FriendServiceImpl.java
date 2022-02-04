package com.fitshare.backend.api.service;

import com.fitshare.backend.api.request.FriendReq;
import com.fitshare.backend.api.response.FriendRes;
import com.fitshare.backend.common.exception.*;
import com.fitshare.backend.db.entity.Friend;
import com.fitshare.backend.db.entity.Member;
import com.fitshare.backend.db.repository.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@AllArgsConstructor
@Service
public class FriendServiceImpl implements FriendService {

    private MemberRepository memberRepository;
    private FriendRepository friendRepository;
    private FriendRequestRepository friendRequestRepository;

    // TODO: memberId JwtUtil에서 가져오기

    @Transactional
    @Override
    public void addFriend(FriendReq friendReq) {
        Long memberId = 1L;
        Long friendId = friendReq.getFriendId();

        // 친구를 요청한 사용자와 요청을 받은 사용자가 같을 경우 방지
        if (memberId.equals(friendId)) {
            throw new InvalidException(memberId, friendId);
        }

        // 이미 친구일 경우 중복 방지
        if (friendRepository.countByMemberIdAndFriendId(memberId, friendId) > 0) {
            throw new DuplicateException(memberId, friendId);
        }

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new MemberNotFoundException(memberId));
        Member friend = memberRepository.findById(friendId).orElseThrow(() -> new MemberNotFoundException(friendId));

        friendRepository.save(new Friend(member, friend));
        friendRepository.save(new Friend(friend, member));
    }

    @Override
    public List<FriendRes> getFriendList() {
        Long memberId = 1L;
        return friendRepository.findByMemberId(memberId);
    }

    @Override
    public List<FriendRes> getFriendListByEmail(String friendEmail) {
        Long memberId = 1L;
        return friendRepository.findByMemberIdAndFriendEmailLike(memberId, friendEmail);
    }

    @Transactional
    @Override
    public void deleteFriend(Long friendId) {
        Long memberId = 2L;

        // 친구 삭제를 요청한 사용자와 삭제할 사용자가 같을 경우 방지
        if (memberId.equals(friendId)) {
            throw new InvalidException(memberId, friendId);
        }

        int removeCount = 0;
        removeCount += friendRepository.removeByMemberIdAndFriendId(memberId, friendId);
        removeCount += friendRepository.removeByMemberIdAndFriendId(friendId, memberId);

        if (removeCount != 2) {
            throw new InvalidException(memberId, friendId);
        }
    }

    @Transactional
    @Override
    public void addFriendRequest(FriendReq friendReq) {
    }

    @Override
    public List<FriendRes> getFriendRequestList() {
        return null;
    }

    @Transactional
    @Override
    public void deleteFriendRequest(Long friendId) {
    }

}
