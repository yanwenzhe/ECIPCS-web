package com.controller.professor;

import com.dao.GraduationRequirementDao;
import com.entity.GraduationRequirement;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("system/professor/")
public class ValueChartedController {

    @Autowired
    private  GraduationRequirementDao graduationRequirementDao;
    /**
     * 跳转到图形化界面
     */
    @RequestMapping("valueChart")
    public String manage(){
        return PageNameUtil.VALUE_CHART;
    }

    @RequestMapping("valueTable")
    public String valueTable(){
        return PageNameUtil.VALUE_TABLE;
    }

    @RequestMapping("getChartData")
    @ResponseBody
    public Object getChart(){
        List<GraduationRequirement> list=graduationRequirementDao.getGraduationRequirement(new GraduationRequirement(null,null,null,null,0.0));
        List<Double> list1= new ArrayList<>();
        for(GraduationRequirement graduationRequirement:list){
            list1.add(graduationRequirement.getValue());
        }

        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",list1);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

}
