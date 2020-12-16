package com.stu.websocket.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author yousj
 * @since 2020/12/16
 */
@Controller
public class LoginController {

    @RequestMapping("/login")
    public ModelAndView  login(String username){
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("username",username);
        return mv;
    }

}
