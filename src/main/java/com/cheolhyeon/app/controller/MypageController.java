package com.cheolhyeon.app.controller;

import com.cheolhyeon.app.domain.User;
import com.cheolhyeon.app.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MypageController {

    private UserService service;

    public MypageController(UserService service){
        this.service = service;
    }


    @GetMapping("/mypage")
    public String myPage(HttpServletRequest request, Model m){
        HttpSession session = request.getSession();
        if(!isLogin(session)){
            String toURL = request.getRequestURI();
            m.addAttribute("toURL", toURL);

            return "redirect:/login/login";
        }

        String id = (String)session.getAttribute("id");
        m.addAttribute("id", id);

        return "mypage";
    }

    @PostMapping("/mypage")
    public String showUserInfo(User user, HttpSession session, Model m){
        String id = (String) session.getAttribute("id");
        user.setId(id);
        System.out.println(user);
        String pwd = user.getPassword();

        try{
            if(service.findAccount(id, pwd) == null || service.findAccount(id, pwd).equals("")) throw new Exception("pwd not equals!");

            user = service.findAccount(id, pwd);
        }catch(Exception e){
            e.printStackTrace();
            String msg = "비밀번호가 일치하지 않습니다!";
            m.addAttribute("error", msg);
            return "redirect:/mypage";
        }


        m.addAttribute("user", user);
        return "showMyInfo";
    }




    private boolean isLogin(HttpSession session) {
        if(session.getAttribute("id") == null || session.getAttribute("id").equals("")){
            return false;
        }

        return true;

    }
}
