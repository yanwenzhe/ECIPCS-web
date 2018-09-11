package com.controller.teacher;


import com.dao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import static com.utils.PageNameUtil.COURSEVIEW;

@Controller
@RequestMapping("/teacher")
public class CourseViewController {

    @Autowired
    private CourseDao courseDao;

    @Autowired
    private RelatedTeacherCourseDao relatedTeacherCourseDao;

    @Autowired
    private StudentScoreDao studentScoreDao;

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private TeacherDao teacherDao;

    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;

    @RequestMapping("/courseView")
    public String courseView(){

        return COURSEVIEW;

    }
    @RequestMapping("/course")
    @ResponseBody
    public Object  result(@RequestParam(value = "year", required = false) String year,
                          HttpServletRequest request, ModelMap model){

        List<Object> result = new ArrayList<>();

        String user = "zhaoxiaolin";

        List<String>userid = teacherDao.getTeacherId(user,year);

        int count = 1;

        for (String item:userid
             ) {
            List<String>courseId = relatedTeacherCourseDao.getCourseId(item);
            for (String item2:courseId
                 ) {
                List<String>courseName = courseDao.getCourseName(item2);
                for (String item3:courseName
                     ) {
                    List<Object>row = new ArrayList<>();
                    row.add(count);
                    row.add(item3);
                    count++;
                    result.add(row);
                }
            }
        }

        return result;

    }

    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model){


        System.out.println("开始");
        String path = request.getSession().getServletContext().getRealPath("upload");
        String fileNameadd= file.getOriginalFilename();
        System.out.println(fileNameadd);
        String[] sourceStrArray = fileNameadd.split("\\.");
        String fileadd = sourceStrArray[sourceStrArray.length-1];
        System.out.println(fileadd);
        String fileName = "test." + fileadd;
        System.out.println(path);
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }

        //保存
        try {
            file.transferTo(targetFile);
            System.out.println(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("fileUrl", request.getContextPath()+"/upload/"+fileName);

        Object object = new Object();
        System.out.println(123);

        return COURSEVIEW;
    }
}
