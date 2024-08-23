package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.domain.entity.OrderFrom;

import java.util.List;

/**
 * 采购订单 业务层
 *
 * @author KrityCat
 */
public interface PurchaseOrderProcessingService {

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    HeadOrderForm selectPurchaseOrderFormById(String systematicOrderForm);

    /**
     * @param bo 订单信息
     * @return 保存采购订单信息
     */
    int savePurchaseOrderForm(OrderFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delPurchaseOrderForm(List<DetailOrderForm> bo);

}
