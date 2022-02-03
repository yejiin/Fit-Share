package com.fitshare.backend.db.repository;

import com.fitshare.backend.db.entity.Friend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FriendRepository extends JpaRepository<Friend, Long> {

    int countByMemberIdAndFriendId(Long memberId, Long friendId);

}
