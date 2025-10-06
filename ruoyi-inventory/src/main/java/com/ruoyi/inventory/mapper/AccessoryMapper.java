package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.Accessory;

import java.util.List;

public interface AccessoryMapper {
    /**
     * 配件资料查询
     */
    List<Accessory> accessoryQuery(Accessory bo);

    /**
     * 配件操作查询
     */
    List<Accessory> accessoryOperationRecordQuery(Accessory bo);

    /**
     * 配件详情查询
     */
    Accessory selectAccessoryById(Long productId);

    /**
     * 配件资料新增
     */
    int insertAccessory(Accessory bo);

    /**
     * 配件资料新增
     */
    int insertAccessoryRecord(Accessory bo);

    /**
     * 配件资料修改
     */
    int updateAccessory(Accessory bo);

    /**
     * 配件资料删除
     */
    int deleteAccessoryByIds(Long[] productId);


}
