package com.fitshare.backend.api.service;

import com.fitshare.backend.db.entity.PrivateChat;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.*;
import org.springframework.stereotype.Service;

import java.time.*;

@Service
@RequiredArgsConstructor
public class RedisServiceImpl implements RedisService {
    private final static long EXPIRE_TIME = 3600L * 24 * 30; // 30일

    private final RedisTemplate<String, Object> redisTemplate;

    // 키-벨류 설정
    public void setData(String key, Object value) {
        if (value instanceof String) {
            ValueOperations<String, Object> values = redisTemplate.opsForValue();
            values.set(key, value, Duration.ofSeconds(EXPIRE_TIME));
        } else if (value instanceof PrivateChat) {
            // key : chat_senderId_receiverId_createdTime
            String createdTime = LocalDateTime.now().toString();
            key = key + "_" + createdTime;

            redisTemplate.expire(key, getSecondsUntilTomorrow());
            HashOperations<String, Object, Object> hashOperations = redisTemplate.opsForHash();

            PrivateChat privateChat = (PrivateChat) value;
            hashOperations.put(key, "sender_id", String.valueOf(privateChat.getSender().getId()));
            hashOperations.put(key, "receiver_id", String.valueOf(privateChat.getReceiver().getId()));
            hashOperations.put(key, "message", privateChat.getMessage());
            hashOperations.put(key, "created_time", createdTime);
        }
    }

    // 키값으로 벨류 가져오기
    public Object getData(String key) {
        ValueOperations<String, Object> values = redisTemplate.opsForValue();
        return values.get(key);
    }

    // 만료 기간 설정
    public void setDataExpire(String key, Object value, long duration) {
        ValueOperations<String, Object> values = redisTemplate.opsForValue();
        Duration expireDuration = Duration.ofSeconds(duration);
        values.set(key, value, expireDuration);
    }

    // 키-벨류 삭제
    public void delData(String key) {
        redisTemplate.delete(key);
    }


    // 만료 기간 가져오기
    public Long getExpire(String key) {
        return redisTemplate.getExpire(key);
    }

    // 다음날 정각까지 남은 시간을 초단위로 계산
    private Duration getSecondsUntilTomorrow() {
        LocalTime nowTime = LocalTime.now();
        LocalTime endTime = LocalTime.of(00, 00, 00);

        return Duration.between(endTime, nowTime);
    }
}
