package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.SalesMapper;
import com.ruoyi.system.service.SalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Validator;
import java.util.List;

/**
 * 销售单据 业务层处理
 *
 * @author KrityCat
 */
@Service
public class SalesServiceImpl implements SalesService {

    @Autowired
    protected Validator validator;

    @Autowired
    private SalesMapper SalesMapper;

    @Autowired
    private HeadReceiptMapper HeadReceiptMapper;

    @Autowired
    private DetailReceiptMapper DetailReceiptMapper;

    @Autowired
    private InventoryMapper InventoryMapper;

    /**
     *
     * @param bo 单据信息
     * @return 销售头单查询
     */
    @Override
    public List<HeadReceipt> SalesHeadReceiptQuery(HeadReceipt bo) {
        return SalesMapper.SalesHeadReceiptQuery(bo);
    }

    /**
     *
     * @param bo 单据信息
     * @return 销售明细单查询
     */
    @Override
    public List<DetailReceipt> SalesDetailReceiptQuery(DetailReceipt bo) {
        return SalesMapper.SalesDetailReceiptQuery(bo);
    }

    /**
     * @param systematicReceipt 系统单号
     * @return 单据详情
     */
    @Override
    public HeadReceipt selectSalesOrderById(String systematicReceipt) {
        return SalesMapper.selectSalesOrderById(systematicReceipt);
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存销售出库单据信息
     */
    @Override
    public int saveSalesOutbound(ReceiptFrom bo) {
        long count = HeadReceiptMapper.selectHeadReceiptByCount(bo).size();
        List<DetailReceipt> details = bo.getDetails();
        if (count == 0) {
            DetailReceiptMapper.addDetailReceipt(details);
            return HeadReceiptMapper.addHeadReceipt(bo);
        } else {
            if (bo.getReceiptStatus() == 1) {
                DetailReceiptMapper.delDetailReceipt(details);
                DetailReceiptMapper.addDetailReceipt(details);
                HeadReceiptMapper.updateHeadReceipt(bo);
            } else if (bo.getReceiptStatus() == 2) {
                long sizeInventory = InventoryMapper.selectInventoryById(details).size();
                if (sizeInventory == 0) {
                    throw new RuntimeException("货品明细中有货品库存为0，货品需入库后才能出库！");
                } else {
                    DetailReceiptMapper.delDetailReceipt(details);
                    DetailReceiptMapper.addDetailReceipt(details);
                    HeadReceiptMapper.updateHeadReceipt(bo);
                    InventoryMapper.updateInventory(details);
                }
            }
            return 0;
        }
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存销售退库单据信息
     */
    @Override
    public int saveSalesRetreat(ReceiptFrom bo) {
        long count = HeadReceiptMapper.selectHeadReceiptByCount(bo).size();
        List<DetailReceipt> details = bo.getDetails();
        if (count == 0) {
            DetailReceiptMapper.addDetailReceipt(details);
            return HeadReceiptMapper.addHeadReceipt(bo);
        } else {
            if (bo.getReceiptStatus() == 1) {
                DetailReceiptMapper.delDetailReceipt(details);
                DetailReceiptMapper.addDetailReceipt(details);
            } else if (bo.getReceiptStatus() == 2) {
                long sizeInventory = InventoryMapper.selectInventoryById(details).size();
                DetailReceiptMapper.delDetailReceipt(details);
                DetailReceiptMapper.addDetailReceipt(details);
                HeadReceiptMapper.updateHeadReceipt(bo);
                if (sizeInventory == 0) {
                    InventoryMapper.addInventory(details);
                } else {
                    InventoryMapper.updateInventory(details);
                }
            }
            return 1;
        }
    }
}
