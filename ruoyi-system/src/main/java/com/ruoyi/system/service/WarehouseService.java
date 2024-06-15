package com.ruoyi.system.service;

import com.ruoyi.common.core.domain.entity.Warehouse;

import java.util.List;

/**
 * 仓库 业务层
 *
 * @author KrityCat
 */
public interface WarehouseService {
    /**
     * 根据条件分页查询用户列表
     *
     * @param bo 仓库信息
     * @return 仓库信息集合信息
     */
    List<Warehouse> WarehouseQuery(Warehouse bo);

    /**
     * 通过仓库ID查询仓库
     *
     * @param warehouseId 仓库ID
     * @return 仓库对象信息
     */
    Warehouse selectWarehouseById(Long warehouseId);

    /**
     * 新增仓库信息
     *
     * @param bo 仓库信息
     * @return 结果
     */
    int insertWarehouse(Warehouse bo);

    /**
     * 修改仓库信息
     *
     * @param bo 仓库信息
     * @return 结果
     */
    int updateWarehouse(Warehouse bo);

    /**
     * 批量删除仓库信息
     *
     * @param warehouseIds 需要删除的仓库ID
     * @return 结果
     */
    int deleteWarehouseByIds(Long[] warehouseIds);

    /**
     * 导入仓库数据
     *
     * @param warehousesList  仓库数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName        操作用户
     * @return 结果
     */
    String importWarehouse(List<Warehouse> warehousesList, Boolean isUpdateSupport, String operName);

}
