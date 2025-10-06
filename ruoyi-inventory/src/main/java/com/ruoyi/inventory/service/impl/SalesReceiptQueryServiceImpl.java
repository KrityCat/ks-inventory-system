package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.DetailReceiptMapper;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.mapper.InventoryMapper;
import com.ruoyi.inventory.mapper.ProductMapper;
import com.ruoyi.inventory.service.SalesReceiptQueryService;
import com.ruoyi.inventory.utils.CommonReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 销售单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class SalesReceiptQueryServiceImpl implements SalesReceiptQueryService {

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
    public SalesReceiptQueryServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
    }

    /**
     * @param bo 单据信息
     * @return 销售头单查询
     */
    @Override
    public List<HeadReceipt> SalesHeadReceiptQuery(HeadReceipt bo) {
        return headReceiptMapper.headReceiptQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    @Override
    public List<DetailReceipt> SalesDetailReceiptQuery(DetailReceipt bo) {
        return detailReceiptMapper.SelectDetailReceiptQuery(bo);
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
