package com.controller.professor;


import com.utils.PageNameUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("system/professor/")
public class AllCourseViewController {

    /**
     * 跳转到查看所有课程界面
     */
    @RequestMapping("allCourse")
    public String manage(){
        return PageNameUtil.ALL_COURSE_VIEW;
    }
}
