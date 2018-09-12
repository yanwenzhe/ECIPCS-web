package com.controller.professor;

import com.dao.GraduationRequirementDao;
import com.entity.GraduationRequirement;
import com.utils.AjaxMessge;
import com.utils.GuidUtil;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("system/professor/")
public class ValueCalculatedController {

    @Autowired
    private GraduationRequirementDao graduationRequirementDao;
    /**
     * 跳转到毕业达成度计算界面
     */
    @RequestMapping("valueCalculated")
    public String manage(){
        return PageNameUtil.VALUE_CALCULATED;
    }

    @RequestMapping("updateCountValue")
    @ResponseBody
    public Object update(@RequestParam("result") String result,
                         @RequestParam("indexPointId") String indexPointId,
                         @RequestParam("yearStart") String yearStart,
                         @RequestParam("yearEnd") String yearEnd
                         ){
        List<GraduationRequirement> list =graduationRequirementDao.getGraduationRequirement(new GraduationRequirement(null,indexPointId,yearStart,yearEnd,0.0));
        if(list.isEmpty()){
            String id= GuidUtil.getGuid();
            graduationRequirementDao.addGraduationRequirement(new GraduationRequirement(id,indexPointId,yearStart,yearEnd,new Double(result)));
        }
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }
}
