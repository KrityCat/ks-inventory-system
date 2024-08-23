package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;

import java.util.List;

/**
 * 销售单据 业务层
 *
 * @author KrityCat
 */
public interface SalesReceiptProcessingService {

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    HeadReceipt selectSalesOrderById(String systematicReceipt);

    /**
     * @param bo 单据信息
     * @return 保存销售单据信息
     */
    int saveSalesReceipt(ReceiptFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除销售单据信息
     */
    int delSalesReceipt(List<DetailReceipt> bo);
}
