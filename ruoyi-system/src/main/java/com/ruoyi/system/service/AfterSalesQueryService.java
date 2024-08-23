package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;

import java.util.List;

/**
 * 销售单据 业务层
 *
 * @author KrityCat
 */
public interface AfterSalesQueryService {

    /**
     * @param bo 单据信息
     * @return 销售头单查询
     */
    List<HeadService> salesHeadServiceQuery(HeadService bo);

    /**
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    List<DetailService> salesDetailServiceQuery(DetailService bo);

    /**
     * @param systematicService 系统单号
     * @return 单据详情
     */
    HeadService selectSalesOrderById(String systematicService);

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delAfterSales(List<DetailService> bo);
}
