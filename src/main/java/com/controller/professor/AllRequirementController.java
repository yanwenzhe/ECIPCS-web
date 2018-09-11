package com.controller.professor;

import com.dao.IndexRequirementDao;
import com.entity.IndexRequirement;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("system/professor/")
public class AllRequirementController {
    @Autowired
    private IndexRequirementDao indexRequirementDao;

    /**
     * 跳转到查看所有指标要求的界面
     */
    @RequestMapping("allRequirement")
    public String manage(){
        return PageNameUtil.ALL_REQUIREMENT;
    }

    /**
     * get请求获取所有的指标要求
     * @return
     */
    @RequestMapping(value = "getList",method = RequestMethod.GET)
    @ResponseBody
    public Object getAllRequirements()
    {

        IndexRequirement indexRequirement = new IndexRequirement(null,null,null);
        List<IndexRequirement> list = indexRequirementDao.getIndexRequirement(indexRequirement);

        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",list);
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }


    /**
     * post修改指标要求的描述

     * @return
     */
    @RequestMapping(value = "updateList")
    @ResponseBody
    public Object updateRequirement(@RequestBody JSONObject jsonObject)
    {
        JSONObject obj = jsonObject.getJSONObject("updateList");
        IndexRequirement indexRequirement = new IndexRequirement(obj.getString("id"),"",obj.getString("description"));
        indexRequirementDao.updateIndexRequirement(indexRequirement);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }
}
