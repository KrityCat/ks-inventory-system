package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

/**
 * 库存单据 业务层
 *
 * @author KrityCat
 */
public interface InventoryReceiptQueryService {

    /**
     * @param bo 单据信息
     * @return 库存单据头表查询
     */
    List<HeadReceipt> headReceiptQuery(HeadReceipt bo);

    /**
     * @param bo 单据信息
     * @return 库存单据明细查询
     */
    List<DetailReceipt> detailReceiptQuery(DetailReceipt bo);

    /**
     * @param bo 单据信息
     * @return 销售金额与毛利润查询
     */
    HeadReceipt salesAmountQuery(HeadReceipt bo);

    /**
     * @param systematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    HeadReceipt selectHeadReceiptById(String systematicReceipt);


    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delInventoryReceipt(List<DetailReceipt> bo);

}
