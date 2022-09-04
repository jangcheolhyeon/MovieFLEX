package com.cheolhyeon.app.service;

import com.cheolhyeon.app.dao.BoardDao;
import com.cheolhyeon.app.domain.BoardDto;
import com.cheolhyeon.app.domain.SearchCondition;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardServiceTest {
    @Autowired
    BoardService service;

    @Autowired
    BoardDao boardDao;


    @Test
    public void boardAllCnt() throws Exception{
        System.out.println(service.boardAllCnt());
        assertTrue(service.boardAllCnt() == 254);
    }

    @Test
    public void selectList() throws Exception{
        List<BoardDto> list =  service.selectList(10, 20);
        for(BoardDto boardDto : list){
            System.out.println(boardDto);
        }

        assertTrue(list.size() == 20);
    }

    @Test
    public void read() throws Exception{
        BoardDto boardDto = service.read(254);
        System.out.println(boardDto);
        assertTrue(boardDto.getView_cnt() == 6);

    }

    @Test
    public void remove() throws Exception{
        int rowCnt = service.remove(256, "writer254");
        assertTrue(rowCnt == 1);
    }

    @Test
    public void write() throws Exception{
        BoardDto boardDto = new BoardDto("jnag title", " jang content", "jangcheolhyeon");
        int rowCnt = service.write(boardDto);
        assertTrue(rowCnt == 1);

    }

    @Test
    public void modify() throws Exception{
        BoardDto boardDto = boardDao.selectOne(257);
        boardDto.setTitle("jang title");
        int rowCnt = service.modify(boardDto);
        assertTrue(rowCnt == 1);
    }

    @Test
    public void searchConditionResult() throws Exception{
        SearchCondition sc = new SearchCondition(1, 15, "title3", "T");
        List<BoardDto> list = service.searchConditionResult(sc);

        for(BoardDto dto : list){
            System.out.println("dto = " + dto);
        }
    }

    @Test
    public void searchConditionCnt() throws Exception{
        SearchCondition sc = new SearchCondition(1, 10, "title3", "T");
        int cnt = service.searchConditionCnt(sc);

        System.out.println(cnt);
    }
}