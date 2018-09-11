package com.controller.professor;

import com.utils.PageNameUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("system/professor/")
public class ValueChartedController {

    /**
     * 跳转到图形化界面
     */
    @RequestMapping("valueChart")
    public String manage(){
        return PageNameUtil.VALUE_CHART;
    }
}
