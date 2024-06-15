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
public interface SalesService {

    /**
     *
     * @param bo 单据信息
     * @return 销售头单查询
     */
    List<HeadReceipt> SalesHeadReceiptQuery(HeadReceipt bo);

    /**
     *
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    List<DetailReceipt> SalesDetailReceiptQuery(DetailReceipt bo);

    /**
     *
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    HeadReceipt selectSalesOrderById(String systematicReceipt);

    /**
     *
     * @param bo 单据信息
     * @return 保存销售出库单据信息
     */
    int saveSalesOutbound(ReceiptFrom bo);

    /**
     *
     * @param bo 单据信息
     * @return 保存销售退库单据信息
     */
    int saveSalesRetreat(ReceiptFrom bo);

}
