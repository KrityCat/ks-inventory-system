package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

public interface HeadReceiptLogMapper {
    /**
     * 单据头操作记录表查询
     */
    List<HeadReceipt> headReceiptLogQuery(HeadReceipt bo);

    /**
     * 单据头操作记录表新增
     */
    int addHeadReceiptLog(HeadReceipt bo);

    /**
     * 单据头操作记录表删除
     */
    int delHeadReceiptLog(List<DetailReceipt> bo);

}
