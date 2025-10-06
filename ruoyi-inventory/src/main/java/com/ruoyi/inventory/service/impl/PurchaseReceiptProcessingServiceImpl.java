package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.service.PurchaseReceiptProcessingService;
import com.ruoyi.inventory.utils.CommonReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 采购单 业务层处理
 *
 * @author KrityCat
 */
@Service
public class PurchaseReceiptProcessingServiceImpl implements PurchaseReceiptProcessingService {

    private final CommonReceipt commonReceipt;

    @Autowired
    private HeadReceiptMapper headReceiptMapper;

    @Autowired
    public PurchaseReceiptProcessingServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
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
     * @return 保存采购单据信息
     */
    @Override
    public int savePurchaseReceipt(ReceiptFrom bo) {
        commonReceipt.validateParams(bo);
        if (commonReceipt.isNewReceipt(bo)) {
            commonReceipt.handleNewReceipt(bo);
        } else {
            commonReceipt.handleExistingReceipt(bo);
        }
        return 1;
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
