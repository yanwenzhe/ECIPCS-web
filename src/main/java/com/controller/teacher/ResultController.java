package com.controller.teacher;

import com.dao.RelatedIndexPointCourseDao;
import com.dao.StudentScoreDao;
import com.entity.RelatedIndexPointCourse;
import com.utils.GuidUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import static com.utils.PageNameUtil.RESULT;

@Controller
@RequestMapping("/teacher")
public class ResultController {


    @Autowired
    private StudentScoreDao studentScoreDao;

    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;

    @RequestMapping("/result")
    public String result(){

        return RESULT;

    }
    @RequestMapping("/resultScore")
    @ResponseBody
    public Object  result(@RequestParam(value = "year", required = false) String year,
                         @RequestParam(value = "id", required = false) String id,
                         HttpServletRequest request, ModelMap model){

        DecimalFormat df = new DecimalFormat("0.00");

        List<String> colum = studentScoreDao.getColumName(id);

        List<Object> result = new ArrayList<>();

        List<Object>header = new ArrayList<>();
        header.add("指标点");
        header.add("系数");

        List<Object> scoreExcel = new ArrayList<>();

        for (String item:colum
                ) {
            header.add(item);
        }
        header.add("总分");
        header.add("平均分");
        header.add("评价值");

        scoreExcel.add(header);
        result.add(scoreExcel);


        List<String> indexPointId = relatedIndexPointCourseDao.getPointId(id);
        for (String item:indexPointId) {
            List<Object>inpo = new ArrayList<>();

            List<String>points = studentScoreDao.getPoint(item);
            for (String item6:points) {

                System.out.println("1:"+item6);

                System.out.println(id + "  356416516  " +item );

                List<Double> supportFactor = relatedIndexPointCourseDao.getPointValue(id,item,"H");
                double average = 0;
                for (Double item2:supportFactor
                        ) {
                    inpo.add(item6);
                    inpo.add(item2);

                    System.out.println("2:"+item2);

                    double allScore = 0;
                    int flag = 0;
                    for (String item3:colum
                            ) {
                        List<Double> fullScore = studentScoreDao.getFullScore(id,item3,item);
                        if(fullScore.size() == 0){
                            inpo.add("无");

                            System.out.println("3:"+"无");

                        }else{
                            for (double item4:fullScore
                                    ) {
                                System.out.println(item3);
                                allScore = allScore + item4;
                                System.out.println("allScore" + allScore);
                                inpo.add(item4);

                                System.out.println("4:"+item4);

                                flag++;
                            }
                        }
                        double nowScore = 0;
                        List<Double> aScore = studentScoreDao.getAverageScore(id,item3,item);
                        int count = 0;
                        for (double item5:aScore
                                ) {
                            nowScore = item5 + nowScore;
                            count++;
                        }
                        if(count != 0){
                            average = nowScore / count + average;
                            System.out.println("average"+average);
                        }
                    }
                    inpo.add(allScore);

                    System.out.println("flag:"+flag);
                    System.out.println("5:"+allScore);

                    if(flag != 0){
                        average = average/flag;
                    }else{
                        average = 0;
                    }
                    inpo.add(df.format(average));

                    System.out.println("6:"+average);

                    double xyz = average/allScore*item2;


                    inpo.add(df.format(xyz));


                    if(allScore*item2==0.0) xyz=0.0;
                    //更新评价值
                    relatedIndexPointCourseDao.updateRelatedIndexPointCourseValue(new RelatedIndexPointCourse(
                           null,item,id,0.0,null,xyz,null,null)
                    );

                    System.out.println("7:"+xyz);
                    System.out.println("\n");
                }
            }
            result.add(inpo);
        }

        return result;

    }
}
