package com.ruoyi.system.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;

import java.util.List;

public interface InventoryMapper {

    /**
     * 库存货品查询
     */
    List<InventoryProduct> selectInventoryProduct(InventoryProduct bo);

    /**
     * 货品编号查询
     */
    List selectInventoryById(List<DetailReceipt> bo);

    /**
     * 入库货品新增
     */
    int addInventory(List<DetailReceipt> bo);

    /**
     * 入库货品修改
     */
    int updateInventory(List<DetailReceipt> bo);

}
