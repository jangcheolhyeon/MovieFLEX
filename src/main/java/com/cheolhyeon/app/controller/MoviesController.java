package com.cheolhyeon.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/movies")
public class MoviesController {

    @GetMapping("/main")
    public String moviesMain(HttpServletRequest request, Model m){
        //로그인 안되면 redirect하기
        HttpSession session = request.getSession();
        if(!isLogin(session)){
            String toURL = request.getRequestURI();
            m.addAttribute("toURL", toURL);
            
//            redirect는 모델에 넣으면 파라미터로 안적어줘도 보내짐
            return "redirect:/login/login";
        }





        return "movies";
    }

    @GetMapping("/detail")
    public String showDetails(String title, Model m){
        System.out.println("title = " + title);
        m.addAttribute("title", title);

        return "movieInDetail";
    }

    private boolean isLogin(HttpSession session) {
        if(session.getAttribute("id") == null || session.getAttribute("id").equals("")){
            return false;
        }
        return true;
    }


}
