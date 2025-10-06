package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.InventorySummary;

import java.util.List;

public interface InventorySummaryMapper {

    /**
     * 货品发生汇总表查询
     */
    List<InventorySummary> inventorySummaryQuery(InventorySummary bo);

}
