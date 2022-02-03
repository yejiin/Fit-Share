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

    @Transactional
    @Override
    public void addFriend(FriendReq friendReq) throws RuntimeException {
        Long memberId = 1L;
        Long friendId = friendReq.getFriendId();

        // 친구를 요청한 사용자와 요청을 받은 사용자가 같을 경우 방지
        if (memberId == friendId) {
            throw new InvalidException(memberId, friendId);
        }

        // 이미 친구일 경우 중복 방지
        int friendCount = 0;
        friendCount += friendRepository.countByMemberIdAndFriendId(memberId, friendId);
        System.out.println("friendCount = " + friendCount);
        friendCount += friendRepository.countByMemberIdAndFriendId(friendId, memberId);
        System.out.println("friendCount = " + friendCount);

        if (friendCount > 0) {
            throw new DuplicateException(memberId, friendId);
        }

        Member member = memberRepository.findById(memberId).orElseThrow(() -> new MemberNotFoundException(memberId));
        Member target = memberRepository.findById(friendId).orElseThrow(() -> new MemberNotFoundException(friendId));
        Friend friend = new Friend(member, target);
        friendRepository.save(friend);
    }

    @Override
    public List<FriendRes> getFriendList() {
        return null;
    }

    @Override
    public List<FriendRes> getFriendListByEmail(String friendEmail) {
        return null;
    }

    @Transactional
    @Override
    public void deleteFriend(Long friendId) {
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
