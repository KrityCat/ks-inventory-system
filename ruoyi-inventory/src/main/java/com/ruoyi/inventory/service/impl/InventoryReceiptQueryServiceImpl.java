package com.ruoyi.inventory.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.inventory.mapper.DetailReceiptMapper;
import com.ruoyi.inventory.mapper.HeadReceiptMapper;
import com.ruoyi.inventory.mapper.InventoryMapper;
import com.ruoyi.inventory.mapper.ProductMapper;
import com.ruoyi.inventory.service.InventoryReceiptQueryService;
import com.ruoyi.inventory.utils.CommonReceipt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 库存单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class InventoryReceiptQueryServiceImpl implements InventoryReceiptQueryService {

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
    public InventoryReceiptQueryServiceImpl(CommonReceipt commonReceipt) {
        this.commonReceipt = commonReceipt;
    }

    /**
     * @param bo 单据信息
     * @return 库存单据头表查询
     */
    @Override
    public List<HeadReceipt> headReceiptQuery(HeadReceipt bo) {
        return headReceiptMapper.headReceiptQuery(bo);
    }

    /**
     * @param bo 单据信息
     * @return 库存单据明细查询
     */
    @Override
    public List<DetailReceipt> detailReceiptQuery(DetailReceipt bo) {
        return detailReceiptMapper.SelectDetailReceiptQuery(bo);
    }


    /**
     * @param systematicReceipt 系统单号
     * @return 库存指定单据查询
     */
    @Override
    public HeadReceipt selectHeadReceiptById(String systematicReceipt) {
        return headReceiptMapper.selectHeadReceiptById(systematicReceipt);
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
