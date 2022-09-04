package com.cheolhyeon.app.controller;

import com.cheolhyeon.app.domain.CommentDto;
import com.cheolhyeon.app.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CommentController {
    @Autowired
    private CommentService service;

    @GetMapping("/commentView")
    public String view(Integer bno, Model m, HttpSession session){
        String writer = (String) session.getAttribute("id");
        System.out.println("commentView의 메소드 bno = " + bno);
        m.addAttribute("bno", bno);
        m.addAttribute("writer", writer);
        return "commentView";
    }

    @GetMapping("/comments/{bno}")
    @ResponseBody
    public ResponseEntity<List<CommentDto>> list(@PathVariable Integer bno){
        List<CommentDto> list = null;
        System.out.println("bno = "+ bno);
        try{
            list = service.selectList(bno);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK);
        } catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST);

        }
    }

    @DeleteMapping("/comments/{cno}") //comments/1 -> 1번삭제
    @ResponseBody
    public ResponseEntity<String> delete(@PathVariable Integer cno, Integer bno, HttpSession session){
//        String commenter = (String) session.getAttribute("id");
        String commenter = "cheolhyeon";

        System.out.println("cno = " + cno + " bno = " + bno);
        try{
            if(service.remove(cno, commenter, bno) != 1) throw new Exception("remove return is not 1");
            return new ResponseEntity<>("delete ok", HttpStatus.OK);
        } catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("delete fail", HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/comments") // comments
    @ResponseBody
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto, HttpSession session){
//        String commenter = (String) session.getAttribute("id");
        String commenter = "cheolhyeon";
        commentDto.setCommenter(commenter);
        System.out.println("commentDto = "+ commentDto);
        try{
            if(service.write(commentDto) != 1) throw new Exception("write return is not 1");
            return new ResponseEntity<>("post ok", HttpStatus.OK);
        } catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("post fail", HttpStatus.BAD_REQUEST);
        }
    }

    @PatchMapping("/comments/{cno}")
    @ResponseBody
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto commentDto, HttpSession session){
//        String commenter = (String) session.getAttribute("id");
//        commentDto.setCommenter(commenter);

        String commenter = "cheolhyeon";
        commentDto.setCommenter(commenter);
        commentDto.setCno(cno);
        System.out.println("CommentDto = " + commentDto);
        try{
            if(service.modify(commentDto) != 1) throw new Exception("modify return is not 1");
            return new ResponseEntity<>("modify ok", HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("modify Error", HttpStatus.BAD_REQUEST);
        }
    }



}
