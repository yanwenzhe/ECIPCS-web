package com.controller.teacher;


import com.dao.CourseDao;
import com.dao.StudentDao;
import com.dao.StudentScoreDao;
import com.entity.Colum;
import com.entity.Course;
import com.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.utils.PageNameUtil.GRADEREVIEW;

@Controller
@RequestMapping("/teacher")
public class GradeReview {

    @Autowired
    private CourseDao courseDao;

    @Autowired
    private StudentScoreDao studentScoreDao;

    @Autowired
    private StudentDao studentDao;

    @RequestMapping("/gradeReview")
    public String gradeReview(){

        return GRADEREVIEW;

    }

    @RequestMapping("/initialization")
    @ResponseBody
    public Object  initialization(){

        SimpleDateFormat df = new SimpleDateFormat("yyyy");//设置日期格式
        String date = df.format(new Date());
        Course selcourse = new Course(null,null,null,date);
        List<Course> courses = courseDao.getCourse(selcourse);
        return courses;

    }

    @RequestMapping("/change")
    @ResponseBody
    public Object  change(@RequestParam(value = "year", required = false) String year){

        Course selcourse = new Course(null,null,null,year);
        List<Course> courses = courseDao.getCourse(selcourse);
        return courses;

    }

    @RequestMapping("/check")
    @ResponseBody
    public Object  check(@RequestParam(value = "year", required = false) String year,
                         @RequestParam(value = "id", required = false) String id,
                         @RequestParam(value = "name", required = false) String name,
                         @RequestParam(value = "number", required = false) String number,
                         HttpServletRequest request, ModelMap model){

        try{
            name =  java.net.URLDecoder.decode(name,"utf-8").toString();
        }catch (Exception e){
            System.out.println(e);
        }



        List<String> colum = studentScoreDao.getColumName(id);

        List<Object> result = new ArrayList<>();

        Colum now = new Colum("考核形式","分配分数","指标点");

        result.add(now);

        for (String item:colum
             ) {
            Colum now2 = new Colum();
            now2.setForm(item);
            List<Double> score = studentScoreDao.getScore(id,item);
            double count = 0;
            String string1 = "";
            for (Double item2:score
                 ) {
                List<String> pointid = studentScoreDao.getPointid(id,item,item2);
                for (String item3:pointid
                     ) {
                    string1 = string1 + studentScoreDao.getPoint(item3).toString()+ " ";
                }
                count = count + item2;
            }
            now2.setScore(String.valueOf(count));
            now2.setPoint(string1);
            result.add(now2);
        }

        List<Object>header = new ArrayList<>();
        header.add("编号");
        header.add("姓名");
        header.add("学号");
        header.add("班级");

        List<Object> scoreExcel = new ArrayList<>();

        for (String item:colum
             ) {
            header.add(item);
        }

        scoreExcel.add(header);

        if(name == ""){
            name = null;
        }

        if(number == ""){
            number = null;
        }
        System.out.println(name);
        int count = 0;
        List<String> studentId = studentScoreDao.getStudentId(id);
        for (String item:studentId
             ) {
            count++;
            List<Object>stu = new ArrayList<>();
            Student student = new Student(item,number,name,null);
            List<Student>students = studentDao.getStudent(student);
            stu.add(count);
            for (Student item2:students
                 ) {
                stu.add(item2.getName());
                stu.add(item2.getSchoolNumber());
                stu.add(item2.getClassId());
                for (String item3:colum
                     ) {
                    List<Double>studentScore = studentScoreDao.getStuScore(id,item3,item);
                    double nowScore = 0;
                    for (double item4:studentScore
                         ) {
                       nowScore = nowScore + item4;
                    }
                    stu.add(nowScore);
                }
            }
            scoreExcel.add(stu);

            if (name!=null || number!=null){
                break;
            }
        }

        result.add(scoreExcel);


        return result;

    }


}
