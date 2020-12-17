package com.stu.websocket.demo.controller;

import com.stu.websocket.demo.websocket.WebSocketServer;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author yousj
 * @since 2020/12/16
 */
@Controller
public class LoginController {

    @RequestMapping("/login")
    public ModelAndView login(String username) throws Exception {
        if (WebSocketServer.sessionPools.get(username) != null) {
            throw new Exception("对不起, 当前用户已连接.");
        }
        ModelAndView mv = new ModelAndView("index");
        mv.addObject("username", username);
        return mv;
    }

}
