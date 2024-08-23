package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.SalesReceiptQueryService;
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
    public int delSalesReceipt(List<DetailReceipt> bo) {
        detailReceiptMapper.delDetailReceipt(bo);
        headReceiptMapper.delHeadReceipt(bo);
        inventoryMapper.updateInventory(bo);
        return productMapper.updateInventoryQty(bo);
    }
}
