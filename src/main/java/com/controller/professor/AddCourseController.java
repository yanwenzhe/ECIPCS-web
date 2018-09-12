package com.controller.professor;

import com.dao.CourseDao;
import com.dao.RelatedIndexPointCourseDao;
import com.dao.RelatedIndexPointCourseTeacherDao;
import com.dao.RelatedTeacherCourseDao;
import com.entity.Course;
import com.entity.RelatedIndexPointCourse;
import com.entity.RelatedIndexPointCourseTeacher;
import com.entity.RelatedTeacherCourse;
import com.utils.AjaxMessge;
import com.utils.GuidUtil;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("system/professor/")
public class AddCourseController {

    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;

    @Autowired
    private RelatedIndexPointCourseTeacherDao relatedIndexPointCourseTeacherDao;

    @Autowired
    private CourseDao courseDao;

    @Autowired
    RelatedTeacherCourseDao relatedTeacherCourseDao;
    /**
     * 跳转到添加课程界面
     */
    @RequestMapping("addCourse")
    public String manage(){
        return PageNameUtil.ADD_COURSE_VIEW;
    }

    /**
     * 根据指标点id和年份得到所有的相关课程及其系数
     * @param indexPointId
     * @return
     */
    @RequestMapping("getCourseListByIndexPointId")
    @ResponseBody
    public Object getCourse(@RequestParam("indexPointId") String indexPointId,@RequestParam("year") String year){
        if(indexPointId=="") indexPointId=null;
        RelatedIndexPointCourse relatedIndexPointCourse=new RelatedIndexPointCourse(null,indexPointId,null,0.0,null,0.0,null,null);
        List<RelatedIndexPointCourse> list=relatedIndexPointCourseDao.getRelatedIndexPointCourse(relatedIndexPointCourse);
        List<RelatedIndexPointCourse> list2=new ArrayList<>();

        for(RelatedIndexPointCourse relatedIndexPointCourse1:list){
           // System.out.println("id: "+relatedIndexPointCourse1.getCourseId()+" factor: "+relatedIndexPointCourse1.getSupportFactor());
            String courseId=relatedIndexPointCourse1.getCourseId();
            String courseName=null;
            String courseYear=null;
            List<Course> course=courseDao.getCourse(new Course(courseId,null,null,null));
            for(Course cos:course){
                    courseName = cos.getName();
                    courseYear=cos.getYear();
                    break;
            }
            if(courseYear.equals(year)){
                relatedIndexPointCourse1.setTeachingContent(courseName);
                list2.add(relatedIndexPointCourse1);
            }
        }
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",list2);
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }


    /**
     * 保存已经修改的课程的支撑系数
     * @param jsonObject
     * @return
     */
    @RequestMapping("updateCourseIndexPointRelated")
    @ResponseBody
    public Object update(@RequestBody JSONObject jsonObject) {

        JSONArray jsonArray1 = jsonObject.getJSONArray("courseList");
        for (Object obj : jsonArray1) {
            JSONObject jsonObject1 = (JSONObject) obj;
            String id = jsonObject1.getString("id");
            Double factor = jsonObject1.getDouble("supportFactor");
            RelatedIndexPointCourse relatedIndexPointCourse = new RelatedIndexPointCourse(id, null, null, factor, null, 0.0, null, null);
            relatedIndexPointCourseDao.updateRelatedIndexPointCourse(relatedIndexPointCourse);
        }
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("success", "success");
        return new AjaxMessge().Set(MsgType.Success, hashMap);
    }

    /**
     * 添加课程-》添加课程指标点关联-》添加课程指标点和教师的关联
     * @param jsonObject
     * @return
     */
    @RequestMapping("addCourseTable")
    @ResponseBody
    public Object addCourse(@RequestBody JSONObject jsonObject) {
        JSONObject jsonArray = jsonObject.getJSONObject("formCourse");
        String id= GuidUtil.getGuid();
        String name=jsonArray.getString("name");
        String year=jsonArray.getString("year");
        String description=jsonArray.getString("desc");
        //得到课程对象，插入课程
        Course course=new Course(id,name,year,description);

        try{
            courseDao.addCourse(course);
        }catch (Exception e){
            HashMap<String, Object> hashMap = new HashMap<>();
            hashMap.put("success", "添加课程失败");
            return new AjaxMessge().Set(MsgType.Success, hashMap);
        }

        //考虑指标点和教师天添加
        JSONArray jsonArray1=jsonArray.getJSONArray("selectIndexPointList");
        JSONArray jsonArray2=jsonArray.getJSONArray("selectTeacherList");
        for (Object jsonObj : jsonArray1) {
            String id2=GuidUtil.getGuid();
            JSONObject obj=(JSONObject) jsonObj;
            String indexPointId=obj.getString("indexPointId");
            String supportDegree=obj.getString("supportDegree");

            Double supportFactor=obj.getDouble("supportFactor");
            if(supportDegree.equals('M')) supportFactor=0.0;
            //得到指标点与课程关联对象，插入
            RelatedIndexPointCourse relatedIndexPointCourse =new RelatedIndexPointCourse(id2,indexPointId,id,supportFactor,supportDegree,0.0,null,null);

            try{
                relatedIndexPointCourseDao.addRelatedIndexPointCourse(relatedIndexPointCourse);
            }catch (Exception e){
                HashMap<String, Object> hashMap = new HashMap<>();
                hashMap.put("success", "添加-课程与指标点-关联失败");
                return new AjaxMessge().Set(MsgType.Success, hashMap);
            }
            //每个老师对应所有指标点
            for(Object jsonObj2:jsonArray2){
                JSONObject obj2=(JSONObject) jsonObj2;
                String id3=GuidUtil.getGuid();
                String teacherId=obj2.getString("id");
                String id4=GuidUtil.getGuid();
                //得到教师课程关联对象并添加
                RelatedTeacherCourse relatedCourseTeacher=new RelatedTeacherCourse(id4,teacherId,id,null,null,null,null);
                try{
                    relatedTeacherCourseDao.addRelatedTeacherCourse(relatedCourseTeacher);
                }catch (Exception e){
                    HashMap<String, Object> hashMap = new HashMap<>();
                    hashMap.put("success", "添加-教师与课程-关联失败");
                    return new AjaxMessge().Set(MsgType.Success, hashMap);
                }

                //得到教师课程指标点关联对象并添加，。插入
                RelatedIndexPointCourseTeacher relatedIndexPointCourseTeacher=new RelatedIndexPointCourseTeacher(id3,indexPointId,id,teacherId,null,0.0);
                try{
                    relatedIndexPointCourseTeacherDao.addRelatedIndexPointCourseTeacher(relatedIndexPointCourseTeacher);
                }catch (Exception e){
                    HashMap<String, Object> hashMap = new HashMap<>();
                    hashMap.put("success", "添加-教师与课程与指标点-关联失败");
                    return new AjaxMessge().Set(MsgType.Success, hashMap);
                }
            }

        }
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("success", "success");
        return new AjaxMessge().Set(MsgType.Success, hashMap);
    }


}
