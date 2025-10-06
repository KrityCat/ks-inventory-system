package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.DetailReceiptMapper;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.mapper.InventoryMapper;
import com.ruoyi.inventory.mapper.ProductMapper;
import com.ruoyi.inventory.service.PurchaseReceiptQueryService;
import com.ruoyi.inventory.utils.CommonReceipt;
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

    private final CommonReceipt commonReceipt;
    @Autowired
    private HeadReceiptMapper headReceiptMapper;
    @Autowired
    private DetailReceiptMapper detailReceiptMapper;
    @Autowired
    private InventoryMapper inventoryMapper;
    @Autowired
    private ProductMapper productMapper;

    @Autowired
    public PurchaseReceiptQueryServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
    }

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
    public int delPurchaseReceipt(ReceiptFrom bo) {
        commonReceipt.validateParams(bo);
        commonReceipt.handDelReceipt(bo);
        return 1;
    }

}
