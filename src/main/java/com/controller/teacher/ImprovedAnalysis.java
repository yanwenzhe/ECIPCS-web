package com.controller.teacher;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import static com.utils.PageNameUtil.IMPORVEDANALUSIS;

@Controller
@RequestMapping("/teacher")
public class ImprovedAnalysis {

    @RequestMapping("/improvedAnalysis")
    public String improvedAnalysis(){

        return IMPORVEDANALUSIS;

    }

}
