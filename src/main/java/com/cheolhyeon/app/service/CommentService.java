package com.cheolhyeon.app.service;

import com.cheolhyeon.app.dao.BoardDao;
import com.cheolhyeon.app.dao.CommentDao;
import com.cheolhyeon.app.domain.CommentDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionalEventListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentService {
    final private CommentDao commentDao;
    final private BoardDao boardDao;

    public CommentService(CommentDao commentDao, BoardDao boardDao){
        this.commentDao = commentDao;
        this.boardDao = boardDao;
    }

    public int selectAllCnt() throws Exception{
        return commentDao.selectAllCnt();
    }


    public CommentDto read(Integer cno) throws Exception{
        return commentDao.selectOne(cno);
    }

    public List<CommentDto> selectList(Integer bno) throws Exception{
        return commentDao.selectList(bno);
    }


    //지웠을때 board에 있는 comment_cnt(댓글 갯수 세는거)의 칼럼도 영향을 받아야됨
    //원자성을 유지해야된다 그래서 Transactional 애너테이션을 씀
    @Transactional(rollbackFor = Exception.class)
    public int remove(Integer cno, String commenter, Integer bno) throws Exception{
        boardDao.increaseCommentCnt(bno, -1);
        Map map = new HashMap();
        map.put("cno", cno);
        map.put("commenter", commenter);
        return commentDao.deleteOne(map);
    }

    @Transactional(rollbackFor = Exception.class)
    public int write(CommentDto commentDto) throws Exception{
        boardDao.increaseCommentCnt(commentDto.getBno(), 1);
        return commentDao.insert(commentDto);
    }

    public int modify(CommentDto commentDto) throws Exception{
        return commentDao.update(commentDto);
    }


}
