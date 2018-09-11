package com.controller.teacher;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import static com.utils.PageNameUtil.IMPORVEDRECORD;

@Controller
@RequestMapping("/teacher")
public class ImprovedRecord {


    @RequestMapping("/improvedRecord")
    public String improvedRecord(){

        return IMPORVEDRECORD;

    }

}
