package com.controller.professor;


import com.dao.CourseDao;
import com.dao.IndexPointDao;
import com.dao.RelatedIndexPointCourseDao;
import com.dao.RelatedIndexPointCourseTeacherDao;
import com.entity.Course;
import com.entity.IndexPoint;
import com.entity.RelatedIndexPointCourse;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import net.sf.json.JSONObject;
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
public class ManageCourseController {

    @Autowired
    private IndexPointDao indexPointDao;
    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;
    @Autowired
    private CourseDao courseDao;

    /**
     * 跳转管理课程界面
     */
    @RequestMapping("manageCourse")
    public String manage(){
        return PageNameUtil.MANAGE_COURSE;
    }


    @RequestMapping("getIndexPointCourse")
    @ResponseBody
    public Object getIndexPointCourse(@RequestBody JSONObject jsonObject)
    {
        HashMap<String ,Object> hashMap=new HashMap<>();
        // hashMap.put("list",list);
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

    /**
     * 选择年份之后，返回指标点列表
     * @param year
     * @return
     */
    @RequestMapping("getIndexPointList")
    @ResponseBody
    public Object getIndexPointList(@RequestParam("year") String year){
        if(year=="")year = null;
        //System.out.println(year);
        IndexPoint indexPoint = new IndexPoint(null,null,null,year,null,null);
        List<IndexPoint> indexPoints = indexPointDao.getIndexPoint(indexPoint);
        //System.out.println("谢斌辉"+indexPoints);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("indexPointList",indexPoints);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

    /**
     * 通过年份查看课程
     * @param year
     * @return
     */
    @RequestMapping("getIndexPointCourseByYear")
    @ResponseBody
    public Object getIndexPointCourseByYear(@RequestParam("year") String year)
    {
        if(year=="")year=null;
        IndexPoint indexPoint = new IndexPoint(null,null,null,year,null,null);
        List<IndexPoint> indexPoints = indexPointDao.getIndexPoint(indexPoint);
        List<RelatedIndexPointCourse> relatedIndexPointCourses = new ArrayList<>();
        for (IndexPoint indexPoint1:indexPoints
                ) {
            RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(null,indexPoint1.getId(),null,0.0,null,0.0,null,null);

            relatedIndexPointCourses.addAll(relatedIndexPointCourseDao.getRelatedIndexPointCourse(relatedIndexPointCourse));
        }

        for (int i=0;i<relatedIndexPointCourses.size();i++
                ) {
            // System.out.println(relatedIndexPointCourses.get(i).getCourseId());
            relatedIndexPointCourses.get(i).setCourseId(getCourseName(relatedIndexPointCourses.get(i).getCourseId()));
            relatedIndexPointCourses.get(i).getCourseId();
        }

        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",relatedIndexPointCourses);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

    /**
     * 根据年和指标点插课程
     * @param indexPointId
     * @return
     */
    @RequestMapping("getIndexPointCourse1")
    @ResponseBody
    public Object getIndexPointCourse(@RequestParam("indexPointId") String indexPointId){

        if(indexPointId=="")indexPointId=null;
        // System.out.println(indexPointId);
        RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(null,indexPointId,null,0.0,null,0.0,null,null);

        List<RelatedIndexPointCourse> relatedIndexPointCourses = relatedIndexPointCourseDao.getRelatedIndexPointCourse(relatedIndexPointCourse);
        HashMap<String ,Object> hashMap=new HashMap<>();

        for (int i=0;i<relatedIndexPointCourses.size();i++
                ) {
            //System.out.println(relatedIndexPointCourses.get(i).getCourseId());
            relatedIndexPointCourses.get(i).setCourseId(getCourseName(relatedIndexPointCourses.get(i).getCourseId()));
            relatedIndexPointCourses.get(i).getCourseId();
        }

        hashMap.put("list",relatedIndexPointCourses);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }


    /**
     * 根据课程id，返回名字
     * @param courseId
     * @return
     */

    private String getCourseName(String courseId)
    {
        Course course = new Course(courseId,null,null,null);

        List<Course> courses = courseDao.getCourse(course);

        HashMap<String ,Object> hashMap=new HashMap<>();

        return courses.get(0).getName();


    }


}
