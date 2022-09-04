package com.cheolhyeon.app.controller;


import com.cheolhyeon.app.domain.User;
import com.cheolhyeon.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {
    private UserService service;

    @Autowired
    public LoginController(UserService userService){
        this.service = userService;
    }


    @GetMapping("/login")
    public String loginform(){
        return "loginForm";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }


    @PostMapping("/login")
    public String login(User user, boolean rememberId, HttpServletRequest request, HttpServletResponse response, String toURL){
        if(!checkId(user)){
            String msg = "id or pwd is not correct";
            return "redirect:/login/login?msg=" + msg;
        }

        //아이디 기억체크하면 쿠키 만들기
        if(rememberId){
            Cookie cookie = new Cookie("id", user.getId());
            response.addCookie(cookie);
        } else{
            Cookie cookie = new Cookie("id", null);
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }

        //로그인했을때 세션 만들기
        HttpSession session = request.getSession();
        session.setAttribute("id", user.getId());


        if(toURL == null || toURL.equals("")) return "index";

        System.out.println("toURL = " + toURL.substring(4));
        return "redirect:/" + toURL.substring(4);
    }

    
    //로그인 체크 로직
    private boolean checkId(User user) {
        String id = user.getId();
        String pwd = user.getPassword();

        System.out.println("id " + id + " pwd " + pwd);
        try{
            if(service.findAccount(id, pwd) == null || service.findAccount(id, pwd).equals("")) return false;

            return true;
        } catch(Exception e){
            e.printStackTrace();
            return false;
        }

    }
}
