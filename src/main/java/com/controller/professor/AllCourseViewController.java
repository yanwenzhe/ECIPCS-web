package com.controller.professor;


import com.dao.*;
import com.entity.*;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import net.sf.json.JSONObject;
import org.apache.xmlbeans.impl.xb.xsdschema.All;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("system/professor/")
public class AllCourseViewController {

    @Autowired
    private CourseDao courseDao;

    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;

    @Autowired
    private  IndexPointDao indexPointDao;

    @Autowired
    private RelatedTeacherCourseDao relatedTeacherCourseDao;

    @Autowired
    private TeacherDao teacherDao;

    /**
     * 跳转到查看所有课程界面
     */
    @RequestMapping("allCourse")
    public String manage(){
        return PageNameUtil.ALL_COURSE_VIEW;
    }

    @RequestMapping("getCourseByYearName")
    @ResponseBody
    public Object getCourseByYearName(@RequestBody JSONObject jsonObject){

        JSONObject obj = jsonObject.getJSONObject("data");

        String year=obj.getString("year");

        String name = obj.getString("courseName");

        System.out.println("year:"+year+" name:"+name);

        if (name=="") name=null;

        List<AllCourse> allCourses = new ArrayList<>();

        Course course = new Course(null,name,null,year);

        List<Course> courses = courseDao.getCourseByName(course);

        int count=1;
        for (Course c:courses
        ) {

            AllCourse allCourse = new AllCourse();

            allCourse.setId(count++);
            //System.out.println("编号"+count);

            //取得课程名
            allCourse.setName(c.getName());
            //System.out.println("课程名"+c.getName());

            allCourse.setDesc(c.getDescription());
            //System.out.println("课程描述"+c.getDescription());


            //通过课程id得到指标点课程表
            List<RelatedIndexPointCourse> relatedIndexPointCourses = relatedIndexPointCourseDao.getRelatedIndexPointCourse(new RelatedIndexPointCourse(null,null,c.getId(),0.0,null,0.0,null,null));

            String pointList = "";
            for (RelatedIndexPointCourse r:relatedIndexPointCourses
            ) {

                //通过指标点课程id得到指标点表
                List<IndexPoint>indexPoints = indexPointDao.getIndexPoint(new IndexPoint(r.getIndexPointId(),null,null,null,null,null));

                pointList += indexPoints.get(0).getPoint()+",";
            }
            // System.out.println("指标点"+pointList);

            String hello="";
            for(int j=0;j<pointList.length()-1;j++)
                hello+=pointList.charAt(j);

            allCourse.setPoints(hello);

            String teacherList="";
            RelatedTeacherCourse relatedTeacherCourse = new RelatedTeacherCourse(null,null,c.getId(),null,null,null,null);
            List<RelatedTeacherCourse> relatedTeacherCourse1 = relatedTeacherCourseDao.getRelatedTeacherCourse(relatedTeacherCourse);
            for (RelatedTeacherCourse re: relatedTeacherCourse1
            ) {
                Teacher teacher = new Teacher(re.getTeacherId(),null,null,null,null,null);
                List<Teacher> teachers = teacherDao.getTeacher(teacher);
                for (Teacher teaname:teachers
                ) {
                    if (relatedTeacherCourse1.size() == 1)
                        teacherList = teaname.getName();
                    else
                        teacherList += teaname.getName() + ",";

                }
            }
            String hello1="";
            for(int j=0;j<teacherList.length()-1;j++)
                hello1+=teacherList.charAt(j);

            //System.out.println("老师："+teacherList);
            allCourse.setTeachers(teacherList);

            allCourses.add(allCourse);

        }

        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("courseList",allCourses);
        return new AjaxMessge().Set(MsgType.Success,hashMap);

    }
}
