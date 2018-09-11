package com.controller.professor;


import com.dao.CourseDao;
import com.dao.IndexPointDao;
import com.dao.RelatedIndexPointCourseDao;
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
        System.out.println("根据年份查"+year);
        //通过年份求得指标点列表
        IndexPoint indexPoint = new IndexPoint(null,null,null,year,null,null);
        List<IndexPoint> indexPoints = indexPointDao.getIndexPoint(indexPoint);
        System.out.println(year+"年有"+indexPoints.size()+"个指标点");

        //新建一个指标课程关系表
        List<RelatedIndexPointCourse> relatedIndexPointCourses = new ArrayList<>();

        for (IndexPoint i1:indexPoints
        ) {
            //通过指标点ID查的所有的课程
            RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(null,i1.getId(),null,0.0,null,0.0,null,null);
            List<RelatedIndexPointCourse> relatedIndexPointCourseList = relatedIndexPointCourseDao.getRelatedIndexPointCourse(relatedIndexPointCourse);
            //System.out.println("对应指标点有"+relatedIndexPointCourseList.size()+"条对应的课程");

            for (RelatedIndexPointCourse r: relatedIndexPointCourseList
            ) {
                String courseId= r.getCourseId();
                Course course = new Course(courseId,null,null,null);
                List<Course> courses = courseDao.getCourse(course);
                //System.out.println("该课程的年份"+courses.get(0).getYear());
                if(courses.get(0).getYear().equals(year)){
                    //System.out.println("符合标准");
                    RelatedIndexPointCourse newrelatedIndexPointCourse = new RelatedIndexPointCourse(r.getId(),r.getIndexPointId(),courses.get(0).getName(),r.getSupportFactor(),r.getSupportDegree(),r.getEvaluateValue(),r.getTeachingContent(),r.getAssessmentContent());
                    relatedIndexPointCourses.add(newrelatedIndexPointCourse);
                }
            }
        }

        System.out.println("共有"+relatedIndexPointCourses.size()+"条");
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list", relatedIndexPointCourses);
        return new AjaxMessge().Set(MsgType.Success, hashMap);
    }

    /**
     * 根据年和指标点插课程
     * @param indexPointId
     * @return
     */
    @RequestMapping("getIndexPointCourse1")
    @ResponseBody
    public Object getIndexPointCourse(@RequestParam("indexPointId") String indexPointId,
                                      @RequestParam("year") String year){

        System.out.println("根据年份和指标点查"+year+" "+indexPointId);

        //通过指标点ID查的所有的课程
        RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(null,indexPointId,null,0.0,null,0.0,null,null);
        List<RelatedIndexPointCourse> relatedIndexPointCourseList = relatedIndexPointCourseDao.getRelatedIndexPointCourse(relatedIndexPointCourse);

        //新建一个指标课程关系表
        List<RelatedIndexPointCourse> relatedIndexPointCourses = new ArrayList<>();
        System.out.println("对应指标点有"+relatedIndexPointCourseList.size()+"条对应的课程");

        for (RelatedIndexPointCourse r: relatedIndexPointCourseList
        ) {
            String courseId = r.getCourseId();
            Course course = new Course(courseId, null, null, null);
            List<Course> courses = courseDao.getCourse(course);
            //System.out.println("该课程的年份"+courses.get(0).getYear());
            if (courses.get(0).getYear().equals(year)) {
                System.out.println("符合标准");
                RelatedIndexPointCourse newrelatedIndexPointCourse = new RelatedIndexPointCourse(r.getId(), r.getIndexPointId(), courses.get(0).getName(), r.getSupportFactor(), r.getSupportDegree(), r.getEvaluateValue(), r.getTeachingContent(), r.getAssessmentContent());
                relatedIndexPointCourses.add(newrelatedIndexPointCourse);
            }
        }
        System.out.println("共有"+relatedIndexPointCourses.size()+"条");
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list", relatedIndexPointCourses);
        return new AjaxMessge().Set(MsgType.Success, hashMap);

    }

    @RequestMapping("updateCourse1")
    @ResponseBody
    public Object updateCourse1(@RequestBody JSONObject jsonObject){
        JSONObject obj = jsonObject.getJSONObject("updateCourse");

        String teaching = "";
        if(obj.getString("teachingContent")!="")
            teaching = obj.getString("teachingContent");
        String assess = "";
        if(obj.getString("assessmentContent")!="")
            assess = obj.getString("assessmentContent");


        RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(obj.getString("id"),null,null,0.0,null,0.0,teaching,assess);
        relatedIndexPointCourseDao.updateRelatedIndexPointCourse(relatedIndexPointCourse);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        System.out.println(teaching+" "+assess);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }
}
