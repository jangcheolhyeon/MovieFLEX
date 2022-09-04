package com.cheolhyeon.app.controller;

import com.cheolhyeon.app.domain.KakaoUser;
import com.cheolhyeon.app.service.KakaoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/kakao")
public class KaKaoLoginController {
    private KakaoService kakaoService;

    public KaKaoLoginController(KakaoService kakaoService){
        this.kakaoService = kakaoService;
    }

    @GetMapping("/oauth")
    public String KakaoLogin(String code, HttpSession session) throws Exception{
        System.out.println("#################" + code);
        String access_Token = kakaoService.getAccessToken(code);
        System.out.println("### access_Token ### : " + access_Token);

        KakaoUser userInfo = kakaoService.getUserInfo(access_Token);
        System.out.println("### userInfo VO ### : " + userInfo);
        System.out.println("###email#### : " + userInfo.getK_email());
        System.out.println("###nickname#### : " + userInfo.getK_name());

        session.setAttribute("id", userInfo.getK_email());

        return "redirect:/";


    }

}
