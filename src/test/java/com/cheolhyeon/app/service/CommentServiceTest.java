package com.cheolhyeon.app.service;

import com.cheolhyeon.app.domain.CommentDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CommentServiceTest {
    @Autowired
    private CommentService service;

    @Test
    public void selectAllCnt() throws Exception {
        assertTrue(service.selectAllCnt() == 6);
    }

    @Test
    public void read() throws Exception{
        CommentDto commentDto = service.read(2);
        System.out.println(commentDto);
        assertTrue(commentDto.getCno() == 2);
        assertTrue(commentDto.getBno() == 1);

    }

    @Test
    public void selectList() throws Exception{
        List<CommentDto> list = service.selectList(1);

        for(CommentDto dto : list){
            System.out.println(dto);
        }

        assertTrue(list.size() == 5);
    }

    @Test
    public void remove() throws Exception{
        CommentDto commentDto = new CommentDto(3, null, "comment0", "commenter0");
        commentDto.setCno(7);
        assertTrue(service.remove(commentDto.getCno(), commentDto.getCommenter(), commentDto.getBno()) == 1);
    }

    @Test
    public void write() throws Exception{
        for(int i=0;i<4;i++){
            CommentDto commentDto = new CommentDto(3, null, "comment"+ i, "commenter" + i);
            assertTrue(service.write(commentDto) == 1);
        }


    }

    @Test
    public void modify() throws Exception{
        CommentDto commentDto = service.read(1);
        commentDto.setComment("summer");

        if(service.modify(commentDto) == 1);

    }
}