package com.ruoyi.inventory.service;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
import com.ruoyi.common.core.domain.entity.InventorySummary;

import java.util.List;

/**
 * 库存单据 业务层
 *
 * @author KrityCat
 */
public interface InventoryService {

    /**
     * @param bo 单据信息
     * @return 库存货品查询
     */
    List<InventoryProduct> selectInventoryProduct(InventoryProduct bo);

    /**
     * @param bo 单据信息
     * @return 积压未入库查询
     */
    List<InventoryProduct> selectProductDangerQuery(InventoryProduct bo);

    /**
     * @param bo 单据信息
     * @return 入库锁单数量查询
     */
    List<DetailReceipt> selectLockInventoryQtyByReceipt(DetailReceipt bo);

    /**
     * @param bo 单据信息
     * @return 单据锁单数量查询
     */
    List<DetailReceipt> selectLockQtyByReceipt(DetailReceipt bo);

    /**
     * @param bo 单据信息
     * @return 货品发生汇总查询
     */
    List<InventorySummary> inventorySummaryQuery(InventorySummary bo);

    /**
     * @param bo 单据信息
     * @return 货品发生明细查询
     */
    List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo);


}
