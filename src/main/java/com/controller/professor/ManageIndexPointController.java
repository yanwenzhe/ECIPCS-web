package com.controller.professor;

import com.dao.IndexPointDao;
import com.entity.IndexPoint;
import com.utils.AjaxMessge;
import com.utils.GuidUtil;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/system/professor/")
public class ManageIndexPointController {

    @Autowired
    private IndexPointDao indexPointDao;

    /**
     * 跳转到指标点管理界面
     */
    @RequestMapping("manageIndexPoint")
    public String manage(){
        return PageNameUtil.MANAGE_INDEX_POINT;
    }


    /**
     * 添加指标点
     *
     */
    @RequestMapping(value = "addIndexPoint", method = RequestMethod.POST)
    @ResponseBody
    public Object addIndexPoint(@RequestBody JSONObject jsonObject)
    {
        IndexPoint indexPoint = new IndexPoint();

        JSONObject obj = jsonObject.getJSONObject("addIndexPoint");
            indexPoint.setIndexRequirementId(obj.getString("requirementId"));
            indexPoint.setDescription(obj.getString("description"));
            indexPoint.setPoint(obj.getString("point"));
            indexPoint.setYearStart(obj.getString("startYear"));
            indexPoint.setYearEnd(obj.getString("endYear"));

        //随机id
        String id = GuidUtil.getGuid();
        indexPoint.setId(id);
        indexPointDao.addIndexPoint(indexPoint);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);    }


    /**
     * 修改指标点的描述
     *
     */
    @RequestMapping(value = "updateIndexPoint")
    @ResponseBody
    public Object updateIndexPoint(@RequestBody JSONObject jsonObject)
    {
        JSONObject obj = jsonObject.getJSONObject("udpateIndexPoint");
        IndexPoint indexPoint = new IndexPoint(obj.getString("id"),null,null,null,null,obj.getString("description"));
        indexPointDao.updateIndexPoint(indexPoint);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }

    /**
     * 通过指标要求查询指标点信息
     * @param indexRequirementId
     * @return
     */
    @RequestMapping(value = "getIndexPointByIndexRequirement")
    @ResponseBody
    public Object getIndexPointByIndexRequirement(@RequestParam("indexRequirementId") String indexRequirementId,
                                                  @RequestParam("year") String year)
    {
        if (indexRequirementId == "") indexRequirementId = null;
        if(year == "") year = null;

        System.out.println(year);
        IndexPoint indexPoint = new IndexPoint(null,indexRequirementId,null,year,null,null);
        List<IndexPoint> list = indexPointDao.getIndexPoint(indexPoint);
        HashMap<String ,Object> hashMap=new HashMap<>();
        hashMap.put("list",list);
        hashMap.put("success","success");
        return new AjaxMessge().Set(MsgType.Success,hashMap);
    }
}
