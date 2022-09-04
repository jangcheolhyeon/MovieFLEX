package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDaoTest {
    @Autowired
    UserDao dao;

    @Test
    public void tesT(){
        System.out.println(dao);
    }

    @Test
    public void insert() throws Exception{
        for(int i=0;i<5;i++){
            User user = new User("id" + i, "pwd" + i, "name" + i, "email" + i + "@naver.com", "010-1234-567" + i, new Date());
            dao.insert(user);
        }

    }

    @Test
    public void select() throws Exception{
        Map map = new HashMap();
        map.put("id", "id1");
        map.put("password", "pwd1");
        User user = dao.select(map);
        System.out.println(user);
    }

    @Test
    public void checkId() throws Exception{
        int cnt = dao.selectId("dddd");
        assertTrue(cnt == 1);
        System.out.println(cnt);
        cnt = dao.selectId("asdfzcxv");
        assertTrue(cnt == 0);
        System.out.println(cnt);
        cnt = dao.selectId("id1234");
        assertTrue(cnt == 1);
        System.out.println(cnt);
    }

    @Test
    public void updatePwd() throws Exception{
        Map map = new HashMap();
        map.put("id", "asdf1234");
        map.put("password", "password");
        User user = dao.select(map);
        System.out.println(user);
        user.setPassword("1234");
        System.out.println(user);
        dao.updatePwd(user);
        System.out.println(user);
    }

    @Test
    public void selectEmail() throws Exception{
        int rowCnt = dao.selectEmail("wkdcjfgus000@naver.com");
        assertTrue(rowCnt == 1);
        rowCnt = dao.selectEmail("alsdnflsakndf@naver.com");
        assertTrue(rowCnt == 0);
    }

    @Test
    public void selectPhone() throws Exception{
        int rowCnt = dao.selectPhone("010-3854-3908");
        assertTrue(rowCnt == 1);
        rowCnt = dao.selectPhone("010-5555-5555");
        assertTrue(rowCnt == 0);
    }
}