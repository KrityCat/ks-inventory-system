package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;
import com.ruoyi.common.core.domain.entity.OrderFrom;

import java.util.List;

/**
 * 销售订单制作 业务层
 *
 * @author KrityCat
 */
public interface SalesOrderProcessingService {

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    HeadOrderForm selectSalesOrderFormById(String systematicOrderForm);

    /**
     * @param bo 订单信息
     * @return 保存销售订单信息
     */
    int saveSalesOrderForm(OrderFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除销售订单信息
     */
    int delSalesOrder(List<DetailOrderForm> bo);

}
