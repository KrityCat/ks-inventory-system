package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailOrderForm;
import com.ruoyi.common.core.domain.entity.HeadOrderForm;

import java.util.List;

/**
 * 销售订单查询 业务层
 *
 * @author KrityCat
 */
public interface SalesOrderQueryService {

    /**
     * @param bo 订单信息
     * @return 销售头单查询
     */
    List<HeadOrderForm> salesHeadOrderFormQuery(HeadOrderForm bo);

    /**
     * @param bo 订单信息
     * @return 销售明细单查询
     */
    List<DetailOrderForm> salesDetailOrderFormQuery(DetailOrderForm bo);

    /**
     * @param systematicOrderForm 系统单号
     * @return 订单详情
     */
    HeadOrderForm selectSalesOrderFormById(String systematicOrderForm);

    /**
     * @param bo 单据信息
     * @return 删除销售订单信息
     */
    int delSalesOrder(List<DetailOrderForm> bo);
}
