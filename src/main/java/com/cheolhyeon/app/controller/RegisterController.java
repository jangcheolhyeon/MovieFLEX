package com.cheolhyeon.app.controller;

import com.cheolhyeon.app.domain.User;
import com.cheolhyeon.app.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller
@RequestMapping("/register")
public class RegisterController {
    final private UserService service;

    public RegisterController(UserService userService){
        this.service = userService;
    }


    @GetMapping("/add")
    public String register(Model m, User user){
        System.out.println("add메소드");
//        m.addAttribute("user", new User());
        return "registerForm";
    }

    @PostMapping("/show")
    public String show(@Valid User user, BindingResult result, Model m){
        System.out.println("show메소드 = " + user);
//        UserDto의 Validation 검증하기
        if(result.hasErrors()){
            System.out.println("register errors");
            return "registerForm";
        }

//        에러가 없이 넘어온 UserDto의 이메일, 아이디, 핸드폰번호 중복 체크
        try{
            if(service.checkId(user.getId()) != 0) return "registerForm";

            if(service.checkEmail(user.getEmail()) != 0){
                String msg = "이미 가입된 이메일입니다!";
                m.addAttribute("msg", msg);
                return "registerForm";
            }

            if(service.checkPhone(user.getPhone()) != 0){
                String msg = "이미 가입된 전화번호입니다!";
                m.addAttribute("msg", msg);
                return "registerForm";
            }

        } catch(Exception e){
            e.printStackTrace();
        }
        
//        위에 에러들을 다 통과하고 넘어온 친구 DB에 저장
        try {
            service.createId(user);
            m.addAttribute("user", user);
            System.out.println("show메소드 = " + user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println(user);

        return "showRegister";
    }

//    id값을 db에 찾아서 cnt = 0이면 없는 id고 1이면 있는 아이디
//    XHR을 통해 동적으로 찾음
    @GetMapping("/overlapCheck")
    @ResponseBody
    public int overlap(String id){
//        System.out.println("id값은 = " + id);
        int Cnt = 0;
        try{
           Cnt = service.checkId(id);
        }catch(Exception e){
            e.printStackTrace();
        }
        return Cnt;
    }

}
