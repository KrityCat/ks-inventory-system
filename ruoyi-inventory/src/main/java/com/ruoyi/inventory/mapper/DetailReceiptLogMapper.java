package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;

import java.util.List;

public interface DetailReceiptLogMapper {

    /**
     * 单据明细操作记录表查询
     */
    List<DetailReceipt> selectDetailReceiptLogQuery(DetailReceipt bo);


    /**
     * 单据明细操作记录表新增
     */
    int addDetailReceiptLog(List<DetailReceipt> bo);

    /**
     * 单据明细操作记录表删除
     */
    int delDetailReceiptLog(List<DetailReceipt> bo);
}
