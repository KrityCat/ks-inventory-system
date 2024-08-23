package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;

import java.util.List;

/**
 * 采购单据 业务层
 *
 * @author KrityCat
 */
public interface PurchaseReceiptProcessingService {

    /**
     * 通过系统单号ID查询采购单
     */
    HeadReceipt selectPurchaseOrderById(String warehouseReceiptId);

    /**
     * 保存采购单据信息
     */
    int savePurchaseReceipt(ReceiptFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除采购单据信息
     */
    int delPurchaseReceipt(List<DetailReceipt> bo);
}
