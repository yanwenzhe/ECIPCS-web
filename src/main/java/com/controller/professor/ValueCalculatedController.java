package com.controller.professor;

import com.utils.PageNameUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("system/professor/")
public class ValueCalculatedController {

    /**
     * 跳转到毕业达成度计算界面
     */
    @RequestMapping("valueCalculated")
    public String manage(){
        return PageNameUtil.VALUE_CALCULATED;
    }
}
