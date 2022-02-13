package com.fitshare.backend.api.service;

public interface RedisService {

    void setData(String key, Object value);

    Object getData(String key);

    void delData(String key);

    void setDataExpire(String key, Object value, long duration);

    Long getExpire(String key);

}
