package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.KakaoUser;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class KakaoUserDao {
    @Autowired
    private SqlSession session;

    String namespace = "com.cheolhyeon.app.domain.KakaoUser.";

    public int selectKakaoAll() throws Exception{
        return session.selectOne(namespace + "selectKakaoAll");
    }

    public KakaoUser selectKakao(Map map) throws Exception{
        return session.selectOne(namespace + "selectKakao", map);
    }

    public int insert(Map map) throws Exception{
        return session.insert(namespace + "insert", map);
    }

}
