package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.BoardDto;
import com.cheolhyeon.app.domain.PageHandler;
import com.cheolhyeon.app.domain.SearchCondition;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDaoTest {
    @Autowired
    BoardDao dao;

    @Test
    public void boardAllCnt() throws Exception{
        System.out.println(dao);
        int boardCnt = dao.boardAllCnt();
        System.out.println(boardCnt);
    }

    @Test
    public void selectList() throws Exception{
        Map map = new HashMap();
        map.put("offset", 20);
        map.put("pageSize", 10);
        List<BoardDto> list = dao.selectList(map);

        for(BoardDto dto : list){
            System.out.println(dto);
        }
        assertTrue(list.size() == 10);

    }

    @Test
    public void selectOne() throws Exception{
        BoardDto boardDto = dao.selectOne(255);
        assertTrue(boardDto.getTitle().equals("title252"));

    }

    @Test
    public void deleteOne() throws Exception{
        int boardCnt = dao.boardAllCnt();
        assertTrue(boardCnt == 255);
        Map map = new HashMap();

        map.put("bno", 255);
        map.put("writer", "writer250");

        dao.deleteOne(map);
        boardCnt = dao.boardAllCnt();
        assertTrue(boardCnt == 254);

    }

    @Test
    public void insert() throws Exception{
        for(int i=0;i<253;i++){
            BoardDto boardDto = new BoardDto("title" + i, "content" + i, "writer" + i);
            dao.insert(boardDto);
        }
        System.out.println(dao.boardAllCnt());

    }

    @Test
    public void update() throws Exception{
        BoardDto boardDto = dao.selectOne(254);
        boardDto.setTitle("new Title");
        boardDto.setContent("new content");
        dao.update(boardDto);
        System.out.println(boardDto);
        assertTrue(boardDto.getTitle().equals("new Title"));


    }

    @Test
    public void increaseViewCnt() throws Exception{
        BoardDto boardDto = dao.selectOne(254);
        System.out.println(boardDto.getView_cnt());
        dao.increaseViewCnt(254);
        System.out.println(boardDto.getView_cnt());
    }

    @Test
    public void searchConditionResult1() throws Exception{
        SearchCondition sc = new SearchCondition(1, 15, "writer1", "W");
        List<BoardDto> list = dao.searchConditionResult(sc);

        for(BoardDto dto : list){
            System.out.println("dto = " + dto);
        }
        assertTrue(list.size() == 15);

    }

    @Test
    public void searchConditionResult2() throws Exception{
        SearchCondition sc = new SearchCondition(1, 15, "title1", "T");
        List<BoardDto> list = dao.searchConditionResult(sc);

        for(BoardDto dto : list){
            System.out.println("dto = " + dto);
        }
        assertTrue(list.size() == 15);

    }


    @Test
    public void searchConditionCnt() throws Exception{
        SearchCondition sc = new SearchCondition(1, 15, "title2", "T");
        int cnt = dao.searchConditionCnt(sc);

        System.out.println("cnt = " + cnt);
    }

    @Test
    public void increaseCommentCnt() throws Exception{
        dao.increaseCommentCnt(1, 1);
        assertTrue(dao.selectOne(1).getComment_cnt() == 1);
    }
}