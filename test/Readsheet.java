import com.utils.GuidUtil;
import com.utils.PinYinUtil;
import com.utils.TakeFilePathAndName;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

public class Readsheet {

    static XSSFRow row;
    static XSSFRow row1;
    static Cell cell;
    static Cell cell1;

    public static void main(String[] args) throws Exception
    {
        /**
         * Course表数据插入
         */

        //insertCourse("excel\\2009~2016学年-课程支撑矩阵.xlsx");
        //insertCourse("excel\\2016~2018学年-课程支撑矩阵.xlsx");

        /**
         * IndexPoint表数据的插入
         */

        //insertIndexPoint("excel\\2009~2016学年-课程支撑矩阵.xlsx");
        // insertIndexPoint("excel\\2016~2018学年-课程支撑矩阵.xlsx");

        /**
         *RelatedIndexPointCourse表数据的插入
         */

        // insertIndexPoint_Course("excel\\2009~2016学年-课程支撑矩阵.xlsx");
        // insertIndexPoint_Course("excel\\2016~2018学年-课程支撑矩阵.xlsx");


        /**
         * Student 和 StudentScore表的插入
         */

        List<String> fileName = TakeFilePathAndName.getFile("D:\\workplace\\IDEA\\ECIPCSweb\\excel\\grade");
        for (String pathname:fileName
                ) {
            insertStudent_Score("excel\\grade\\"+pathname);
        }
    }

    public static void insertCourse(String pathname) throws Exception
    {
        FileInputStream fileInputStream = new FileInputStream(new File(pathname));
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);

        List<String> courses = new ArrayList<>();
        //年份
        List<String> years = new ArrayList<>();
        years.add(pathname.substring(6,10));
        years.add(pathname.substring(11,15));
        int yearStart = Integer.parseInt(years.get(0));
        int yearEnd = Integer.parseInt(years.get(1));

        //读取第一列的所有课程,从第2行开始读，不空则为一门课程
        for (int i= 1 ; i <= sheet.getLastRowNum() - 4; i++)
        {
            row = sheet.getRow(i);

            if(row != null)
            {
                Cell cell = row.getCell(0);
                if (cell.getCellType() != Cell.CELL_TYPE_BLANK)
                {
                    courses.add(cell.getStringCellValue());
                }
                else
                    continue;
            }
        }

        //课程循环
        for (String name:courses
                ) {
            //年份循环
            for(int y=yearStart;y<yearEnd;y++) {
                String id = GuidUtil.getGuid();
                System.out.println("INSERT INTO Course(id,name,description,year) VALUES(\"" + id + "\",\"" + name + "\",\"\",\"" + y + "\");");
            }
        }
    }

    public static void insertIndexPoint(String pathname) throws Exception
    {

        FileInputStream fileInputStream = new FileInputStream(new File(pathname));
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);
        XSSFSheet sheet = workbook.getSheetAt(0);

        //表格第4行是指标点
        row = sheet.getRow(3);

        //年份
        List<String> years = new ArrayList<>();
        years.add(pathname.substring(6,10));
        years.add(pathname.substring(11,15));
        int yearStart = Integer.parseInt(years.get(0));
        int yearEnd = Integer.parseInt(years.get(1));

        for(int i = 1; i < row.getLastCellNum() - 4; i++)
        {
            String id = GuidUtil.getGuid();

            Cell cell = row.getCell(i);
            if(cell.getCellType() != Cell.CELL_TYPE_BLANK)
            {
                String delimeter = " ";//分隔符是空格
                String[] sArray = cell.getStringCellValue().split(delimeter);
                //System.out.println(sArray[0]);
                //System.out.println(sArray[1]);

                double index = Double.parseDouble(sArray[0]);
                int indexrequirement = (int) index;

                String point = sArray[0];

                String description = sArray[1];

                System.out.println("INSERT INTO IndexPoint(id,indexPointId,point,yearStart,yearEnd,description) VALUES(\""+ id + "\",\"" + indexrequirement + "\",\"" + point + "\",\"" + yearStart + "\",\""+yearEnd + "\",\""+description+"\");" );

            }
        }
    }

    public static void insertIndexPoint_Course(String pathname) throws Exception
    {
        FileInputStream fileInputStream = new FileInputStream(new File(pathname));
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);
        XSSFSheet sheet = workbook.getSheetAt(0); //程度矩阵
        XSSFSheet sheet1 = workbook.getSheetAt(1); //系数矩阵

        //表格第4行是指标点
        row = sheet.getRow(3);        //指标点序列
        List<String> point = new ArrayList<>();
        for(int i = 0; i < row.getLastCellNum() - 4; i++)
        {
            Cell cell = row.getCell(i);
            String delimeter = " ";//分隔符是空格
            String[] sArray = cell.getStringCellValue().split(delimeter);
            point.add(sArray[0]);
        }
