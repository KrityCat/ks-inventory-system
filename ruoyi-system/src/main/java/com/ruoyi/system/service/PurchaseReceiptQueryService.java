package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

/**
 * 采购 业务层
 *
 * @author KrityCat
 */
public interface PurchaseReceiptQueryService {
    /**
     * 采购头单查询
     */
    List<HeadReceipt> purchaseHeadReceiptQuery(HeadReceipt bo);

    /**
     * 采购头单查询
     */
    List<DetailReceipt> purchaseDetailReceiptQuery(DetailReceipt bo);

    /**
     * 通过系统单号ID查询采购单
     */
    HeadReceipt selectPurchaseOrderById(String warehouseReceiptId);

    /**
     * @param bo 单据信息
     * @return 删除采购单据信息
     */
    int delPurchaseReceipt(List<DetailReceipt> bo);

}
