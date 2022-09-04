package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.KakaoUser;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class KakaoUserDaoTest {
    @Autowired
    private KakaoUserDao kakaoUserDao;

    @Test
    public void selectKakaoAll() throws Exception{
        assertTrue(kakaoUserDao.selectKakaoAll() == 0);
    }

    @Test
    public void selectKakao() throws Exception{
        Map map = new HashMap();
        map.put("k_name", "장철현");
        map.put("k_email", "wkdcjfgus000@naver.com");
        System.out.println(map);
        KakaoUser user1 = kakaoUserDao.selectKakao(map);

        assertTrue(user1.getK_name().equals("장철현"));
    }

    @Test
    public void insert() throws Exception{
        Map map = new HashMap();
        map.put("k_name", "장철현");
        map.put("k_email", "wkdcjfgus000@naver.com");
        int rowCnt = kakaoUserDao.insert(map);
        assertTrue(rowCnt == 1);

    }

}