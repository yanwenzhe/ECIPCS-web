package com.controller.teacher;


import com.dao.*;
import com.entity.*;
import com.utils.GuidUtil;
import com.utils.PinYinUtil;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;


import static com.utils.PageNameUtil.COURSEVIEW;

@Controller
@RequestMapping("/teacher")
public class CourseViewController {

    @Autowired
    private CourseDao courseDao;

    @Autowired
    private RelatedTeacherCourseDao relatedTeacherCourseDao;

    @Autowired
    private StudentScoreDao studentScoreDao;

    @Autowired
    private StudentDao studentDao;

    @Autowired
    private TeacherDao teacherDao;

    @Autowired
    private RelatedIndexPointCourseDao relatedIndexPointCourseDao;

    @Autowired
    private IndexPointDao indexPointDao;

    @RequestMapping("/courseView")
    public String courseView(){

        return COURSEVIEW;

    }
    @RequestMapping("/course")
    @ResponseBody
    public Object  result(@RequestParam(value = "year", required = false) String year,
                          HttpSession httpSession, HttpServletRequest request, ModelMap model){

        List<Object> result = new ArrayList<>();

        String user = "zhaoxiaolin";

        List<String>userid = teacherDao.getTeacherId(user,year);

        int count = 1;

        for (String item:userid
             ) {
            List<String>courseId = relatedTeacherCourseDao.getCourseId(item);
            for (String item2:courseId
                 ) {
                List<String>courseName = courseDao.getCourseName(item2);
                for (String item3:courseName
                     ) {
                    List<Object>row = new ArrayList<>();
                    row.add(count);
                    row.add(item3);
                    count++;
                    result.add(row);
                }
            }
        }

        return result;

    }

    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model) throws Exception {

        System.out.println("开始");
        String path = request.getSession().getServletContext().getRealPath("upload");
       String fileNameadd= file.getOriginalFilename();

        //System.out.println(fileNameadd);
        //String[] sourceStrArray = fileNameadd.split("\\.");
        //String fileadd = sourceStrArray[sourceStrArray.length-1];

        //System.out.println(fileadd);
        String fileName = fileNameadd;
        //System.out.println(path);
        File targetFile = new File(path, fileName);
        if(!targetFile.exists()){
            targetFile.mkdirs();
        }

       //保存
        try {
            file.transferTo(targetFile);
            insertStudentScore(targetFile);

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("fileUrl", request.getContextPath()+"/upload/"+fileName);

        return COURSEVIEW;
    }



    private void insertStudentScore(File file) throws Exception
    {
        String name = file.getName();
        System.out.println("文件名"+name);

        FileInputStream fileInputStream = new FileInputStream(file);
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);

        //年份
        List<String> years = new ArrayList<>();
        years.add(name.substring(0, 4));
        years.add(name.substring(5, 9));
        int yearStart = Integer.parseInt(years.get(0));
        int yearEnd = Integer.parseInt(years.get(1));

        //拆分文件名，获取信息
        String delimeter = "-";//分隔符是空格
        //课程名
        String coursename = name.split(delimeter)[1];

        //教师姓名
        String[] sArray = name.split(delimeter)[2].split("\\.");
        String teachername = sArray[0];
        String username = PinYinUtil.getCharPinYinString(sArray[0])[0];

        XSSFRow row1;
        Cell cell1;
        XSSFRow row;
        Cell cell;

        //插教师表
//        String teacherId = GuidUtil.getGuid();
//        for (int y = yearStart; y < yearEnd; y++) {
//
//            Teacher teacher =new Teacher(teacherId,username,teachername,"E10ADC3949BA59ABBE56E057F20F883E","",String.valueOf(y));
//
//            teacherDao.addTeacher(teacher);
//
//            //System.out.println("INSERT INTO Teacher(id,username,password,name,phone,year) Values(\"" + GuidUtil.getGuid() + "\",\"" + username + "\",\"123456\",\"" + teachername + "\",\"\",\"" + y + "\");");
//        }

        for(int y=yearStart,k=1;y<yearEnd;y++,k+=2) {
            XSSFSheet sheet = workbook.getSheetAt(k);

            //获取列名
            row1 = sheet.getRow(0);
            List<String> columName = new ArrayList<>();
            String copy="";
            columName.add("");
            columName.add("");
            columName.add("");
            for (int i = 3;i<row1.getLastCellNum();i++)
            {
                cell1 = row1.getCell(i);
                if (cell1.getCellType() == Cell.CELL_TYPE_BLANK)
                {
                    columName.add(copy);
                }
                else
                {
                    copy=cell1.getStringCellValue();
                    columName.add(copy);
                }
            }

//            for (String n:columName
//                 ) {
//                System.out.println(n);
//            }

            for (int i = 4; i < sheet.getLastRowNum(); i++) {

                row = sheet.getRow(i);
                String studentid = GuidUtil.getGuid();    //随机生成Student表id
                //System.out.println(row.getCell(0).getStringCellValue());
                Student student = new Student(studentid,row.getCell(0).getStringCellValue(),row.getCell(1).getStringCellValue(),row.getCell(2).getStringCellValue());
                studentDao.addStudent(student);

                //System.out.println("INSERT INTO Student(id,schoolNumber,name,classId) VALUES(\"" + studentid + "\",\"" + row.getCell(0).getStringCellValue() + "\",\"" + row.getCell(1).getStringCellValue() + "\",\"" + row.getCell(2).getStringCellValue() + "\");");

                for (int j= 3;j<row.getLastCellNum();j++) {
                    cell = row.getCell(j);

                    //courseId
                    Course course = new Course(null,coursename,null,String.valueOf(y));
                    List<Course> courseList = courseDao.getCourse(course);

                    //indexPointId
                    double point = sheet.getRow(1).getCell(j).getNumericCellValue();
                    IndexPoint indexPoint = new IndexPoint(null,null,String.valueOf(point),String.valueOf(y),null,null);
                    List<IndexPoint> indexPointList = indexPointDao.getIndexPoint(indexPoint);


                    Teacher teacher = new Teacher(null,username,teachername,null,null,String.valueOf(y));
                    List<Teacher> teacherList = teacherDao.getTeacher(teacher);

                    String scoreid = GuidUtil.getGuid();    //再次随机生成StudentScore表id
                    StudentScore studentScore = new StudentScore(scoreid,courseList.get(0).getId(),studentid,teacherList.get(0).getId(),indexPointList.get(0).getId(),columName.get(j),cell.getNumericCellValue(),sheet.getRow(2).getCell(j).getNumericCellValue());
                    studentScore.print();
                    studentScoreDao.addStudentScore(studentScore);

                    //System.out.println("INSERT INTO StudentScore(id,courseId,studentId,teacherId,indexPointId,columName,score,fullScore) SELECT\"" + scoreid + "\",C.id,S.id,T.id,I.id,\"" + columName.get(j) + "\"," +cell.getNumericCellValue()+","+sheet.getRow(2).getCell(j).getNumericCellValue()+" FROM Course C,Student S, Teacher T, IndexPoint I WHERE C.name=\""+coursename+"\" and C.year=\""+y+"\" and T.username=\"zhaoxiaolin\" and T.year=\""+y+"\" and I.point=\""+sheet.getRow(1).getCell(j).getNumericCellValue()+"\" and I.yearStart<=\""+y+"\" and I.yearEnd>\""+y+"\" and S.schoolNumber=\""+row.getCell(0).getStringCellValue()+"\";");
                }
            }
        }
    }
}
