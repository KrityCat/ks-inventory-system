package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.InventoryReceiptQueryService;
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
     * @param bo 单据信息
     * @return 销售金额与毛利润查询
     */
    @Override
    public HeadReceipt salesAmountQuery(HeadReceipt bo) {
        return headReceiptMapper.salesAmountQuery(bo);
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
    public int delInventoryReceipt(List<DetailReceipt> bo) {
        detailReceiptMapper.delDetailReceipt(bo);
        headReceiptMapper.delHeadReceipt(bo);
        inventoryMapper.updateInventory(bo);
        return productMapper.updateInventoryQty(bo);
    }
}
