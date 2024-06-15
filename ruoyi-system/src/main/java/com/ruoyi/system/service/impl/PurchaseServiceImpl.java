package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.PurchaseMapper;
import com.ruoyi.system.service.PurchaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.Validator;
import java.util.List;

/**
 * 采购单 业务层处理
 *
 * @author KrityCat
 */
@Service
public class PurchaseServiceImpl implements PurchaseService {

    @Autowired
    protected Validator validator;

    @Autowired
    private PurchaseMapper PurchaseMapper;

    @Autowired
    private HeadReceiptMapper HeadReceiptMapper;

    @Autowired
    private DetailReceiptMapper DetailReceiptMapper;

    @Autowired
    private InventoryMapper InventoryMapper;

    /**
     *
     * @param bo 单据信息
     * @return 采购头单查询
     */
    @Override
    public List<HeadReceipt> PurchaseHeadReceiptQuery(HeadReceipt bo) {
        return PurchaseMapper.PurchaseHeadReceiptQuery(bo);
    }

    /**
     *
     * @param bo 单据信息
     * @return 采购明细查询
     */
    @Override
    public List<DetailReceipt> PurchaseDetailReceiptQuery(DetailReceipt bo) {
        return PurchaseMapper.PurchaseDetailReceiptQuery(bo);
    }

    /**
     *
     * @param systematicReceipt 系统单号
     * @return 采购单据ID查询
     */
    @Override
    public HeadReceipt selectPurchaseOrderById(String systematicReceipt) {
        return PurchaseMapper.selectPurchaseOrderById(systematicReceipt);
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存采购入库单据信息
     */
    @Override
    public int saveWarehouseReceipt(ReceiptFrom bo) {
        long count = HeadReceiptMapper.selectHeadReceiptByCount(bo).size();
        List<DetailReceipt> details = bo.getDetails();
        if (count == 0) {
            long sizeInventory = InventoryMapper.selectInventoryById(details).size();
            DetailReceiptMapper.addDetailReceipt(details);
            HeadReceiptMapper.addHeadReceipt(bo);
            if (sizeInventory == 0) {
                InventoryMapper.addInventory(details);
            } else {
                InventoryMapper.updateInventory(details);
            }
            return 1;
        } else {
            DetailReceiptMapper.delDetailReceipt(details);
            DetailReceiptMapper.addDetailReceipt(details);
            HeadReceiptMapper.updateHeadReceipt(bo);
            InventoryMapper.updateInventory(details);
            return 1;
        }
    }

    /**
     *
     * @param bo 单据信息
     * @return 保存采购退库单据信息
     */
    @Override
    public int saveRetreatWarehouse(ReceiptFrom bo) {
        long count = HeadReceiptMapper.selectHeadReceiptByCount(bo).size();
        List<DetailReceipt> details = bo.getDetails();
        if (count == 0) {
            long sizeInventory = InventoryMapper.selectInventoryById(details).size();
            if (sizeInventory == 0) {
                throw new RuntimeException("货品明细中有货品库存为0，货品需入库后才能出库！");
            } else {
                DetailReceiptMapper.addDetailReceipt(details);
                HeadReceiptMapper.addHeadReceipt(bo);
                InventoryMapper.updateInventory(details);
            }
            return 0;
        } else {
            DetailReceiptMapper.delDetailReceipt(details);
            DetailReceiptMapper.addDetailReceipt(details);
            HeadReceiptMapper.updateHeadReceipt(bo);
            return InventoryMapper.updateInventory(details);
        }
    }

}
