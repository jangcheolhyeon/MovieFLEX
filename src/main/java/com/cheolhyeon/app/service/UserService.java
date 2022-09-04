package com.cheolhyeon.app.service;

import com.cheolhyeon.app.dao.UserDao;
import com.cheolhyeon.app.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    final private UserDao userDao;

    @Autowired // 생성자가 단일생성자인 경우 Autowired생략가능
    public UserService(UserDao userdao){
        this.userDao = userdao;
    }

    public int createId(User user) throws Exception{
        return userDao.insert(user);
    }

    public User findAccount(String id, String password) throws Exception{
        Map map = new HashMap();
        map.put("id", id);
        map.put("password", password);

        return userDao.select(map);
    }

    public int checkId(String id) throws Exception{
        return userDao.selectId(id);
    }

    public int checkEmail(String email) throws Exception{
        return userDao.selectEmail(email);
    }

    public int checkPhone(String phone) throws Exception{
        return userDao.selectPhone(phone);
    }

    public int changePwd(User user) throws Exception{
        return userDao.updatePwd(user);
    }

}
