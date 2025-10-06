package com.ruoyi.inventory.mapper;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;

import java.util.List;

public interface InventoryMapper {

    /**
     * 库存货品查询
     */
    List<InventoryProduct> selectInventoryProduct(InventoryProduct bo);

    /**
     * 积压未入库查询
     */
    List<InventoryProduct> selectProductDangerQuery(InventoryProduct bo);

    /**
     * 货品编号查询
     */
    DetailReceipt selectInventoryById(DetailReceipt bo);

    /**
     * 入库货品新增
     */
    int addInInventory(List<DetailReceipt> bo);

    /**
     * 出库货品新增
     */
    int addOutInventory(List<DetailReceipt> bo);

    /**
     * 入库货品修改
     */
    int updateInInventory(List<DetailReceipt> bo);

    /**
     * 出库货品修改
     */
    int updateOutInventory(List<DetailReceipt> bo);

}
