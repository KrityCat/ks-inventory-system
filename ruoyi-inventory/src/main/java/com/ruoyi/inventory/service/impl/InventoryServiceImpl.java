package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.InventoryProduct;
import com.ruoyi.common.core.domain.entity.InventorySummary;
import com.ruoyi.inventory.mapper.DetailReceiptMapper;
import com.ruoyi.inventory.mapper.InventoryMapper;
import com.ruoyi.inventory.mapper.InventorySummaryMapper;
import com.ruoyi.inventory.service.InventoryService;
import jakarta.validation.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 库存单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class InventoryServiceImpl implements InventoryService {

    @Autowired
    protected Validator validator;

    @Autowired
    private DetailReceiptMapper detailReceiptMapper;

    @Autowired
    private InventoryMapper inventoryMapper;

    @Autowired
    private InventorySummaryMapper inventorySummaryMapper;

    /**
     * @param bo 单据信息
     * @return 库存货品查询
     */
    @Override
    public List<InventoryProduct> selectInventoryProduct(InventoryProduct bo) {
        return inventoryMapper.selectInventoryProduct(bo);
    }

    /**
     * @param bo 单据信息
     * @return 积压未入库查询
     */
    @Override
    public List<InventoryProduct> selectProductDangerQuery(InventoryProduct bo) {
        return inventoryMapper.selectProductDangerQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 入库锁单数量查询
     */
    @Override
    public List<DetailReceipt> selectLockInventoryQtyByReceipt(DetailReceipt bo) {
        return detailReceiptMapper.selectLockInventoryQtyByReceipt(bo);
    }

    /**
     * @param bo 单据信息
     * @return 单据锁单数量查询
     */
    @Override
    public List<DetailReceipt> selectLockQtyByReceipt(DetailReceipt bo) {
        return detailReceiptMapper.selectLockQtyByReceipt(bo);
    }

    /**
     * @param bo 单据信息
     * @return 货品发生汇总查询
     */
    @Override
    public List<InventorySummary> inventorySummaryQuery(InventorySummary bo) {
        return inventorySummaryMapper.inventorySummaryQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 货品发生明细查询
     */
    @Override
    public List<DetailReceipt> inventoryDetailsQuery(DetailReceipt bo) {
        return detailReceiptMapper.inventoryDetailsQuery(bo);
    }
}
