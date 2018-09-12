package com.controller.professor;

import com.dao.GraduationRequirementDao;
import com.entity.GraduationRequirement;
import com.utils.AjaxMessge;
import com.utils.MsgType;
import com.utils.PageNameUtil;
import io.swagger.models.Model;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
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

    @RequestMapping(value = "download")
    public void downloadFile(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 拼接真实路径

        String fileName = "2009~2011学年-课程达成度.xlsx";
        String realPath = request.getServletContext().getRealPath("/upload") + "\\" + fileName;

        System.out.println(realPath);

        // 读取文件
        File file = new File(realPath);

        if(file.exists()){
            OutputStream os = new BufferedOutputStream(response.getOutputStream());
            response.setHeader("Content-disposition", "attachment; filename="+new String(fileName.getBytes("utf-8"), "ISO8859-1")); // 指定下载的文件名
            os.write(FileUtils.readFileToByteArray(file));
            os.flush();
        }
    }
}
