package com.ruoyi.inventory.service;

import com.ruoyi.common.core.domain.entity.Accessory;

import java.util.List;

/**
 * 配件 业务层
 *
 * @author KrityCat
 */
public interface AccessoryService {
    /**
     * 根据条件分页查询配件列表
     *
     * @param bo 配件信息
     * @return 配件信息集合信息
     */
    List<Accessory> accessoryQuery(Accessory bo);

    /**
     * 根据条件分页查询配件操作列表
     *
     * @param bo 配件信息
     * @return 配件信息集合信息
     */
    List<Accessory> accessoryOperationRecordQuery(Accessory bo);

    /**
     * 通过配件CODE查询配件
     *
     * @param accessoryId 配件ID
     * @return 仓库对象信息
     */
    Accessory selectAccessoryById(Long accessoryId);

    /**
     * 新增配件信息
     *
     * @param bo 配件信息
     * @return 结果
     */
    int insertAccessory(Accessory bo);

    /**
     * 新增配件操作
     *
     * @param bo 配件信息
     * @return 结果
     */
    int insertAccessoryRecord(Accessory bo);

    /**
     * 修改配件信息
     *
     * @param bo 配件信息
     * @return 结果
     */
    int updateAccessory(Accessory bo);

    /**
     * 批量删除配件信息
     *
     * @param accessoryIds 需要删除的配件ID
     * @return 结果
     */
    int deleteAccessoryByIds(Long[] accessoryIds);

}
