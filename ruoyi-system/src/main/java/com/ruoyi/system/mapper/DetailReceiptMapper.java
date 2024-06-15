package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;

import java.util.List;

public interface DetailReceiptMapper {

    /**
     * 库存明细表查询
     */
    List<DetailReceipt> SelectDetailReceiptQuery(DetailReceipt bo);

    /**
     * 货品发生汇总表查询
     */
    List<DetailReceipt> inventorySummaryQuery(DetailReceipt bo);

    /**
     * 货品发生明细表查询
     */
    List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo);

    /**
     * 单据明细表新增
     */
    int addDetailReceipt(List<DetailReceipt> bo);

    /**
     * 单据明细表导入新增
     */
    int addImportDetailReceipt(DetailReceipt bo);

    /**
     * 单据明细表修改
     */
    int updateDetailReceipt(List<DetailReceipt> bo);

    /**
     * 单据明细表导入修改
     */
    int updateImportDetailReceipt(DetailReceipt bo);

    /**
     * 单据明细表删除
     */
    int delDetailReceipt(List<DetailReceipt> bo);

}
