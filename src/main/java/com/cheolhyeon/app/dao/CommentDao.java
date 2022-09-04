package com.cheolhyeon.app.dao;

import com.cheolhyeon.app.domain.CommentDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CommentDao {
    @Autowired
    SqlSession session;

    String namespace = "com.cheolhyeon.app.domain.comment.";

    public int selectAllCnt() throws Exception{
        return session.selectOne(namespace + "selectAllCnt");
    }

    public CommentDto selectOne(Integer cno) throws Exception{
        return session.selectOne(namespace + "selectOne", cno);
    }

    public List<CommentDto> selectList(Integer bno) throws Exception{
        return session.selectList(namespace + "selectList", bno);
    }

    public int deleteOne(Map map) throws Exception{
        return session.delete(namespace + "deleteOne", map);
    }

    public int insert(CommentDto commentDto) throws Exception{
        return session.insert(namespace + "insert", commentDto);
    }

    public int update(CommentDto commentDto) throws Exception{
        return session.update(namespace + "update", commentDto);
    }
}
