package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.PurchaseReceiptQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 采购单 业务层处理
 *
 * @author KrityCat
 */
@Service
public class PurchaseReceiptQueryServiceImpl implements PurchaseReceiptQueryService {

    @Autowired
    private HeadReceiptMapper headReceiptMapper;

    @Autowired
    private DetailReceiptMapper detailReceiptMapper;

    @Autowired
    private InventoryMapper inventoryMapper;

    @Autowired
    private ProductMapper productMapper;

    /**
     * @param bo 单据信息
     * @return 采购头单查询
     */
    @Override
    public List<HeadReceipt> purchaseHeadReceiptQuery(HeadReceipt bo) {
        return headReceiptMapper.headReceiptQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 采购明细查询
     */
    @Override
    public List<DetailReceipt> purchaseDetailReceiptQuery(DetailReceipt bo) {
        return detailReceiptMapper.SelectDetailReceiptQuery(bo);
    }

    /**
     * @param systematicReceipt 系统单号
     * @return 采购单据ID查询
     */
    @Override
    public HeadReceipt selectPurchaseOrderById(String systematicReceipt) {
        return headReceiptMapper.selectHeadReceiptById(systematicReceipt);
    }

    /**
     * @param bo 单据信息
     * @return 删除库存单据信息
     */
    @Override
    @Transactional
    public int delPurchaseReceipt(List<DetailReceipt> bo) {
        detailReceiptMapper.delDetailReceipt(bo);
        headReceiptMapper.delHeadReceipt(bo);
        inventoryMapper.updateInventory(bo);
        return productMapper.updateInventoryQty(bo);
    }

}
