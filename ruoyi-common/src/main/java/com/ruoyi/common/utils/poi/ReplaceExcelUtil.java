package com.ruoyi.common.utils.poi;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.util.CollectionUtils;

import java.io.FileInputStream;
import java.util.*;

/**
 * @author excel列表数据替换
 */
public class ReplaceExcelUtil {


    /**
     * 替换excel列的数据，只用于多导出用
     *
     * @param fis
     * @param listMap
     * @param staRowNum 从第几行开始写入
     * @return
     * @throws Exception
     */
    public static Workbook replaceExcelList(FileInputStream fis, List<Map<String, Object>> listMap, int staRowNum) throws Exception {
        if (CollectionUtils.isEmpty(listMap)) {
            throw new RuntimeException("要打印的数据不能为空！");
        }
        Workbook wb = new XSSFWorkbook(fis);

        Sheet sheet = wb.getSheetAt(0);
        //获取当前行
        Row rowHead = sheet.getRow(staRowNum);
        //获取当前行总列数
        int forSize = rowHead.getPhysicalNumberOfCells();

        List<ReadExcel> list = new ArrayList<>();
        for (int i = 0; i < forSize; i++) {
            /**     增加空值检查和过滤处理逻辑   */
            Cell cell = rowHead.getCell(i);
            String cellValue = (cell != null) ? cell.toString() : "";
            ReadExcel excel = new ReadExcel();
            excel.setKey(cellValue);
            excel.setRowCellNum(i);
            excel.setCell(cell);
            excel.setCellStyle((cell != null) ? cell.getCellStyle() : null);
            list.add(excel);
        }
        int i = 0;
        for (Map<String, Object> mapData : listMap) {
            Row row = sheet.createRow(staRowNum + i);
            buildMap(mapData);
            for (ReadExcel excelBean : list) {
                Cell cell = row.createCell(excelBean.getRowCellNum());
                if (mapData.containsKey(excelBean.getKey())) {
                    cell.setCellValue(String.valueOf(mapData.get(excelBean.getKey())));
                }
                cell.setCellStyle(excelBean.getCellStyle());
            }
            i++;
        }
        return wb;
    }

    /**
     * 构造map,不再用外部替代了
     *
     * @param data
     */
    public static void buildMap(Map<String, Object> data) {
        Iterator<Map.Entry<String, Object>> iterator = data.entrySet().iterator();
        Map<String, Object> newMap = new HashMap<>(data.size());
        while (iterator.hasNext()) {
            Map.Entry<String, Object> entry = iterator.next();
            String newKey = "${" + entry.getKey() + "}";
            newMap.put(newKey, entry.getValue());
            iterator.remove();
        }
        data.putAll(newMap);
    }
}