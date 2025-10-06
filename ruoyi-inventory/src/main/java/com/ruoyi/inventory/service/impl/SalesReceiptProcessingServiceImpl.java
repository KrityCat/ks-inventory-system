package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.service.SalesReceiptProcessingService;
import com.ruoyi.inventory.utils.CommonReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 销售单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class SalesReceiptProcessingServiceImpl implements SalesReceiptProcessingService {

    private final CommonReceipt commonReceipt;

    @Autowired
    private HeadReceiptMapper headReceiptMapper;

    @Autowired
    public SalesReceiptProcessingServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
    }

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @Override
    public HeadReceipt selectSalesOrderById(String systematicReceipt) {
        return headReceiptMapper.selectHeadReceiptById(systematicReceipt);
    }

    /**
     * @param bo 单据信息
     * @return 保存销售单据信息
     */
    @Override
    public int saveSalesReceipt(ReceiptFrom bo) {
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
     * @return 删除单据信息
     */
    @Override
    @Transactional
    public int delSalesReceipt(ReceiptFrom bo) {
        commonReceipt.validateParams(bo);
        commonReceipt.handDelReceipt(bo);
        return 1;
    }
}
