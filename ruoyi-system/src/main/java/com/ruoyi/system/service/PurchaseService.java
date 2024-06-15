package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;

import java.util.List;

/**
 * 采购 业务层
 *
 * @author KrityCat
 */
public interface PurchaseService {
    /**
     * 采购头单查询
     */
    List<HeadReceipt> PurchaseHeadReceiptQuery(HeadReceipt bo);

    /**
     * 采购头单查询
     */
    List<DetailReceipt> PurchaseDetailReceiptQuery(DetailReceipt bo);

    /**
     * 通过系统单号ID查询采购单
     */
    HeadReceipt selectPurchaseOrderById(String warehouseReceiptId);

    /**
     * 保存采购入库单据信息
     */
    int saveWarehouseReceipt(ReceiptFrom bo);

    /**
     * 保存采购退库单据信息
     */
    int saveRetreatWarehouse(ReceiptFrom bo);


}
