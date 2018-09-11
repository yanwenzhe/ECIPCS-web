package com.controller.header;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/header/")
public class Header {
    @RequestMapping("/UI")
    public String ui(){
        return "/header/header";
    }

    @RequestMapping("/test")
    public String test(){
        return "/header/headerTest";
    }
}