//        for (int i = 0; i < point.size();i++
//             ) {
//            System.out.println(point.get(i));
//        }

        //年份
        List<String> years = new ArrayList<>();
        years.add(pathname.substring(6,10));
        years.add(pathname.substring(11,15));
        int yearStart = Integer.parseInt(years.get(0));
        int yearEnd = Integer.parseInt(years.get(1));

        int add = 0;
        for (int i =  4 ; i <= sheet.getLastRowNum() - 4;i++)
        {
            row = sheet.getRow(i); //程度
            row1 = sheet1.getRow(i+add); //系数

            int j = 1;
            for(; j < row.getLastCellNum() - 4; j++)
            {
                cell = row.getCell(j);
                cell1 = row1.getCell(j);


                if(cell.getCellType() != Cell.CELL_TYPE_BLANK)
                {
                    for(int y=yearStart;y<yearEnd;y++) {
                        String id = GuidUtil.getGuid();
                        System.out.println("INSERT INTO RelatedIndexPointCourse(id,indexPointId,courseId,supportFactor,supportDegree) SELECT\"" + id + "\",i.id,c.id," + cell1.getNumericCellValue() + ",\"" + cell.getStringCellValue() + "\" FROM Course c,IndexPoint i WHERE c.name=\"" + row.getCell(0).getStringCellValue() + "\" and c.year=\""+ y + "\" and i.point=\"" + point.get(j) + "\" and i.yearStart<=\""+y+"\" and i.yearEnd>=\""+y+"\";");
                    }
                }
            }

            if (!(row.getCell(j+1) .getNumericCellValue() > 0))
            {
                add--;
            }

        }

    }

    public static void insertStudent_Score(String pathname) throws Exception
    {
        FileInputStream fileInputStream = new FileInputStream(new File(pathname));
        XSSFWorkbook workbook = new XSSFWorkbook(fileInputStream);

        //年份
        List<String> years = new ArrayList<>();
        years.add(pathname.substring(12,16));
        years.add(pathname.substring(17,21));
        int yearStart = Integer.parseInt(years.get(0));
        int yearEnd = Integer.parseInt(years.get(1));

        //拆分文件名，获取信息
        String delimeter = "-";//分隔符是空格
        //课程名
        String coursename = pathname.split(delimeter)[1];

        //教师姓名
        String[] sArray = pathname.split(delimeter)[2].split("\\.");
        String name = sArray[0];
        String username = PinYinUtil.getCharPinYinString(sArray[0])[0];

        for (int y=yearStart;y<yearEnd;y++)
        {
            System.out.println("INSERT INTO Teacher(id,username,password,name,phone,year) Values(\""+GuidUtil.getGuid()+"\",\""+username+"\",\"123456\",\""+name+"\",\"\",\""+y+"\");");}

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
                System.out.println("INSERT INTO Student(id,schoolNumber,name,classId) VALUES(\"" + studentid + "\",\"" + row.getCell(0).getStringCellValue() + "\",\"" + row.getCell(1).getStringCellValue() + "\",\"" + row.getCell(2).getStringCellValue() + "\");");

                for (int j= 3;j<row.getLastCellNum();j++) {
                    cell = row.getCell(j);
                    String scoreid = GuidUtil.getGuid();    //再次随机生成StudentScore表id
                    System.out.println("INSERT INTO StudentScore(id,courseId,studentId,teacherId,indexPointId,columName,score,fullScore) SELECT\"" + scoreid + "\",C.id,S.id,T.id,I.id,\"" + columName.get(j) + "\"," +cell.getNumericCellValue()+","+sheet.getRow(2).getCell(j).getNumericCellValue()+" FROM Course C,Student S, Teacher T, IndexPoint I WHERE C.name=\""+coursename+"\" and C.year=\""+y+"\" and T.username=\"zhaoxiaolin\" and T.year=\""+y+"\" and I.point=\""+sheet.getRow(1).getCell(j).getNumericCellValue()+"\" and I.yearStart<=\""+y+"\" and I.yearEnd>\""+y+"\" and S.schoolNumber=\""+row.getCell(0).getStringCellValue()+"\";");
                }
            }
        }
    }

}
