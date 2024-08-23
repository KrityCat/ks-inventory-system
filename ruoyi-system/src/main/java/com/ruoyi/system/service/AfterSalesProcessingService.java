package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.DetailService;
import com.ruoyi.common.core.domain.entity.HeadService;
import com.ruoyi.common.core.domain.entity.ServiceFrom;

import java.util.List;

/**
 * 销售单据 业务层
 *
 * @author KrityCat
 */
public interface AfterSalesProcessingService {

    /**
     * @param systematicService 系统单号
     * @return 单据详情
     */
    HeadService selectSalesOrderById(String systematicService);

    /**
     * @param bo 单据信息
     * @return 保存销售出库单据信息
     */
    int saveAfterSales(ServiceFrom bo);

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    int delAfterSales(List<DetailService> bo);
}
