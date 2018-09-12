package com.controller.login;

import com.dao.TeacherDao;
import com.entity.Teacher;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

import static com.utils.PageNameUtil.*;

@Controller
@SessionAttributes(value = {"username"})
@RequestMapping("/system/login")
public class LoginController {


    @Autowired private TeacherDao teacherDao;

    @RequestMapping("/signIn")
    public String asc()
    {
        return LOGIN;
    }



    @RequestMapping("/verify")
    @ResponseBody()
    public Object veyifyIdentity(@RequestParam("username") String username,
                                 @RequestParam("password") String password,
                                 HttpSession httpSession, Model model)
    {
        String url=null;
        HashMap<String ,Object> hashMap=new HashMap<>();
        //管理员
        if (username.equals("admin") && password.equals("admin"))
        {
            //设置session
            model.addAttribute("username","管理员");
            url=ADMIN;
            hashMap.put("msg","success");
            hashMap.put("url",url);
            return new AjaxMessge().Set(MsgType.Success,hashMap);
        }
        //教授
        else if(username.equals("root") && password.equals("root"))
        {
            //设置session
            model.addAttribute("username","责任教授");
            url= MANAGE_INDEX_POINT;
            hashMap.put("msg","success");
            hashMap.put("url",url);
            return new AjaxMessge().Set(MsgType.Success,hashMap);
        }
        //老师
        else {
            int book=0;
            List<Teacher> teacherList=teacherDao.getTeacher(new Teacher(null,username,null,null,null,null));
            if(teacherList!=null) {
                for (Teacher teacher : teacherList) {
                    if(password.equals("123456")){
                        //设置session
                        model.addAttribute("username",teacher.getName());
                        book=1;
                    }
                    break;
                }
                if(book==1) {
                    url = "/teacher/courseView";
                    hashMap.put("msg", "success");
                    hashMap.put("url", url);
                    return new AjaxMessge().Set(MsgType.Success, hashMap);
                }
                else {
                    hashMap.put("msg","用户名或密码错误！");
                    hashMap.put("url","/#");
                    return new AjaxMessge().Set(MsgType.Success,hashMap);
                }
            }
            hashMap.put("msg","用户名或密码错误！");
            hashMap.put("url","/#");
            return new AjaxMessge().Set(MsgType.Success,hashMap);
        }

    }


    @RequestMapping("/returnLogin")
    public String returnLogin(SessionStatus sessionStatus){
        sessionStatus.setComplete();
        return LOGIN;
    }
}
