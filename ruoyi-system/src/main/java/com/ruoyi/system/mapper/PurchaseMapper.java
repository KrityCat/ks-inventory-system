package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;

import java.util.List;

public interface PurchaseMapper {

    /**
     * 采购头单查询
     */
    List<HeadReceipt> PurchaseHeadReceiptQuery(HeadReceipt bo);

    /**
     * 采购明细查询
     */
    List<DetailReceipt> PurchaseDetailReceiptQuery(DetailReceipt bo);

    /**
     * 采购单详情查询
     */
    HeadReceipt selectPurchaseOrderById(String systematicReceipt);

}
