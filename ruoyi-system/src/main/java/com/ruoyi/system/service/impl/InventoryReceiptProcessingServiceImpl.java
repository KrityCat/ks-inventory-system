package com.ruoyi.system.service.impl;

import com.ruoyi.common.core.domain.entity.DetailReceipt;
import com.ruoyi.common.core.domain.entity.HeadReceipt;
import com.ruoyi.common.core.domain.entity.ReceiptFrom;
import com.ruoyi.system.mapper.DetailReceiptMapper;
import com.ruoyi.system.mapper.HeadReceiptMapper;
import com.ruoyi.system.mapper.InventoryMapper;
import com.ruoyi.system.mapper.ProductMapper;
import com.ruoyi.system.service.InventoryReceiptProcessingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Validator;
import java.util.List;

/**
 * 库存单据制作 业务层处理
 *
 * @author KrityCat
 */
@Service
public class InventoryReceiptProcessingServiceImpl implements InventoryReceiptProcessingService {

    @Autowired
    protected Validator validator;

    @Autowired
    private HeadReceiptMapper headReceiptMapper;

    @Autowired
    private DetailReceiptMapper detailReceiptMapper;

    @Autowired
    private InventoryMapper inventoryMapper;

    @Autowired
    private ProductMapper productMapper;

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
        long count = headReceiptMapper.selectHeadReceiptByCount(bo).size();
        List<DetailReceipt> details = bo.getDetails();
        if (count == 0) {
            detailReceiptMapper.addDetailReceipt(details);
            headReceiptMapper.addHeadReceipt(bo);
        } else {
            if (bo.getReceiptStatus() == 1) {
                detailReceiptMapper.delDetailReceipt(details);
                detailReceiptMapper.addDetailReceipt(details);
                headReceiptMapper.updateHeadReceipt(bo);
            } else if (bo.getReceiptStatus() == 2) {
                long sizeInventory = inventoryMapper.selectInventoryById(details).size();
                detailReceiptMapper.delDetailReceipt(details);
                detailReceiptMapper.addDetailReceipt(details);
                headReceiptMapper.updateHeadReceipt(bo);
                if (sizeInventory == 0) {
                    inventoryMapper.addInventory(details);
                } else {
                    inventoryMapper.updateInventory(details);
                }
                productMapper.updateInventoryQty(details);
            }
        }
        return 1;
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
