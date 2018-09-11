import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Writesheet {
    public static void main(String[] args) throws Exception
    {
        //创建一个空的excel
        XSSFWorkbook workbook = new XSSFWorkbook();
        //创建一张空sheet
        XSSFSheet sheet = workbook.createSheet("sheetname");
        //创建一个row对象
        XSSFRow row;
        //准备数据（Object[]）
        Map< String, Object[]> info= new TreeMap<String, Object[]>();
        String clo = "相关文档"+"20"+"分";
        info.put("1",new Object[]{
           "", "软件系统30分", clo, "过程管理30分", "答辩表现20分", "总分", "系数", "评价值"
        });

        info.put("2",new Object[]{
           "6.2 能够完成软件工程项目实践",25,"","",5,30,0.3,0.22
        });

        info.put("3",new Object[]{
                "", 18.29,"","",4.03,22.32,"", ""
        });

        info.put("4",new Object[]{
                "6.2 能够完成软件工程项目实践",25,"","",5,30,0.3,0.22
        });

        info.put("5",new Object[]{
                "", 18.29,"","",4.03,22.32,"", ""
        });

        info.put("6",new Object[]{
                "6.2 能够完成软件工程项目实践",25,"","",5,30,0.3,0.22
        });

        info.put("7",new Object[]{
                "", 18.29,"","",4.03,22.32,"", ""
        });

        Set <String> keyid = info.keySet();
        int rowid = 0;
        for (String key :keyid)
        {
            row = sheet.createRow(rowid++);
            Object [] objectArr = info.get(key);
            int cellid = 0;

            for(Object obj:objectArr)
            {
                //6,7列会改变
                if((cellid ==0 || cellid ==6 || cellid ==7) && rowid%2!=0)
                {
                    sheet.addMergedRegion(new CellRangeAddress(
                            rowid,
                            rowid+1,
                            cellid,
                            cellid
                    ));
                }
                Cell cell = row.createCell(cellid++);
                cell.setCellValue(String.valueOf(obj));
            }


        }

        //sheet.autoSizeColumn(0,true);
        for(int i = 0; i < sheet.getLastRowNum();i++)
        {
            sheet.autoSizeColumn(i);
            sheet.autoSizeColumn(i,true);
            sheet.setColumnWidth(i,sheet.getColumnWidth(i)*18/10);
        }

        //将workbook写入系统
        FileOutputStream out = new FileOutputStream(new File("excel\\样表-XXX评价表.xlsx"));
        workbook.write(out);
        out.close();
        System.out.println("写入完成");
    }
}
