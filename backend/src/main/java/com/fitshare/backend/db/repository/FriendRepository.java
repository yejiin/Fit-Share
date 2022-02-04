package com.fitshare.backend.db.repository;

import com.fitshare.backend.api.response.FriendRes;
import com.fitshare.backend.db.entity.Friend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FriendRepository extends JpaRepository<Friend, Long> {

    int countByMemberIdAndFriendId(Long memberId, Long friendId);

    @Query(value = "SELECT NEW com.fitshare.backend.api.response.FriendRes" +
            "( f.friend.id, m.name, m.email, m.phone, m.profileImg, f.createdTime )" +
            "  FROM Friend f" +
            "  JOIN f.friend m" +
            " WHERE f.member.id = :memberId" +
            "   AND m.isActive = true" +
            " ORDER BY m.name")
    Optional<List<FriendRes>> findByMemberId(@Param("memberId") Long memberId);

    Optional<Friend> removeByMemberIdAndFriendId(Long memberId, Long friendId);

}
