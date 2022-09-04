package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.BoardDto;
import com.cheolhyeon.app.domain.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDao {
    @Autowired
    SqlSession session;

    String namespace = "com.cheolhyeon.app.board.";

    public int boardAllCnt() throws Exception{
        return session.selectOne(namespace + "boardAllCnt");
    }

    // map에다가 offset, pageSize값 주기
    public List<BoardDto> selectList(Map map) throws Exception{
        return session.selectList(namespace + "selectList", map);
    }

    public BoardDto selectOne(Integer bno) throws Exception{
        return session.selectOne(namespace+"selectOne", bno);
    }

    public int deleteOne(Map map) throws Exception{
        return session.delete(namespace + "deleteOne", map);
    }

    public int insert(BoardDto boardDto) throws Exception{
        return session.insert(namespace + "insertBoard", boardDto);
    }

    public int update(BoardDto boardDto) throws Exception{
        return session.update(namespace + "updateBoard", boardDto);
    }

    public int increaseViewCnt(Integer bno) throws Exception{
        return session.update(namespace + "increaseView_cnt", bno);
    }

    public List<BoardDto> searchConditionResult(SearchCondition sc) throws Exception{
        return session.selectList(namespace + "searchConditionList", sc);
    }

    public int searchConditionCnt(SearchCondition sc) throws Exception{
        return session.selectOne(namespace + "searchConditionCnt", sc);
    }

    public int increaseCommentCnt(Integer bno, Integer num) throws Exception{
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("num", num);
        return session.update(namespace + "increaseCommentCnt", map);
    }


}
