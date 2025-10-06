package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.service.InventoryReceiptProcessingService;
import com.ruoyi.inventory.utils.CommonReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 库存单据制作 业务层处理
 *
 * @author KrityCat
 */
@Service
public class InventoryReceiptProcessingServiceImpl implements InventoryReceiptProcessingService {

    private final CommonReceipt commonReceipt;

    @Autowired
    private HeadReceiptMapper headReceiptMapper;

    @Autowired
    public InventoryReceiptProcessingServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
    }

    /**
     * @param SystematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    @Override
    public HeadReceipt selectHeadReceiptById(String SystematicReceipt) {
        return headReceiptMapper.selectHeadReceiptById(SystematicReceipt);
    }

    /**
     * @param bo 单据信息
     * @return 保存库存单据信息
     */
    @Override
    public int saveInventoryReceipt(ReceiptFrom bo) {
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
    public int delInventoryReceipt(ReceiptFrom bo) {
        commonReceipt.validateParams(bo);
        commonReceipt.handDelReceipt(bo);
        return 1;
    }

}
