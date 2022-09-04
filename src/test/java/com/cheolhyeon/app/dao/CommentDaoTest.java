package com.cheolhyeon.app.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CommentDaoTest {
    @Autowired
    CommentDao dao;


    @Test
    public void selectAllCnt() throws Exception{
        assertTrue(dao.selectAllCnt() == 1);
    }
}