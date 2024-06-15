package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.Warehouse;

import java.util.List;

public interface WarehouseMapper {
    /**
     * 仓库资料查询
     */
    List<Warehouse> WarehouseQuery(Warehouse bo);

    /**
     * 仓库详情查询
     */
    Warehouse selectWarehouseById(Long warehouseId);

    /**
     * 仓库名称查询
     */
    Warehouse selectWarehouseByWarehouseName(String warehouseName);

    /**
     * 仓库资料新增
     */
    int insertWarehouse(Warehouse bo);

    /**
     * 仓库资料修改
     */
    int updateWarehouse(Warehouse bo);

    /**
     * 仓库资料删除
     */
    int deleteWarehouseByIds(Long[] warehouseId);


}
