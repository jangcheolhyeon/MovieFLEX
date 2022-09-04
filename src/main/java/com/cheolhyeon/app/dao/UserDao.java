package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class UserDao {
    @Autowired
    SqlSession session;

    String namespace = "com.cheolhyeon.app.user.";

    public int insert(User user) throws Exception{
        return session.insert(namespace + "insert", user);
    }

    public User select(Map map) throws Exception{
        return session.selectOne(namespace + "select", map);
    }

    public int selectId(String id) throws Exception{
        return session.selectOne(namespace + "selectId", id);
    }

    public int selectEmail(String email) throws Exception{
        return session.selectOne(namespace + "selectEmail", email);
    }

    public int selectPhone(String phone) throws Exception{
        return session.selectOne(namespace + "selectPhone", phone);
    }
    public int updatePwd(User user) throws Exception{
        return session.update(namespace + "updatePwd", user);
    }


}
