package com.controller.admin;

import com.dao.TeacherDao;
import com.entity.Teacher;
import com.sun.jmx.remote.internal.ServerCommunicatorAdmin;
import com.utils.*;
import net.sf.json.JSONObject;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.utils.PageNameUtil.*;

import java.util.HashMap;
import java.util.List;

@ControllerAdvice
@RequestMapping("/system/management")
public class manageTeacherController {

    @Autowired
    private TeacherDao teacherDao;

    @RequestMapping("/manageTeacher")
    public String manageTeacher(){

        return PageNameUtil.ADMIN;
    }

    /**
     * 得到老师的所有信息
     * @param year
     * @return
     */
    @RequestMapping("/getTeacherList")
    @ResponseBody
    public Object getList(@RequestParam("year") String year){

        if(year == "") year = null;
        Teacher teacher =new Teacher(null,null,null,null,null,year);
        List<Teacher> list=teacherDao.getTeacher(teacher);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",list);
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }


    /**
     * 添加老师的用户账号
     * @param jsonObject
     * @return
     */
    @RequestMapping("/addTeacher")
    @ResponseBody
    public Object add(@RequestBody JSONObject jsonObject){

        String id = GuidUtil.getGuid();
        JSONObject obj=jsonObject.getJSONObject("addTeacher");
        String name=obj.getString("name");
        System.out.println("看一看有没有姓名："+name);
        String username= PinYinUtil.getCharPinYinString(name)[0];
        Teacher teacher =new Teacher(id,username,name,"123456",obj.getString("phone"),obj.getString("year"));
        teacherDao.addTeacher(teacher);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }


    /**
     * 更新教师用户的密码
     * @param jsonObject
     * @return
     */
    @RequestMapping("/updateTeacher")
    @ResponseBody
    public Object update(@RequestBody JSONObject jsonObject){


        JSONObject obj=jsonObject.getJSONObject("updateTeacher");
        String id=obj.getString("id");
        String password=obj.getString("password");
        String phone=obj.getString("phone");
        Teacher teacher =new Teacher(id,null,null,password,phone,null);
        teacherDao.updateTeacher(teacher);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

}
