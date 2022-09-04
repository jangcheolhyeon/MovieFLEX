package com.cheolhyeon.app.controller;

import com.cheolhyeon.app.domain.BoardDto;
import com.cheolhyeon.app.domain.PageHandler;
import com.cheolhyeon.app.domain.SearchCondition;
import com.cheolhyeon.app.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService service;

    @GetMapping("/list")
    public String boardList(HttpServletRequest request, SearchCondition sc, Model m){
        HttpSession session = request.getSession();
        if(!isLogin(session)) {
            String toURL = request.getRequestURI();
            m.addAttribute("toURL", toURL);

            return "redirect:/login/login";
        }

        try{
            //밑에 navi부분을 계산해주는 코드
//            int boardTotalCnt = service.boardAllCnt();
//            PageHandler ph = new PageHandler(boardTotalCnt, page);
//            m.addAttribute("ph", ph);
//            System.out.println("ph = " + ph);
//
//            //오프셋과 페이지 사이즈에 따라 계산된 페이징을 list로 만들어서 뷰로 보냄
//            List<BoardDto> list = service.selectList((page-1) * pageSize, pageSize);
//            m.addAttribute("list", list);

            System.out.println("sc = " + sc);
            int SearchResultCnt = service.searchConditionCnt(sc);
            PageHandler ph = new PageHandler(SearchResultCnt, sc);
            List<BoardDto> list = service.searchConditionResult(sc);


            m.addAttribute("ph", ph);
            m.addAttribute("list", list);

        } catch(Exception e){
            e.printStackTrace();
        }

        return "boardList";
    }

    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m, HttpServletRequest request) {
        System.out.println("read 메소드의 bno=" + bno + " page=" + page + " pageSize=" + pageSize);
//      세션 체크
        HttpSession session = request.getSession();
        if(!isLogin(session)) {
            String toURL = request.getRequestURI();
            m.addAttribute("toURL", toURL);

            return "redirect:/login/login";
        }



        try{
            BoardDto boardDto = service.read(bno);
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        }catch(Exception e){
            e.printStackTrace();
        }

        return "board";
    }

    @GetMapping("/remove")
    public String remove(Integer bno, String writer, HttpSession session, Model m){
        System.out.println("remove메소드 bno = " + bno + " writer = " + writer);
//        String writer = (String) session.getAttribute("id");
        try{
            if(service.remove(bno, writer) != 1) throw new Exception();
        } catch(Exception e){
            e.printStackTrace();
        }

        return "redirect:/board/list";
    }


    @GetMapping("/write")
    public String write(Model m){
        m.addAttribute("mode", "new");

        return "board";
    }

    @PostMapping("/write")
    public String write(BoardDto boardDto, HttpSession session, Model m){
        String writer = (String)session.getAttribute("id");
//        String writer = "jang";
        boardDto.setWriter(writer);
        System.out.println("write post 방식 boardDto = " + boardDto);
        try{
            if(service.write(boardDto) != 1) throw new Exception();

        }catch(Exception e){
            e.printStackTrace();
        }

        return "redirect:/board/list";
    }


    @PostMapping("/modify")
    public String modify(BoardDto boardDto){
        System.out.println("modify의 boardDto = " + boardDto);

        try{
            if(service.modify(boardDto) != 1) throw new Exception();
        }catch(Exception e){
            e.printStackTrace();
        }
        return "redirect:/board/list";
    }


    private boolean isLogin(HttpSession session) {
        if(session.getAttribute("id") == null || session.getAttribute("id").equals("")){
            return false;
        }
        return true;

    }
}
