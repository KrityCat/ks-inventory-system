package com.ruoyi.common.utils.poi;

import lombok.Data;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;

/**
 * @author 读取excel的信息并进行存储
 */
@Data
public class ReadExcel {
    /**
     * 当前列的值
     */
    private String key;

    /**
     * 当前列对应的位置
     */
    private Integer rowCellNum;

    /**
     * 当前列的信息
     */
    private Cell cell;

    /**
     * 当前列的样式
     */
    private CellStyle cellStyle;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public int getRowCellNum() {
        return rowCellNum;
    }

    public void setRowCellNum(int rowCellNum) {
        this.rowCellNum = rowCellNum;
    }

    public Cell getCell() {
        return cell;
    }

    public void setCell(Cell cell) {
        this.cell = cell;
    }

    public CellStyle getCellStyle() {
        return cellStyle;
    }

    public void setCellStyle(CellStyle cellStyle) {
        this.cellStyle = cellStyle;
    }
}