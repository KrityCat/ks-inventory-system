package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;

import java.util.List;

/**
 * 采购订单 业务层
 *
 * @author KrityCat
 */
public interface PurchaseOrderQueryService {

    /**
     * @param bo 订单信息
     * @return 采购头单查询
     */
    List<HeadOrderForm> purchaseHeadOrderFormQuery(HeadOrderForm bo);

    /**
     * @param bo 订单信息
     * @return 采购明细单查询
     */
    List<DetailOrderForm> purchaseDetailOrderFormQuery(DetailOrderForm bo);

    /**
     * @param systematicOrderForm 系统单号
     * @return 采购订单详情
     */
    HeadOrderForm selectPurchaseOrderFormById(String systematicOrderForm);

    /**
     * @param bo 单据信息
     * @return 删除采购订单信息
     */
    int delPurchaseOrderForm(List<DetailOrderForm> bo);

}
