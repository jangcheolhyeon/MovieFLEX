package com.cheolhyeon.app.service;

import com.cheolhyeon.app.dao.BoardDao;
import com.cheolhyeon.app.domain.BoardDto;
import com.cheolhyeon.app.domain.SearchCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {
    final private BoardDao boardDao;

    public BoardService(BoardDao boardDao){
        this.boardDao = boardDao;
    }


    public int boardAllCnt() throws Exception{
        return boardDao.boardAllCnt();
    }

    public List<BoardDto> selectList(Integer offset, Integer pageSize) throws Exception{
        Map map = new HashMap();
        map.put("offset", offset);
        map.put("pageSize", pageSize);

        return boardDao.selectList(map);
    }

    @Transactional
    public BoardDto read(Integer bno) throws Exception{
        boardDao.increaseViewCnt(bno);
        return boardDao.selectOne(bno);
    }

    public int remove(Integer bno, String writer) throws Exception{
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("writer", writer);
        return boardDao.deleteOne(map);
    }

    public int write(BoardDto boardDto) throws Exception{
        return boardDao.insert(boardDto);
    }

    public int modify(BoardDto boardDto) throws Exception{
        return boardDao.update(boardDto);
    }

    public List<BoardDto> searchConditionResult(SearchCondition sc) throws Exception{
        return boardDao.searchConditionResult(sc);
    }

    public int searchConditionCnt(SearchCondition sc) throws Exception{
        return boardDao.searchConditionCnt(sc);
    }


}
